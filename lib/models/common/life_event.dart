import 'life_event_params/life_event_params.dart';

class LifeEventModel<T extends LifeEventParams> {
  LifeEventModel(
    this.target,
    this.params,
  );

  final T params;
  LifeEventTarget target;
  String description;

  LifeEventType get type => params.type;
  EventCategory get category => params.category;
  bool get isBranch => params.isBranch;
  bool get mustStop => params.mustStop;
  bool get requireDiceRoll => params.requireDiceRoll;
  bool get requireToSelectDirectionManually => params.requireToSelectDirectionManually;
}

enum LifeEventTarget {
  myself, // LifeEvent を引き起こした張本人の human のみ
  all, // 全 human
  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
