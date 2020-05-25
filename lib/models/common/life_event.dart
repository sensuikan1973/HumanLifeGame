import 'life_event_params/life_event_params.dart';

class LifeEventModel<T extends LifeEventParams> {
  LifeEventModel(
    this.target,
    this.params, {
    this.description = ' ',
  });

  final T params;
  LifeEventTarget target;
  String description;

  LifeEventType get type => params.type;
  EmotionCategory get emotionCategory => params.emotionCategory;
  List<InfoCategory> get infoCategories => params.infoCategories;
  bool get isBranch => params.isBranch;
  bool get mustStop => params.mustStop;
  bool get selectableForExecution => params.selectableForExecution;
  bool get requireDiceRoll => params.requireDiceRoll;
  bool get requireToSelectDirectionManually => params.requireToSelectDirectionManually;
}

enum LifeEventTarget {
  /// LifeEvent を引き起こした張本人の Human のみ
  myself,

  /// 全ての Human
  all,

  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
