import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'target_life_item_params.dart';

part 'gain_life_item_params.freezed.dart';
part 'gain_life_item_params.g.dart';

@freezed
abstract class GainLifeItemParams with _$GainLifeItemParams {
  const factory GainLifeItemParams({List<TargetLifeItemParams> targetItems}) = _GainLifeItemParams;

  factory GainLifeItemParams.fromJson(Map<String, dynamic> json) => _$GainLifeItemParamsFromJson(json);
}
