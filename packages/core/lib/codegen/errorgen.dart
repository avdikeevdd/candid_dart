import 'package:antlr4/antlr4.dart';
import 'package:recase/recase.dart';

import 'types.dart' as ts;
import 'types.dart';
import 'visitor.dart';

///
/// Add import to `packages/core/lib/codegen/codegen.dart`:
/// Directive.import('package:hash_talk/core/l10n/generated/l10n.dart'),
///
/// Add code to `packages/core/lib/codegen/codegen.dart`:
/// before line `return DartFormatter(fixes: StyleFix.all).format(code);`:
/// code = HTErrorGenerator(code: code, idlVisitor: idlVisitor).modifyCode();
///
/// Add Method code to `toClass` and `toTupleClass` methods in `packages/core/lib/codegen/codegen.dart`
/// if (HTErrorGenerator.rules(className).any((e) => e))
///   Method(
///     (b) => b
///       ..name = 'getErrorMessage'
///       ..body = Code('return _handle${className.pascalCase}(this);')
///       ..returns = const Reference('String'),
///   ),
///

class HTErrorGenerator {
  HTErrorGenerator({
    required this.code,
    required this.idlVisitor,
  });

  static const l10nPrefix = 'idl';
  // Define which IDL classes must be handled by HTErrorGenerator
  static List<bool> rules(String className) => [
        className.contains('Error'),
        className == 'RejectionCode',
      ];
  static const dartTypes = ['String', 'BigInt', 'int', 'List'];

  final String code;
  final IDLVisitor idlVisitor;

  // Resolve problems like this: typedef LedgerErrorSystemError = CMCErrorSystemError;
  // { OriginalName: MustChangedTo }
  final Map<String, String> _sameObjectsTypeDef = {};

  final List<dynamic> _boolArgs = [];
  final List<dynamic> _dartTypeArgs = [];
  final Map<String, dynamic> _classArgs = {};
  final List<dynamic> _typedefArgs = [];

  List<String> _typedefs = [];
  String _errorsCode = '';

  String modifyCode() {
    _typedefs = idlVisitor.typedefs.values.map((e) => e.key.dartType()).toList();

    for (final entry in idlVisitor.objs.entries) {
      final type = entry.value;
      final className = entry.key;

      if (rules(className).every((e) => !e)) {
        continue;
      }

      _clearArguments();

      final isVariant = type.isVariant;
      final isEnum = type.isEnum;
      final isTuple = type is ts.RecordType && type.isTupleValue;
      final isRecord = type is ts.RecordType && !isTuple;

      _defineSameObjectsTypeDefs(type, className);

      final children = type.children;

      _addArguments(
        children,
        isTuple: isTuple,
        isVariant: isVariant,
      );

      _generateErrorCode(
        className: className,
        isEnum: isEnum,
        isTuple: isTuple,
        isRecord: isRecord,
      );
    }

    return '$code\n\n$_errorsCode';
  }

  void _clearArguments() {
    _boolArgs.clear();
    _classArgs.clear();
    _dartTypeArgs.clear();
    _typedefArgs.clear();
  }

  void _addArguments(
    List<ts.ExprType> children, {
    required bool isVariant,
    required bool isTuple,
  }) {
    for (int i = 0; i < children.length; i++) {
      final child = children[i].child;
      final dartType = child.dartType();
      final argName = isTuple ? 'item${i + 1}' : child.id;

      final isIdType = child is ts.IdType;
      final useBool = (isIdType && isVariant) || dartType == 'null';

      if (useBool) {
        _boolArgs.add(argName?.camelCase);
      } else if (dartTypes.any(dartType.contains)) {
        _dartTypeArgs.add(argName?.camelCase);
      } else if (_typedefs.any(dartType.contains)) {
        _typedefArgs.add(argName?.camelCase);
      } else {
        _classArgs.addEntries({child.dartType(): argName?.camelCase}.entries);
      }
    }
  }

  void _defineSameObjectsTypeDefs(
    ObjectType<RuleContext> type,
    String className,
  ) {
    final sameObjs = idlVisitor.sameObjs;
    if (sameObjs.containsKey(type.did)) {
      final set = sameObjs[type.did]!;
      if (set.length > 1) {
        for (final value in set) {
          if (value != className) {
            _sameObjectsTypeDef.addEntries({value: className}.entries);
          }
        }
      }
    }
  }

  void _generateErrorCode({
    required String className,
    required bool isEnum,
    required bool isTuple,
    required bool isRecord,
  }) {
    final classNamePC = className.pascalCase;
    final code = StringBuffer();

    final functionName = '_handle$classNamePC';
    code.writeln('String $functionName($classNamePC error,) {');

    if (isRecord) {
      _generateErrorCodeForRecord(
        code,
        className: className,
      );
    } else {
      _generateErrorCodeForType(
        code,
        className: className,
        isEnum: isEnum,
        isTuple: isTuple,
      );

      code.writeln();
      code.writeln('return L10n.current.${l10nPrefix}UnknownError;');
    }

    code.writeln('}');

    _errorsCode += code.toString();
  }

  void _generateErrorCodeForRecord(
    StringBuffer code, {
    required String className,
  }) {
    final classNamePC = className.pascalCase;

    final args = StringBuffer();

    for (final boolArg in _boolArgs) {
      args.write('error.$boolArg,');
    }

    for (final dartTypeArg in _dartTypeArgs) {
      args.write('error.$dartTypeArg,');
    }

    for (final typedefArg in _typedefArgs) {
      args.write('error.$typedefArg,');
    }

    for (final e in _classArgs.entries) {
      final entryClassName = e.key;
      final entryClassNamePC = entryClassName.pascalCase;
      final arg = e.value;

      if (entryClassName == 'Tokens') {
        args.write('error.$arg.e8s,');
      } else if (entryClassName == 'Principal') {
        args.write('error.$arg.toString(),');
      } else if (_sameObjectsTypeDef.containsKey(entryClassName)) {
        args.write('_handle${_sameObjectsTypeDef[entryClassName]}(error.$arg!),');
      } else {
        args.write('_handle$entryClassNamePC(error.$arg!),');
      }
    }

    code.writeln('return L10n.current.$l10nPrefix$classNamePC($args);');
  }

  void _generateErrorCodeForType(
    StringBuffer code, {
    required String className,
    required bool isEnum,
    required bool isTuple,
  }) {
    final classNamePC = className.pascalCase;

    for (final boolArg in _boolArgs) {
      final boolArgPC = boolArg.toString().pascalCase;
      code.writeln();

      if (isEnum) {
        code.writeln('if (error == $classNamePC.$boolArg) {');
        code.writeln('return L10n.current.$l10nPrefix$boolArgPC;');
        code.writeln('}');
      } else if (isTuple) {
        code.writeln('if (error == $classNamePC.$boolArg) {');
        code.writeln('return L10n.current.$l10nPrefix$classNamePC$boolArgPC;');
        code.writeln('}');
      } else {
        code.writeln('if (error.$boolArg == true) {');
        code.writeln('return L10n.current.$l10nPrefix$boolArgPC;');
        code.writeln('}');
      }
    }

    for (final dartTypeArg in _dartTypeArgs) {
      final dartTypeArgPC = dartTypeArg.toString().pascalCase;
      code.writeln();

      if (isTuple) {
        code.writeln('if (error.$dartTypeArg != null) {');
        code.writeln(
          'return L10n.current.$l10nPrefix$classNamePC$dartTypeArgPC(error.$dartTypeArg);',
        );
        code.writeln('}');
      } else {
        code.writeln('if (error.$dartTypeArg != null) {');
        code.writeln(
          'return L10n.current.$l10nPrefix$dartTypeArgPC(error.$dartTypeArg);',
        );
        code.writeln('}');
      }
    }

    for (final typedefArg in _typedefArgs) {
      final typedefArgPC = typedefArg.toString().pascalCase;
      code.writeln();

      if (isTuple) {
        code.writeln('if (error.$typedefArg != null) {');
        code.writeln('return L10n.current.$l10nPrefix$classNamePC$typedefArgPC;');
        code.writeln('}');
      } else {
        code.writeln('if (error.$typedefArg != null) {');
        code.writeln('return L10n.current.$l10nPrefix$typedefArgPC;');
        code.writeln('}');
      }
    }

    for (final e in _classArgs.entries) {
      final entryClassName = e.key;
      final entryClassNamePC = entryClassName.pascalCase;
      final arg = e.value;
      final argPC = arg.toString().pascalCase;

      code.writeln();

      if (entryClassName == 'Tokens') {
        code.writeln('if (error.$arg != null) {');
        code.writeln('return L10n.current.$l10nPrefix$argPC(error.$arg.e8s);');
        code.writeln('}');
      } else if (entryClassName == 'Principal') {
        code.writeln('if (error.$arg != null) {');
        code.writeln('return L10n.current.$l10nPrefix$argPC(error.$arg.toString());');
        code.writeln('}');
      } else if (_sameObjectsTypeDef.containsKey(entryClassName)) {
        code.writeln('if (error.$arg != null) {');
        code.writeln('return _handle${_sameObjectsTypeDef[entryClassName]}(error.$arg!);');
        code.writeln('}');
      } else {
        code.writeln('if (error.$arg != null) {');
        code.writeln('return _handle$entryClassNamePC(error.$arg!);');
        code.writeln('}');
      }
    }
  }
}