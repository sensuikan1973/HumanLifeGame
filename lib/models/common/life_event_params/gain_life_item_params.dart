import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_item.dart';

part 'gain_life_item_params.freezed.dart';
part 'gain_life_item_params.g.dart';

@freezed
abstract class GainLifeItemParams with _$GainLifeItemParams {
  const factory GainLifeItemParams({List<GainLifeItemTarget> targetItems}) = _GainLifeItemParams;

  factory GainLifeItemParams.fromJson(Map<String, dynamic> json) => _$GainLifeItemParamsFromJson(json);
}

@freezed // See: https://github.com/rrousselGit/freezed/issues/100
abstract class GainLifeItemTarget with _$GainLifeItemTarget {
  const factory GainLifeItemTarget({String key, LifeItemType type, int amount}) = _GainLifeItemTarget;

  factory GainLifeItemTarget.fromJson(Map<String, dynamic> json) => _$GainLifeItemTargetFromJson(json);
}
