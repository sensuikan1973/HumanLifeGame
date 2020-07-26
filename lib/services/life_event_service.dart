import 'package:collection/collection.dart';
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

  /// 指定の lifeStage を対象に LifeVent の処理を適用する
  List<LifeStageEntity> executeEvent(LifeEventEntity lifeEvent, List<LifeStageEntity> lifeStages) {
    switch (lifeEvent.type) {
      case LifeEventType.nothing:
      case LifeEventType.start:
        break; // 何もすることない
      case LifeEventType.goal:
        break; // TODO: 実装
      case LifeEventType.selectDirection:
        break; // TODO: 実装
      case LifeEventType.selectDirectionPerDiceRoll:
        break; // TODO: 実装
      case LifeEventType.selectDirectionPerLifeItem:
        break; // TODO: 実装
      case LifeEventType.gainLifeItems:
        final params = lifeEvent.params as GainLifeItemsParams;
        return lifeStages.map<LifeStageEntity>((lifeStage) {
          final items = {...lifeStage.items};
          for (final target in params.targetItems) {
            final targetItem = LifeItemEntity(key: target.key, type: target.type, amount: target.amount);
            final existingItem = items.firstWhere((el) => el.equalToTarget(target), orElse: () => null);
            if (existingItem != null) {
              /// 同一のものがある場合は削除しつつ加算
              items
                ..removeWhere((el) => el.equalToTarget(target))
                ..add(existingItem.copyWith(amount: existingItem.amount + targetItem.amount)); // 加算
            } else {
              items.add(targetItem);
            }
          }
          return lifeStage.copyWith(items: UnmodifiableSetView<LifeItemEntity>(items));
        }).toList();
      case LifeEventType.gainLifeItemsPerOtherLifeItem:
        break; // TODO: 実装
      case LifeEventType.gainLifeItemsPerDiceRoll:
        break; // TODO: 実装
      case LifeEventType.gainLifeItemsIfExistOtherLifeItem:
        break; // TODO: 実装
      case LifeEventType.gainLifeItemsIfNotExistOtherLifeItem:
        break; // TODO: 実装
      case LifeEventType.exchangeLifeItems:
        final params = lifeEvent.params as ExchangeLifeItemsParams;
        return lifeStages
            .map<LifeStageEntity>((lifeStage) => lifeStage.copyWith(
                  items: UnmodifiableSetView<LifeItemEntity>(_exchangeLifeItems(lifeStage.items, params)),
                ))
            .toList();
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        break; // TODO: 実装
      case LifeEventType.loseLifeItems:
        final params = lifeEvent.params as LoseLifeItemsParams;
        return lifeStages.map<LifeStageEntity>((lifeStage) {
          final items = {...lifeStage.items};
          for (final target in params.targetItems) {
            final targetItem = LifeItemEntity(key: target.key, type: target.type, amount: target.amount);
            final existingItem = items.firstWhere((el) => el.equalToTarget(target), orElse: () => null);
            if (existingItem != null) {
              /// 同一のものがある場合は削除しつつ減算
              items
                ..removeWhere((el) => el.equalToTarget(target))
                ..add(existingItem.copyWith(amount: existingItem.amount - targetItem.amount)); // 減算
            } else {
              items.add(targetItem);
            }
          }
          return lifeStage.copyWith(items: UnmodifiableSetView<LifeItemEntity>(items));
        }).toList();
      case LifeEventType.loseLifeItemsPerDiceRoll:
        break; // TODO: 実装
      case LifeEventType.loseLifeItemsPerOtherLifeItem:
        break; // TODO: 実装
      case LifeEventType.loseLifeItemsIfExistOtherLifeItem:
        break; // TODO: 実装
      case LifeEventType.loseLifeItemsIfNotExistOtherLifeItem:
        break; // TODO: 実装
    }
    return lifeStages.map<LifeStageEntity>((lifeStage) => lifeStage.copyWith()).toList();
  }

  Set<LifeItemEntity> _exchangeLifeItems(Set<LifeItemEntity> lifeItems, ExchangeLifeItemsParams params) {
    final items = <LifeItemEntity>{...lifeItems};

    for (final baseItem in params.baseItems) {
      final totalAmountOfBaseItem = items
          .where((item) => item.equalToTarget(baseItem))
          .map((item) => item.amount)
          .reduce((value, element) => value + element);
      if (totalAmountOfBaseItem < baseItem.amount) return items;

      // 交換の条件として item を失う
      final existingItem = items.firstWhere((el) => el.equalToTarget(baseItem), orElse: () => null);
      if (existingItem != null) {
        // 同一のものがある場合は削除しつつ減算
        // TODO: 0 を下回る時どうするか?
        items
          ..removeWhere((el) => el.equalToTarget(baseItem))
          ..add(existingItem.copyWith(amount: existingItem.amount - baseItem.amount)); // 減算
      }
    }

    // 失った代償として item を獲得する
    for (final targetItem in params.targetItems) {
      final existingItem = items.firstWhere((el) => el.equalToTarget(targetItem), orElse: () => null);
      if (existingItem != null) {
        // 同一のものがある場合は削除しつつ加算
        items
          ..removeWhere((el) => el.equalToTarget(targetItem))
          ..add(existingItem.copyWith(amount: existingItem.amount + targetItem.amount)); // 減算
      } else {
        items.add(LifeItemEntity(type: targetItem.type, amount: targetItem.amount, key: targetItem.key));
      }
    }
    return items;
  }
}
