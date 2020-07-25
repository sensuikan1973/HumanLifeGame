import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'store.dart';
import 'store_entity.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@immutable
@freezed
abstract class UserEntity implements _$UserEntity, StoreEntity {
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

  static Doc<UserEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<UserEntity>(
        store,
        snapshot.reference,
        UserEntity.fromJson(snapshot.data),
      );

  @override
  int get hashCode => uid.hashCode;

  @override
  bool operator ==(Object other) => other is UserEntity && other.uid == uid;
}

enum UserEntityField {
  /// uid (by Auth)
  uid,

  /// displayName (by Auth)
  displayName,

  /// 参加中の playRoom
  joinPlayRoom,
}

extension UserEntityFieldExtension on UserEntityField {
  String get name => describeEnum(this);
}
