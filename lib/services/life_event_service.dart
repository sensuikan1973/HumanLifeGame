import 'package:flutter/foundation.dart';

import '../models/common/life_event.dart';
import '../models/common/life_event_params/gain_life_items_params.dart';
import '../models/common/life_event_params/life_event_params.dart';
import '../models/common/life_event_params/lose_life_items_params.dart';
import '../models/common/life_item.dart';
import '../models/play_room/life_stage.dart';

@immutable
class LifeEventService {
  const LifeEventService();

  LifeStageModel executeEvent(LifeEventModel lifeEvent, LifeStageModel lifeStage) {
    // FIXME: 他の EventType もサポートすること
    if (lifeEvent.type != LifeEventType.gainLifeItems && lifeEvent.type != LifeEventType.loseLifeItems) {
      return lifeStage;
    }

    List<LifeItemModel> items;
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
        items = [
          for (final item in params.targetItems) LifeItemModel(item.key, item.type, item.amount),
        ];
        break;
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
        // TODO: Handle this case.
        break;
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItems:
        final params = lifeEvent.params as LoseLifeItemsParams;
        items = [
          for (final item in params.targetItems) LifeItemModel(item.key, item.type, -item.amount),
        ];
        break;
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
      default:
        return lifeStage;
        break;
    }

    return lifeStage..lifeItems.addAll(items);
  }
}
