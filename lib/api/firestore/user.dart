import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Document on Firestore
@freezed
abstract class User with _$User {
  const factory User({
    @required String uid,
    @required String displayName,
    @required @DocumentReferenceConverter() DocumentReference joinPlayRoom,
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

  /// 参加中の playRoom
  static const joinPlayRoom = 'joinPlayRoom';
}
