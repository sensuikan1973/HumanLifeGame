import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'life_event.freezed.dart';
part 'life_event.g.dart';

@freezed
abstract class LifeEventEntity implements _$LifeEventEntity, Entity {
  const factory LifeEventEntity({
    @required String type,
    @required String target,
    @required String description,
    @required Map<String, dynamic> params,
  }) = _LifeEventEntity;
  const LifeEventEntity._();

  factory LifeEventEntity.fromJson(Map<String, dynamic> json) => _$LifeEventEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class LifeEventEntityField {
  /// Event の種別
  static const type = 'type';

  /// Event の対象
  static const target = 'target';

  /// Event の自由説明文
  static const description = 'description';

  /// Event 実行時のパラメータ
  ///
  /// type によって中身は異なる
  static const params = 'params';
}
