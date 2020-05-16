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
  bool get isBranch => params.isBranch;
  bool get mustStop => params.mustStop;
}

enum LifeEventTarget {
  myself, // LifeEvent を引き起こした張本人の human のみ
  all, // 全 human
  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
