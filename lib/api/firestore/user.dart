import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Document on Firestore
@freezed
abstract class User implements _$User, Entity {
  const factory User({
    @required String uid,
    @required String displayName,
    @required @DocumentReferenceConverter() DocumentReference joinPlayRoom,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _User;
  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class UserField {
  /// uid (by Auth)
  static const uid = 'uid';

  /// displayName (by Auth)
  static const displayName = 'displayName';

  /// 参加中の playRoom
  static const joinPlayRoom = 'joinPlayRoom';
}
