import 'life_event_params/life_event_params.dart';

class LifeEventModel<T extends LifeEventParams> {
  LifeEventModel(
    this.target,
    this.params,
  );

  final T params;
  LifeEventTarget target;
  bool isForced; // 強制実行か選択実行か
  String description;

  LifeEventType get type => params.type;
}

enum LifeEventTarget {
  myself, // LifeEvent を引き起こした張本人の human のみ
  all, // 全 human
  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
