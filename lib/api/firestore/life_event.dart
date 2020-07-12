import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_event_emotion_category.dart';
import '../../entities/life_event_notice_category.dart';
import '../../entities/life_event_params/exchange_life_items_params.dart';
import '../../entities/life_event_params/gain_life_items_params.dart';
import '../../entities/life_event_params/goal_params.dart';
import '../../entities/life_event_params/life_event_params.dart';
import '../../entities/life_event_params/lose_life_items_params.dart';
import '../../entities/life_event_params/nothing_params.dart';
import '../../entities/life_event_params/select_direction_params.dart';
import '../../entities/life_event_params/start_params.dart';
import '../../entities/life_event_target.dart';
import '../../entities/life_event_type.dart';
import 'entity.dart';

part 'life_event.freezed.dart';
part 'life_event.g.dart';

@immutable
@freezed
abstract class LifeEventEntity<T extends LifeEventParams> implements _$LifeEventEntity<T>, Entity {
  const factory LifeEventEntity({
    @required LifeEventType type,
    @required LifeEventTarget target,
    @required @_ParamsConverter() T params,
    @Default('') String description,
  }) = _LifeEventEntity<T>;
  const LifeEventEntity._();

  factory LifeEventEntity.fromJson(Map<String, dynamic> json) => _$LifeEventEntityFromJson<T>(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  LifeEventEmotionCategory get emotionCategory => params.emotionCategory;
  List<LifeEventNoticeCategory> get infoCategories => params.noticeCategories;
  bool get isBranch => params.isBranch;
  bool get mustStop => params.mustStop;
  bool get selectableForExecution => params.selectableForExecution;
  bool get requireDiceRoll => params.requireDiceRoll;
  bool get requireToSelectDirectionManually => params.requireToSelectDirectionManually;
}

class _ParamsConverter<T extends LifeEventParams> implements JsonConverter<T, Map<String, dynamic>> {
  const _ParamsConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == describeEnum(LifeEventType.exchangeLifeItems)) return ExchangeLifeItemsParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.gainLifeItems)) return GainLifeItemsParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.goal)) return GoalParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.loseLifeItems)) return LoseLifeItemsParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.nothing)) return NothingParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.selectDirection)) return SelectDirectionParams.fromJson(json) as T;
    if (type == describeEnum(LifeEventType.start)) return StartParams.fromJson(json) as T;
    throw Exception('unexpected Params type: $type');
  }

  @override
  Map<String, dynamic> toJson(T object) => object.toJson();
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
