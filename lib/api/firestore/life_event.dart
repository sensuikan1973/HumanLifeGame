import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'life_event.freezed.dart';
part 'life_event.g.dart';

@freezed
abstract class LifeEvent with _$LifeEvent {
  const factory LifeEvent({
    @required String type,
    @required String target,
    @required String description,
    @required Map<String, dynamic> params,
  }) = _LifeEvent;
  factory LifeEvent.fromJson(Map<String, dynamic> json) => _$LifeEventFromJson(json);

  @visibleForTesting
  static const collectionId = 'LifeEvent';
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
