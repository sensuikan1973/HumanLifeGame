import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_params.dart';

part 'start_params.freezed.dart';
part 'start_params.g.dart';

@freezed
abstract class StartParams extends LifeEventParams implements _$StartParams {
  const factory StartParams({@Default(LifeEventType.start) LifeEventType type}) = _StartParams;
  const StartParams._();

  factory StartParams.fromJson(Map<String, dynamic> json) => _$StartParamsFromJson(json);
}
