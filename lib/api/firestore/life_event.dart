import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'life_event.freezed.dart';
part 'life_event.g.dart';

/// Map Value on Firestore
@freezed
abstract class LifeEvent implements _$LifeEvent, Entity {
  const factory LifeEvent({
    @required String type,
    @required String target,
    @required String description,
    @required Map<String, dynamic> params,
  }) = _LifeEvent;
  const LifeEvent._();

  factory LifeEvent.fromJson(Map<String, dynamic> json) => _$LifeEventFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class LifeEventField {
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
