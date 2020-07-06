import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/common/life_event_params/exchange_life_items_params.dart';
import '../../models/common/life_event_params/gain_life_items_params.dart';
import '../../models/common/life_event_params/goal_params.dart';
import '../../models/common/life_event_params/life_event_params.dart';
import '../../models/common/life_event_params/lose_life_items_params.dart';
import '../../models/common/life_event_params/nothing_params.dart';
import '../../models/common/life_event_params/select_direction_params.dart';
import '../../models/common/life_event_params/start_params.dart';
import 'entity.dart';

part 'life_event.freezed.dart';
part 'life_event.g.dart';

@freezed
abstract class LifeEventEntity<T extends LifeEventParams> implements _$LifeEventEntity<T>, Entity {
  const factory LifeEventEntity({
    @required LifeEventType type,
    @required LifeEventTarget target,
    @required @ParamsConverter() T params,
    @Default('') String description,
  }) = _LifeEventEntity<T>;
  const LifeEventEntity._();

  factory LifeEventEntity.fromJson(Map<String, dynamic> json) => _$LifeEventEntityFromJson<T>(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  EmotionCategory get emotionCategory => params.emotionCategory;
  List<InfoCategory> get infoCategories => params.infoCategories;
  bool get isBranch => params.isBranch;
  bool get mustStop => params.mustStop;
  bool get selectableForExecution => params.selectableForExecution;
  bool get requireDiceRoll => params.requireDiceRoll;
  bool get requireToSelectDirectionManually => params.requireToSelectDirectionManually;
}

class ParamsConverter<T extends LifeEventParams> implements JsonConverter<T, Map<String, dynamic>> {
  const ParamsConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (T == ExchangeLifeItemsParams) return ExchangeLifeItemsParams.fromJson(json) as T;
    if (T == GainLifeItemsParams) return GainLifeItemsParams.fromJson(json) as T;
    if (T == GoalParams) return GoalParams.fromJson(json) as T;
    if (T == LoseLifeItemsParams) return LoseLifeItemsParams.fromJson(json) as T;
    if (T == NothingParams) return NothingParams.fromJson(json) as T;
    if (T == SelectDirectionParams) return SelectDirectionParams.fromJson(json) as T;
    if (T == StartParams) return StartParams.fromJson(json) as T;
    throw Exception('unexpected Entity Type: $T');
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

enum LifeEventTarget {
  /// LifeEvent を引き起こした張本人の Human のみ
  myself,

  /// 全ての Human
  all,

  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
