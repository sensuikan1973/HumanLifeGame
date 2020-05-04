import 'package:HumanLifeGame/i18n/i18n.dart';

class LifeEventModel {
  LifeEventModel(this.target, this.type);

  LifeEventTarget target;
  LifeEventType type;

  bool isForced; // 強制実行か選択実行か

  // NOTE:
  // LifeEventType ごとに異なる内容が格納される。
  // そのため type に応じて params['foo'] と参照することになる。
  // Serialize して型付きで扱えるようにするのも要検討。(See: https://flutter.dev/docs/development/data-and-backend/json)
  Map<String, dynamic> params;

  String description;

  String buildEventMessage(I18n i18n) {
    var message = '';

    switch (type) {
      case LifeEventType.nothing:
        // TODO: Handle this case.
        break;
      case LifeEventType.start:
        message = i18n.lifeStepStartText;
        break;
      case LifeEventType.goal:
        message = i18n.lifeStepGoalText;
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
      case LifeEventType.gainLifeItemPerOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemPerDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemIfExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItemIfNotExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.exchangeLifeItems:
        // TODO: Handle this case.
        break;
      case LifeEventType.exchangeLifeItemsWithDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemPerDiceRoll:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemPerOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemIfExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.loseLifeItemIfNotExistOtherLifeItem:
        // TODO: Handle this case.
        break;
      case LifeEventType.gainLifeItem:
        message += i18n.lifeStepGainItemText;
        break;
    }

    return message;
  }
}

enum LifeEventTarget {
  myself, // LifeEvent を引き起こした張本人の human のみ
  all, // 全 human
  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
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
  gainLifeItem,

  /// LifeItemA の数に基づいて、LifeItemB を獲得する
  gainLifeItemPerOtherLifeItem,

  /// サイコロの出目に基づいて、LifeItem を獲得する
  gainLifeItemPerDiceRoll,

  /// LifeItemA が存在すれば、LifeItemB を獲得する
  gainLifeItemIfExistOtherLifeItem,

  /// LifeItemA が存在しなければ、LifeItemB を獲得する
  gainLifeItemIfNotExistOtherLifeItem,

  /// LifeItemA と LifeItemB を交換する
  exchangeLifeItems,

  /// サイコロの出目に基づいて、LifeItemA と LifeItemB を交換する
  exchangeLifeItemsWithDiceRoll,

  /// 単に LifeItem を失う
  loseLifeItem,

  /// サイコロの出目に基づいて、LifeItem を失う
  loseLifeItemPerDiceRoll,

  /// LifeItemA の数に基づいて、LifeItemB を失う
  loseLifeItemPerOtherLifeItem,

  /// LifeItemA が存在すれば、LifeItemB を失う
  loseLifeItemIfExistOtherLifeItem,

  /// LifeItemA が存在しなければ、LifeItemB を失う
  loseLifeItemIfNotExistOtherLifeItem,
}
