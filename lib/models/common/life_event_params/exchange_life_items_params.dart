import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_params.dart';
import 'target_life_item_params.dart';

part 'exchange_life_items_params.freezed.dart';
part 'exchange_life_items_params.g.dart';

@freezed
abstract class ExchangeLifeItemsParams extends LifeEventParams implements _$ExchangeLifeItemsParams {
  const factory ExchangeLifeItemsParams(
      {@required List<TargetLifeItemParams> targetItems,
      @required List<TargetLifeItemParams> baseItems}) = _ExchangeLifeItemsParams;
  const ExchangeLifeItemsParams._();

  factory ExchangeLifeItemsParams.fromJson(Map<String, dynamic> json) => _$ExchangeLifeItemsParamsFromJson(json);

  @override
  LifeEventType get type => LifeEventType.exchangeLifeItems;
}
