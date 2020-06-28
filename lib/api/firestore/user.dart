import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Document on Firestore
@freezed
abstract class UserEntity implements _$UserEntity, Entity {
  const factory UserEntity({
    @required String uid,
    @required String displayName,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
    @DocumentReferenceConverter() DocumentReference joinPlayRoom,
  }) = _UserEntity;
  const UserEntity._();

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Document<UserEntity> decode(DocumentSnapshot snapshot) => Document<UserEntity>(
        snapshot.reference,
        UserEntity.fromJson(snapshot.data),
      );
}

class UserEntityField {
  /// uid (by Auth)
  static const uid = 'uid';

  /// displayName (by Auth)
  static const displayName = 'displayName';

  /// 参加中の playRoom
  static const joinPlayRoom = 'joinPlayRoom';
}
