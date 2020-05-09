import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_event.dart';
import 'life_event_params.dart';
import 'target_life_item_params.dart';

part 'gain_life_items_params.freezed.dart';
part 'gain_life_items_params.g.dart';

@freezed
abstract class GainLifeItemsParams extends LifeEventParams implements _$GainLifeItemsParams {
  const factory GainLifeItemsParams({@required List<TargetLifeItemParams> targetItems}) = _GainLifeItemsParams;
  const GainLifeItemsParams._();

  factory GainLifeItemsParams.fromJson(Map<String, dynamic> json) => _$GainLifeItemsParamsFromJson(json);

  @override
  LifeEventType get type => LifeEventType.gainLifeItems;
}
