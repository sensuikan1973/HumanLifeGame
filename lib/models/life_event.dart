import 'package:HumanLifeGame/models/life_item.dart';

class LifeEvent {
  LifeEvent(this.type, this.description, this.target, this.params);

  final LifeEventTarget target;
  final LifeEventType type;
  final LifeEventParams params;

  final String description;
}

enum LifeEventTarget {
  myself, // LifeEvent を引き起こした張本人のみ
  all, // 全員
}

enum LifeEventType {
  gainMoney,
  loseMoney,
  gainLifeItem,
  loseLifeItem,
}

class GainMoneyParams with LifeEventParams {
  // 確定した絶対数を指定したい場合に指定する。
  int amount;

  // NOTE: 以下は、所有している LifeItem に応じて gainMoney したい場合に指定する。
  int amountPerItem; // Item 一個あたりに gain する量。
  LifeItem targetLifeItem;
}

class LoseMoneyParams with LifeEventParams {
  // 確定した絶対数を指定したい場合に指定する。
  int amount;

  // NOTE: 以下は、所有している LifeItem に応じて loseMoney したい場合に指定する。
  int amountPerItem; // Item 一個あたりに lose する量。
  LifeItem targetLifeItem;
}

class GainLifeItemParams with LifeEventParams {
  // 確定した絶対数を指定したい場合に指定する。
  int amount;

  // NOTE: 以下は、所有している LifeItem に応じて gainMoney したい場合に指定する。
  int amountPerItem; // Item 一個あたりに gain する量。
  LifeItem targetLifeItem;
}

mixin LifeEventParams {
  // NOTE: 以下は、サイコロの出目を使って結果を変えたい場合に指定する。
  int amountPerDiceRoll;
}
