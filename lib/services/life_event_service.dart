import 'package:flutter/foundation.dart';

import '../api/firestore/life_event.dart';
import '../api/firestore/life_item.dart';
import '../entities/life_event_params/exchange_life_items_params.dart';
import '../entities/life_event_params/gain_life_items_params.dart';
import '../entities/life_event_params/lose_life_items_params.dart';
import '../entities/life_event_type.dart';
import '../models/play_room/life_stage.dart';

@immutable
class LifeEventService {
  const LifeEventService();

  LifeStageModel executeEvent(LifeEventEntity lifeEvent, LifeStageModel lifeStage) {
    switch (lifeEvent.type) {
      case LifeEventType.nothing:
        // TODO: Handle this case.
        break;
      case LifeEventType.start:
        // TODO: Handle this case.
        break;
      case LifeEventType.goal:
        // TODO: Handle this case.
        break;
      case LifeEventType.selectDirection:
        // TODO: Handle this case.
        break;
      case LifeEventType.selectDirectionPerDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.selectDirectionPerLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItems:
        final params = lifeEvent.params as GainLifeItemsParams;
        final items = [
          ...lifeStage.lifeItems,
          for (final item in params.targetItems) LifeItemEntity(key: item.key, type: item.type, amount: item.amount),
        ];
        return lifeStage.copyWith(lifeItems: items);
      case LifeEventType.gainLifeItemsPerOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemsPerDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemsIfExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemsIfNotExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.exchangeLifeItems:
        final params = lifeEvent.params as ExchangeLifeItemsParams;
        final items = [
          ...lifeStage.lifeItems,
          ..._exchangeLifeItems(lifeStage.lifeItems, params),
        ];
        return lifeStage.copyWith(lifeItems: items);
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItems:
        final params = lifeEvent.params as LoseLifeItemsParams;
        final items = [
          ...lifeStage.lifeItems,
          for (final item in params.targetItems) LifeItemEntity(key: item.key, type: item.type, amount: -item.amount),
        ];
        return lifeStage.copyWith(lifeItems: items);
      case LifeEventType.loseLifeItemsPerDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemsPerOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemsIfExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemsIfNotExistOtherLifeItem:
        // TODO: Handle this case.
        break;
    }
    return lifeStage.copyWith();
  }

  List<LifeItemEntity> _exchangeLifeItems(List<LifeItemEntity> lifeItems, ExchangeLifeItemsParams params) {
    final items = <LifeItemEntity>[];

    for (final baseItem in params.baseItems) {
      final totalAmountOfBaseItem = lifeItems
          .where((item) => item.key == baseItem.key)
          .map((item) => item.amount)
          .reduce((value, element) => value + element);
      if (totalAmountOfBaseItem < baseItem.amount) return items;

      // lifeItemsにbaseItemが必要量入っていれば減らす
      items.add(LifeItemEntity(key: baseItem.key, type: baseItem.type, amount: -baseItem.amount));
    }
    // lifeItemsにtargetItemを追加する
    for (final targetItem in params.targetItems) {
      items.add(LifeItemEntity(key: targetItem.key, type: targetItem.type, amount: targetItem.amount));
    }
    return items;
  }
}
