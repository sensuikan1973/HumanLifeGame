import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'store.dart';
import 'store_entity.dart';

part 'service_control.freezed.dart';
part 'service_control.g.dart';

@immutable
@freezed
abstract class ServiceControlEntity implements _$ServiceControlEntity, StoreEntity {
  const factory ServiceControlEntity({
    @required bool isMaintenance,
    @required String requiredMinVersion,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _ServiceControlEntity;
  const ServiceControlEntity._();

  factory ServiceControlEntity.fromJson(Map<String, dynamic> json) => _$ServiceControlEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<ServiceControlEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<ServiceControlEntity>(
        store,
        snapshot.reference,
        ServiceControlEntity.fromJson(snapshot.data),
      );
}

enum ServiceControlEntityField {
  /// メンテナス中かどうか
  isMaintenance,

  /// 求める最低バージョン
  requiredMinVersion,
}

extension ServiceControlEntityFieldExtension on ServiceControlEntityField {
  String get name => describeEnum(this);
}

/// 特定の Document を Id で参照する用
enum ServiceControlDocId {
  /// Web application
  web,
}

extension ServiceControlDocIdExtension on ServiceControlDocId {
  String get name => describeEnum(this);
}
