import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_item.dart';

part 'base_life_item_params.freezed.dart';
part 'base_life_item_params.g.dart';

@freezed
abstract class BaseLifeItemParams with _$BaseLifeItemParams {
  const factory BaseLifeItemParams({
    @required String key,
    @required LifeItemType type,
    @required int amount,
  }) = _BaseLifeItemParams;

  factory BaseLifeItemParams.fromJson(Map<String, dynamic> json) => _$BaseLifeItemParamsFromJson(json);
}
