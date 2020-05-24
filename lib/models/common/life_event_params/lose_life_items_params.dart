import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_params.dart';
import 'target_life_item_params.dart';

part 'lose_life_items_params.freezed.dart';
part 'lose_life_items_params.g.dart';

@freezed
abstract class LoseLifeItemsParams extends LifeEventParams implements _$LoseLifeItemsParams {
  const factory LoseLifeItemsParams({@required List<TargetLifeItemParams> targetItems}) = _LoseLifeItemsParams;
  const LoseLifeItemsParams._();

  factory LoseLifeItemsParams.fromJson(Map<String, dynamic> json) => _$LoseLifeItemsParamsFromJson(json);

  @override
  LifeEventType get type => LifeEventType.loseLifeItems;
}
