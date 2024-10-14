// coverage:ignore-file
// ignore_for_file: type=lint, unnecessary_null_comparison, unnecessary_non_null_assertion, unused_field
// ======================================
// GENERATED CODE - DO NOT MODIFY BY HAND
// ======================================

import 'dart:async';
import 'dart:typed_data';
import 'package:agent_dart/agent_dart.dart';
import 'package:collection/collection.dart';
import 'package:hash_talk/core/l10n/generated/l10n.dart';
import 'package:meta/meta.dart';

class Drc20IDLActor {
  const Drc20IDLActor._();

  /// ```Candid
  ///   standard: () -> (text) query
  /// ```
  static Future<String> standard(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'standard';
    final response = await actor.getFunc(method)!(request);
    return response;
  }

  /// ```Candid
  ///   drc20_balanceOf: (Address) -> (Amount) query
  /// ```
  static Future<Amount> drc20BalanceOf(
    CanisterActor actor,
    Address arg,
  ) async {
    final request = [arg];
    const method = 'drc20_balanceOf';
    final response = await actor.getFunc(method)!(request);
    return response is BigInt ? response : BigInt.from(response);
  }

  /// ```Candid
  ///   drc20_decimals: () -> (nat8) query
  /// ```
  static Future<int> drc20Decimals(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'drc20_decimals';
    final response = await actor.getFunc(method)!(request);
    return response;
  }

  /// ```Candid
  ///   drc20_fee: () -> (Amount) query
  /// ```
  static Future<Amount> drc20Fee(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'drc20_fee';
    final response = await actor.getFunc(method)!(request);
    return response is BigInt ? response : BigInt.from(response);
  }

  /// ```Candid
  ///   drc20_metadata: () -> (vec Metadata) query
  /// ```
  static Future<List<Metadata>> drc20Metadata(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'drc20_metadata';
    final response = await actor.getFunc(method)!(request);
    return (response as List).map((e) {
      return Metadata.fromJson(e);
    }).toList();
  }

  /// ```Candid
  ///   drc20_name: () -> (text) query
  /// ```
  static Future<String> drc20Name(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'drc20_name';
    final response = await actor.getFunc(method)!(request);
    return response;
  }

  /// ```Candid
  ///   drc20_symbol: () -> (text) query
  /// ```
  static Future<String> drc20Symbol(
    CanisterActor actor,
  ) async {
    const request = [];
    const method = 'drc20_symbol';
    final response = await actor.getFunc(method)!(request);
    return response;
  }

  /// ```Candid
  ///   drc20_transfer: (To, Amount, opt Nonce, Sa: opt vec nat8, opt Data) -> (TxnResult)
  /// ```
  static Future<TxnResult> drc20Transfer(
    CanisterActor actor,
    Drc20TransferArg arg,
  ) async {
    final request = arg.toJson();
    const method = 'drc20_transfer';
    final response = await actor.getFunc(method)!(request);
    return TxnResult.fromJson(response);
  }
}

class Drc20IDL {
  const Drc20IDL._();

  /// [_TxnResult] defined in Candid
  /// ```Candid
  ///   type TxnResult = variant { err: record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }; ok: Txid };
  /// ```
  static final VariantClass _TxnResult = IDL.Variant({
    'err': IDL.Record({
      'code': IDL.Variant({
        'DuplicateExecutedTransfer': IDL.Null,
        'InsufficientAllowance': IDL.Null,
        'InsufficientBalance': IDL.Null,
        'InsufficientGas': IDL.Null,
        'LockedTransferExpired': IDL.Null,
        'NoLockedTransfer': IDL.Null,
        'NonceError': IDL.Null,
        'UndefinedError': IDL.Null,
      }),
      'message': IDL.Text,
    }),
    'ok': _Txid,
  });

  /// [_Txid] defined in Candid
  /// ```Candid
  ///   type Txid = blob;
  /// ```
  static final _Txid = IDL.Vec(IDL.Nat8);

  /// [_To] defined in Candid
  /// ```Candid
  ///   type To = text;
  /// ```
  static final _To = IDL.Text;

  /// [_Nonce] defined in Candid
  /// ```Candid
  ///   type Nonce = nat;
  /// ```
  static final _Nonce = IDL.Nat;

  /// [_Metadata] defined in Candid
  /// ```Candid
  ///   type Metadata = record { content: text; name: text };
  /// ```
  static final RecordClass _Metadata = IDL.Record({
    'content': IDL.Text,
    'name': IDL.Text,
  });

  /// [_Data] defined in Candid
  /// ```Candid
  ///   type Data = blob;
  /// ```
  static final _Data = IDL.Vec(IDL.Nat8);

  /// [_Amount] defined in Candid
  /// ```Candid
  ///   type Amount = nat;
  /// ```
  static final _Amount = IDL.Nat;

  /// [_Address] defined in Candid
  /// ```Candid
  ///   type Address = text;
  /// ```
  static final _Address = IDL.Text;

  static final ServiceClass idl = IDL.Service({
    'standard': IDL.Func(
      [],
      [IDL.Text],
      ['query'],
    ),
    'drc20_balanceOf': IDL.Func(
      [_Address],
      [_Amount],
      ['query'],
    ),
    'drc20_decimals': IDL.Func(
      [],
      [IDL.Nat8],
      ['query'],
    ),
    'drc20_fee': IDL.Func(
      [],
      [_Amount],
      ['query'],
    ),
    'drc20_metadata': IDL.Func(
      [],
      [
        IDL.Vec(
          _Metadata,
        )
      ],
      ['query'],
    ),
    'drc20_name': IDL.Func(
      [],
      [IDL.Text],
      ['query'],
    ),
    'drc20_symbol': IDL.Func(
      [],
      [IDL.Text],
      ['query'],
    ),
    'drc20_transfer': IDL.Func(
      [
        _To,
        _Amount,
        IDL.Opt(
          _Nonce,
        ),
        IDL.Opt(
          IDL.Vec(
            IDL.Nat8,
          ),
        ),
        IDL.Opt(
          _Data,
        )
      ],
      [_TxnResult],
      [],
    ),
  });
}

/// [TxnResultErrCode] defined in Candid
/// ```Candid
///   variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }
/// ```
enum TxnResultErrCode {
  /// [duplicateExecutedTransfer] defined in Candid: `DuplicateExecutedTransfer`
  duplicateExecutedTransfer('DuplicateExecutedTransfer'),

  /// [insufficientAllowance] defined in Candid: `InsufficientAllowance`
  insufficientAllowance('InsufficientAllowance'),

  /// [insufficientBalance] defined in Candid: `InsufficientBalance`
  insufficientBalance('InsufficientBalance'),

  /// [insufficientGas] defined in Candid: `InsufficientGas`
  insufficientGas('InsufficientGas'),

  /// [lockedTransferExpired] defined in Candid: `LockedTransferExpired`
  lockedTransferExpired('LockedTransferExpired'),

  /// [noLockedTransfer] defined in Candid: `NoLockedTransfer`
  noLockedTransfer('NoLockedTransfer'),

  /// [nonceError] defined in Candid: `NonceError`
  nonceError('NonceError'),

  /// [undefinedError] defined in Candid: `UndefinedError`
  undefinedError('UndefinedError');

  const TxnResultErrCode(this.name);

  factory TxnResultErrCode.fromJson(Map json) {
    final key = json.keys.first;
    return TxnResultErrCode.values.firstWhere((e) => e.name == key);
  }

  final String name;

  bool get isDuplicateExecutedTransfer =>
      this == TxnResultErrCode.duplicateExecutedTransfer;
  bool get isInsufficientAllowance =>
      this == TxnResultErrCode.insufficientAllowance;
  bool get isInsufficientBalance =>
      this == TxnResultErrCode.insufficientBalance;
  bool get isInsufficientGas => this == TxnResultErrCode.insufficientGas;
  bool get isLockedTransferExpired =>
      this == TxnResultErrCode.lockedTransferExpired;
  bool get isNoLockedTransfer => this == TxnResultErrCode.noLockedTransfer;
  bool get isNonceError => this == TxnResultErrCode.nonceError;
  bool get isUndefinedError => this == TxnResultErrCode.undefinedError;
  Map<String, dynamic> toJson() {
    return {name: null};
  }

  String getErrorMessage() {
    return _handleTxnResultErrCode(this);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

/// [TxnResultErr] defined in Candid
/// ```Candid
///   record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }
/// ```
@immutable
class TxnResultErr {
  const TxnResultErr({
    /// [code] defined in Candid: `code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }`
    required this.code,

    /// [message] defined in Candid: `message: text`
    required this.message,
  });

  factory TxnResultErr.fromJson(Map json) {
    return TxnResultErr(
      code: TxnResultErrCode.fromJson(
        json['code'],
      ),
      message: json['message'],
    );
  }

  /// [code] defined in Candid: `code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }`
  final TxnResultErrCode code;

  /// [message] defined in Candid: `message: text`
  final String message;

  Map<String, dynamic> toJson() {
    final code = this.code;
    final message = this.message;
    return {
      'code': code,
      'message': message,
    };
  }

  String getErrorMessage() {
    return _handleTxnResultErr(this);
  }

  TxnResultErr copyWith({
    /// [code] defined in Candid: `code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }`
    TxnResultErrCode? code,

    /// [message] defined in Candid: `message: text`
    String? message,
  }) {
    return TxnResultErr(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TxnResultErr &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hashAll([runtimeType, code, message]);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// [TxnResult] defined in Candid
/// ```Candid
///   variant { err: record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }; ok: Txid }
/// ```
@immutable
class TxnResult {
  const TxnResult({
    /// [err] defined in Candid: `err: record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }`
    this.err,

    /// [ok] defined in Candid: `ok: Txid`
    this.ok,
  });

  factory TxnResult.fromJson(Map json) {
    return TxnResult(
      err: json['err'] == null
          ? null
          : TxnResultErr.fromJson(
              json['err'],
            ),
      ok: json['ok'] == null
          ? null
          : json['ok'] is Uint8List
              ? json['ok']
              : Uint8List.fromList((json['ok'] as List).cast()),
    );
  }

  /// [err] defined in Candid: `err: record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }`
  final TxnResultErr? err;

  /// [ok] defined in Candid: `ok: Txid`
  final Txid? ok;

  Map<String, dynamic> toJson() {
    final err = this.err;
    final ok = this.ok;
    return {
      if (err != null) 'err': err,
      if (ok != null) 'ok': ok,
    };
  }

  String getErrorMessage() {
    return _handleTxnResult(this);
  }

  TxnResult copyWith({
    /// [err] defined in Candid: `err: record { code: variant { DuplicateExecutedTransfer; InsufficientAllowance; InsufficientBalance; InsufficientGas; LockedTransferExpired; NoLockedTransfer; NonceError; UndefinedError }; message: text }`
    TxnResultErr? err,

    /// [ok] defined in Candid: `ok: Txid`
    Txid? ok,
  }) {
    return TxnResult(
      err: err ?? this.err,
      ok: ok ?? this.ok,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TxnResult &&
            (identical(other.err, err) || other.err == err) &&
            (identical(other.ok, ok) || other.ok == ok));
  }

  @override
  int get hashCode => Object.hashAll([runtimeType, err, ok]);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// [Metadata] defined in Candid
/// ```Candid
///   record { content: text; name: text }
/// ```
@immutable
class Metadata {
  const Metadata({
    /// [content] defined in Candid: `content: text`
    required this.content,

    /// [name] defined in Candid: `name: text`
    required this.name,
  });

  factory Metadata.fromJson(Map json) {
    return Metadata(
      content: json['content'],
      name: json['name'],
    );
  }

  /// [content] defined in Candid: `content: text`
  final String content;

  /// [name] defined in Candid: `name: text`
  final String name;

  Map<String, dynamic> toJson() {
    final content = this.content;
    final name = this.name;
    return {
      'content': content,
      'name': name,
    };
  }

  String getErrorMessage() {
    return _handleMetadata(this);
  }

  Metadata copyWith({
    /// [content] defined in Candid: `content: text`
    String? content,

    /// [name] defined in Candid: `name: text`
    String? name,
  }) {
    return Metadata(
      content: content ?? this.content,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Metadata &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hashAll([runtimeType, content, name]);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// [Drc20TransferArg] defined in Candid
/// ```Candid
///   (To, Amount, opt Nonce, Sa: opt vec nat8, opt Data)
/// ```
@immutable
class Drc20TransferArg {
  const Drc20TransferArg(
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
  );

  factory Drc20TransferArg.fromJson(List<dynamic> tuple) {
    return Drc20TransferArg(
      tuple[0],
      tuple[1] is BigInt ? tuple[1] : BigInt.from(tuple[1]),
      (tuple[2] as List).map((e) {
        return e == null
            ? null
            : e is BigInt
                ? e
                : BigInt.from(e);
      }).firstOrNull,
      (tuple[3] as List).map((e) {
        return e == null
            ? null
            : e is Uint8List
                ? e
                : Uint8List.fromList((e as List).cast());
      }).firstOrNull,
      (tuple[4] as List).map((e) {
        return e == null
            ? null
            : e is Uint8List
                ? e
                : Uint8List.fromList((e as List).cast());
      }).firstOrNull,
    );
  }

  /// [item1] defined in Candid: `To`
  final To item1;

  /// [item2] defined in Candid: `Amount`
  final Amount item2;

  /// [item3] defined in Candid: `opt Nonce`
  final Nonce? item3;

  /// [item4] defined in Candid: `Sa: opt vec nat8`
  final Uint8List? item4;

  /// [item5] defined in Candid: `opt Data`
  final Data? item5;

  List<dynamic> toJson() {
    final item1 = this.item1;
    final item2 = this.item2;
    final item3 = this.item3;
    final item4 = this.item4;
    final item5 = this.item5;
    return [
      item1,
      item2,
      [if (item3 != null) item3],
      [if (item4 != null) item4],
      [if (item5 != null) item5],
    ];
  }

  String getErrorMessage() {
    return _handleDrc20TransferArg(this);
  }

  Drc20TransferArg copyWith({
    /// [item1] defined in Candid: `To`
    To? item1,

    /// [item2] defined in Candid: `Amount`
    Amount? item2,

    /// [item3] defined in Candid: `opt Nonce`
    Nonce? item3,

    /// [item4] defined in Candid: `Sa: opt vec nat8`
    Uint8List? item4,

    /// [item5] defined in Candid: `opt Data`
    Data? item5,
  }) {
    return Drc20TransferArg(
      item1 ?? this.item1,
      item2 ?? this.item2,
      item3 ?? this.item3,
      item4 ?? this.item4,
      item5 ?? this.item5,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Drc20TransferArg &&
            (identical(other.item1, item1) || other.item1 == item1) &&
            (identical(other.item2, item2) || other.item2 == item2) &&
            (identical(other.item3, item3) || other.item3 == item3) &&
            (identical(other.item4, item4) || other.item4 == item4) &&
            (identical(other.item5, item5) || other.item5 == item5));
  }

  @override
  int get hashCode =>
      Object.hashAll([runtimeType, item1, item2, item3, item4, item5]);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// [Txid] defined in Candid
/// ```Candid
///   type Txid = blob;
/// ```
typedef Txid = Uint8List;

/// [To] defined in Candid
/// ```Candid
///   type To = text;
/// ```
typedef To = String;

/// [Nonce] defined in Candid
/// ```Candid
///   type Nonce = nat;
/// ```
typedef Nonce = BigInt;

/// [Data] defined in Candid
/// ```Candid
///   type Data = blob;
/// ```
typedef Data = Uint8List;

/// [Amount] defined in Candid
/// ```Candid
///   type Amount = nat;
/// ```
typedef Amount = BigInt;

/// [Address] defined in Candid
/// ```Candid
///   type Address = text;
/// ```
typedef Address = String;

String _handleTxnResultErrCode(
  TxnResultErrCode error,
) {
  if (error == TxnResultErrCode.duplicateExecutedTransfer) {
    return L10n.current.idlDuplicateExecutedTransfer;
  }

  if (error == TxnResultErrCode.insufficientAllowance) {
    return L10n.current.idlInsufficientAllowance;
  }

  if (error == TxnResultErrCode.insufficientBalance) {
    return L10n.current.idlInsufficientBalance;
  }

  if (error == TxnResultErrCode.insufficientGas) {
    return L10n.current.idlInsufficientGas;
  }

  if (error == TxnResultErrCode.lockedTransferExpired) {
    return L10n.current.idlLockedTransferExpired;
  }

  if (error == TxnResultErrCode.noLockedTransfer) {
    return L10n.current.idlNoLockedTransfer;
  }

  if (error == TxnResultErrCode.nonceError) {
    return L10n.current.idlNonceError;
  }

  if (error == TxnResultErrCode.undefinedError) {
    return L10n.current.idlUndefinedError;
  }

  return L10n.current.idlUnknownError;
}

String _handleTxnResultErr(
  TxnResultErr error,
) {
  return L10n.current.idlTxnResultErr(
    error.message.toString(),
    _handleTxnResultErrCode(
      error.code!,
    ),
  );
}

String _handleTxnResult(
  TxnResult error,
) {
  if (error.ok != null) {
    return L10n.current.idlOk;
  }

  if (error.err != null) {
    return _handleTxnResultErr(
      error.err!,
    );
  }

  return L10n.current.idlUnknownError;
}

String _handleMetadata(
  Metadata error,
) {
  return L10n.current.idlMetadata(
    error.content.toString(),
    error.name.toString(),
  );
}
