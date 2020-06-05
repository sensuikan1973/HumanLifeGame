import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required String uid,
    @required String displayName,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @visibleForTesting
  static const collectionId = 'user';
}

class UserField {
  /// uid (by Auth)
  static const uid = 'uid';

  /// displayName (by Auth)
  static const displayName = 'displayName';

  /// 作成時刻
  static const createdAt = 'createdAt';

  /// 更新時刻
  static const updatedAt = 'updatedAt';
}
