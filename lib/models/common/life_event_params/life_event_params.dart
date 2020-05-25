import 'package:flutter/foundation.dart';

@immutable
abstract class LifeEventParams {
  const LifeEventParams();

  LifeEventType get type;

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
  EmotionCategory get category {
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

enum EmotionCategory {
  /// 恩恵を受ける種類の Event を指す
  positive,

  /// 損害を受ける種類の Event を指す
  negative,

  /// 特に何の恩恵も損害も受けない種類の Event を指す
  normal,

  /// 恩恵を受けるか損害を受けるかが不定な種類の Event を指す
  challenge,
}
