import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_item.dart';

part 'target_life_item_params.freezed.dart';
part 'target_life_item_params.g.dart';

@freezed
abstract class TargetLifeItemParams with _$TargetLifeItemParams {
  const factory TargetLifeItemParams({@required String key, LifeItemType type, int amount}) = _TargetLifeItemParams;

  factory TargetLifeItemParams.fromJson(Map<String, dynamic> json) => _$TargetLifeItemParamsFromJson(json);
}
