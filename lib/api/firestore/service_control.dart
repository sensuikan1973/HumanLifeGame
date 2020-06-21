import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'service_control.freezed.dart';
part 'service_control.g.dart';

/// Document on Firestore
@freezed
abstract class ServiceControl implements _$ServiceControl, Entity {
  const factory ServiceControl({
    @required bool isMaintenance,
    @required String requiredMinVersion,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _ServiceControl;
  const ServiceControl._();

  factory ServiceControl.fromJson(Map<String, dynamic> json) => _$ServiceControlFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Document<ServiceControl> decode(DocumentSnapshot snapshot) => Document<ServiceControl>(
        snapshot.reference,
        ServiceControl.fromJson(snapshot.data),
      );
}

class ServiceControlField {
  /// メンテナス中かどうか
  static const isMaintenance = 'isMaintenance';

  /// 求める最低バージョン
  static const requiredMinVersion = 'requiredMinVersion';
}

/// 特定の Document を Id で参照する用
class ServiceControlDocId {
  /// Web application
  static const web = 'web';
}
