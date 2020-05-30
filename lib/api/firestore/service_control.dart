import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'firestore.dart';

part 'service_control.freezed.dart';
part 'service_control.g.dart';

@freezed
abstract class ServiceControl with _$ServiceControl {
  const factory ServiceControl({
    @required bool isMaintenance,
    @required String requiredMinVersion,
    @TimestampConverter() DateTime updatedAt,
  }) = _ServiceControl;
  factory ServiceControl.fromJson(Map<String, dynamic> json) => _$ServiceControlFromJson(json);
}

const _collectionId = 'serviceControl';

CollectionRef<ServiceControl, Document<ServiceControl>> serviceControlsRef(Store store) => CollectionRef(
      store.firestore.collection(_collectionId),
      decoder: (snapshot) => Document(snapshot.reference, ServiceControl.fromJson(snapshot.data)),
      encoder: (serviceControl) => replacingTimestamp(
        json: serviceControl.toJson(),
        createdAt: serviceControl.updatedAt,
      ),
    );

class ServiceControlField {
  static const isMaintenance = 'isMaintenance';
  static const requiredMinVersion = 'requiredMinVersion';
  static const updatedAt = 'updatedAt';
}
