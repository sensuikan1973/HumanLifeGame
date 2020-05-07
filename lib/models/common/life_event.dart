import 'package:flutter/foundation.dart';

class LifeEventModel {
  LifeEventModel(
    this.target,
    this.type, {
    @required Map<String, dynamic> params,
  }) : _params = params;

  LifeEventTarget target;
  LifeEventType type;

  bool isForced; // 強制実行か選択実行か

  // NOTE:
  // LifeEventType ごとに異なる内容が格納される。
  // そのため type に応じて params['foo'] と参照することになる。
  // Serialize して型付きで扱えるようにするのも要検討。(See: https://flutter.dev/docs/development/data-and-backend/json)
  final Map<String, dynamic> _params;
  Map<String, dynamic> get params => _params;

  String description;
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
