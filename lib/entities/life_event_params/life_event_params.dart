import 'package:flutter/foundation.dart';

import '../life_event_emotion_category.dart';
import '../life_item_type.dart';
import 'gain_life_items_params.dart';
import 'lose_life_items_params.dart';

@immutable
abstract class LifeEventParams {
  const LifeEventParams();

  LifeEventType get type;
  Map<String, dynamic> toJson();

  /// 分岐かどうか
  bool get isBranch => [
        LifeEventType.selectDirection,
        LifeEventType.selectDirectionPerDiceRoll,
        LifeEventType.selectDirectionPerLifeItem,
      ].contains(type);

  /// 止まることを強制されるかどうか
  /// 現状は、ユーザアクションを伴う分岐時のみ
  bool get mustStop => [
        LifeEventType.selectDirection,
        LifeEventType.selectDirectionPerDiceRoll,
      ].contains(type);

  /// 実行が選択制かどうか
  bool get selectableForExecution => [
        LifeEventType.exchangeLifeItems,
        LifeEventType.exchangeLifeItemsWithDiceRoll,
      ].contains(type);

  /// サイコロを振るアクションを求めるかどうか
  bool get requireDiceRoll => [
        LifeEventType.selectDirectionPerDiceRoll,
        LifeEventType.gainLifeItemsPerDiceRoll,
        LifeEventType.loseLifeItemsPerDiceRoll,
      ].contains(type);

  /// 方向選択のアクションを求めるかどうか
  bool get requireToSelectDirectionManually => [
        LifeEventType.selectDirection,
      ].contains(type);

  /// 感情の Category を取得する
  EmotionCategory get emotionCategory {
    switch (type) {
      case LifeEventType.nothing:
      case LifeEventType.start:
      case LifeEventType.goal:
      case LifeEventType.selectDirection:
      case LifeEventType.selectDirectionPerDiceRoll:
      case LifeEventType.selectDirectionPerLifeItem:
        return EmotionCategory.normal;
        break;

      case LifeEventType.gainLifeItems:
      case LifeEventType.gainLifeItemsPerOtherLifeItem:
      case LifeEventType.gainLifeItemsPerDiceRoll:
      case LifeEventType.gainLifeItemsIfExistOtherLifeItem:
      case LifeEventType.gainLifeItemsIfNotExistOtherLifeItem:
      case LifeEventType.exchangeLifeItems:
        return EmotionCategory.positive;
        break;

      case LifeEventType.loseLifeItems:
      case LifeEventType.loseLifeItemsPerDiceRoll:
      case LifeEventType.loseLifeItemsPerOtherLifeItem:
      case LifeEventType.loseLifeItemsIfExistOtherLifeItem:
      case LifeEventType.loseLifeItemsIfNotExistOtherLifeItem:
        return EmotionCategory.negative;
        break;

      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        return EmotionCategory.challenge;
        break;
    }
    return EmotionCategory.normal;
  }

  List<InfoCategory> get infoCategories {
    switch (type) {
      case LifeEventType.nothing:
      case LifeEventType.start:
      case LifeEventType.goal:
        return [InfoCategory.nothing];
      case LifeEventType.selectDirection:
      case LifeEventType.selectDirectionPerDiceRoll:
      case LifeEventType.selectDirectionPerLifeItem:
        return [InfoCategory.selectDirection];
      case LifeEventType.gainLifeItems:
        final params = this as GainLifeItemsParams;
        return [
          for (final item in params.targetItems) fromLifeItemType(item.type),
        ];
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
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        return [InfoCategory.exchange];
      case LifeEventType.loseLifeItems:
        final params = this as LoseLifeItemsParams;
        return [
          for (final item in params.targetItems) fromLifeItemType(item.type),
        ];
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
    return [InfoCategory.nothing];
  }

  InfoCategory fromLifeItemType(LifeItemType type) {
    switch (type) {
      case LifeItemType.job:
        return InfoCategory.job;
      case LifeItemType.stock:
        return InfoCategory.stock;
      case LifeItemType.spouse:
        return InfoCategory.spouse;
      case LifeItemType.house:
        return InfoCategory.house;
      case LifeItemType.money:
        return InfoCategory.money;
      case LifeItemType.vehicle:
        return InfoCategory.vehicle;
      case LifeItemType.childGirl:
      case LifeItemType.childBoy:
        return InfoCategory.child;
      case LifeItemType.fireInsurance:
      case LifeItemType.lifeInsurance:
      case LifeItemType.earthquakeInsurance:
      case LifeItemType.carInsurance:
        return InfoCategory.insurance;
      case LifeItemType.coffee:
        return InfoCategory.coffee;
    }
    return InfoCategory.nothing;
  }
}

enum LifeEventType {
  // NOTE: LifeItem の amount の「以上,以下,未満,超過」を条件とする Event はサポートしてない

  /// 何も起きない
  nothing,

  /// 人生の始まり
  start,

  /// 人生のゴール
  goal,

  /// 進行方向を選択する
  selectDirection,

  /// サイコロの出目に基づいて、進行方向を決定する
  selectDirectionPerDiceRoll,

  /// 特定の LifeItem の数に基づいて、進行方向を決定する
  selectDirectionPerLifeItem,

  /// 単に LifeItem を獲得する
  gainLifeItems,

  /// LifeItemA の数に基づいて、LifeItemB を獲得する
  gainLifeItemsPerOtherLifeItem,

  /// サイコロの出目に基づいて、LifeItem を獲得する
  gainLifeItemsPerDiceRoll,

  /// LifeItemA が存在すれば、LifeItemB を獲得する
  gainLifeItemsIfExistOtherLifeItem,

  /// LifeItemA が存在しなければ、LifeItemB を獲得する
  gainLifeItemsIfNotExistOtherLifeItem,

  /// LifeItemA と LifeItemB を交換する
  exchangeLifeItems,

  /// サイコロの出目に基づいて、LifeItemA と LifeItemB を交換する
  exchangeLifeItemsWithDiceRoll,

  /// 単に LifeItem を失う
  loseLifeItems,

  /// サイコロの出目に基づいて、LifeItem を失う
  loseLifeItemsPerDiceRoll,

  /// LifeItemA の数に基づいて、LifeItemB を失う
  loseLifeItemsPerOtherLifeItem,

  /// LifeItemA が存在すれば、LifeItemB を失う
  loseLifeItemsIfExistOtherLifeItem,

  /// LifeItemA が存在しなければ、LifeItemB を失う
  loseLifeItemsIfNotExistOtherLifeItem,
}

enum InfoCategory {
  /// 職業
  job,

  /// 株
  stock,

  /// 配偶者
  spouse,

  /// 家
  house,

  /// 金
  money,

  /// 乗り物
  vehicle,

  /// 子供
  child,

  /// 保険
  insurance,

  /// 1回休み
  coffee,

  /// アイテムの交換
  exchange,

  /// 方向選択
  selectDirection,

  /// 案内なし
  nothing,
}
