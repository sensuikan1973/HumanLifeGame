import 'package:flutter/foundation.dart';

import '../api/firestore/life_stage.dart';
import '../entities/life_event.dart';
import '../entities/life_event_params/exchange_life_items_params.dart';
import '../entities/life_event_params/gain_life_items_params.dart';
import '../entities/life_event_params/lose_life_items_params.dart';
import '../entities/life_event_type.dart';
import '../entities/life_item.dart';

@immutable
class LifeEventService {
  const LifeEventService();

  LifeStageEntity executeEvent(LifeEventEntity lifeEvent, LifeStageEntity lifeStage) {
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
        final items = {...lifeStage.items};
        for (final target in params.targetItems) {
          final targetItem = LifeItemEntity(key: target.key, type: target.type, amount: target.amount);

          /// ここに同一判定ロジックがある理由は See: lib/entities/life_item.dart
          final existingItem =
              items.firstWhere((el) => el.type == target.type && el.key == target.key, orElse: () => null);
          if (existingItem != null) {
            /// 同一のものがある場合は削除しつつ加算
            items
              ..removeWhere((el) => el.type == target.type && el.key == target.key)
              ..add(existingItem.copyWith(amount: existingItem.amount + targetItem.amount)); // 加算
          } else {
            items.add(targetItem);
          }
        }
        return lifeStage.copyWith(items: items);
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
        return lifeStage.copyWith(items: _exchangeLifeItems(lifeStage.items, params));
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItems:
        final params = lifeEvent.params as LoseLifeItemsParams;
        final items = {...lifeStage.items};
        for (final target in params.targetItems) {
          final targetItem = LifeItemEntity(key: target.key, type: target.type, amount: target.amount);

          /// ここに同一判定ロジックがある理由は See: lib/entities/life_item.dart
          final existingItem =
              items.firstWhere((el) => el.type == target.type && el.key == target.key, orElse: () => null);
          if (existingItem != null) {
            /// 同一のものがある場合は削除しつつ減算
            items
              ..removeWhere((el) => el.type == target.type && el.key == target.key)
              ..add(existingItem.copyWith(amount: existingItem.amount - targetItem.amount)); // 減算
          } else {
            items.add(targetItem);
          }
        }
        return lifeStage.copyWith(items: items);
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

  Set<LifeItemEntity> _exchangeLifeItems(Set<LifeItemEntity> lifeItems, ExchangeLifeItemsParams params) {
    final items = <LifeItemEntity>{...lifeItems};

    for (final baseItem in params.baseItems) {
      final totalAmountOfBaseItem = lifeItems
          .where((item) => item.key == baseItem.key)
          .map((item) => item.amount)
          .reduce((value, element) => value + element);
      if (totalAmountOfBaseItem < baseItem.amount) return items;

      // lifeItemsにbaseItemが必要量入っていれば減らす
      // ここに同一判定ロジックがある理由は See: lib/entities/life_item.dart
      final existingItem =
          items.firstWhere((el) => el.type == baseItem.type && el.key == baseItem.key, orElse: () => null);
      if (existingItem != null) {
        // 同一のものがある場合は削除しつつ減算
        // TODO: 0 を下回る時どうするか?
        items
          ..removeWhere((el) => el.type == baseItem.type && el.key == baseItem.key)
          ..add(existingItem.copyWith(amount: existingItem.amount - baseItem.amount)); // 減算
      }
    }
    // lifeItemsにtargetItemを追加する
    for (final targetItem in params.targetItems) {
      // ここに同一判定ロジックがある理由は See: lib/entities/life_item.dart
      final existingItem =
          items.firstWhere((el) => el.type == targetItem.type && el.key == targetItem.key, orElse: () => null);
      if (existingItem != null) {
        // 同一のものがある場合は削除しつつ加算
        items
          ..removeWhere((el) => el.type == targetItem.type && el.key == targetItem.key)
          ..add(existingItem.copyWith(amount: existingItem.amount + targetItem.amount)); // 減算
      } else {
        items.add(LifeItemEntity(type: targetItem.type, amount: targetItem.amount, key: targetItem.key));
      }
    }
    return items;
  }
}
