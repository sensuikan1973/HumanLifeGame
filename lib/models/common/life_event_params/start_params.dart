import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_event.dart';
import 'life_event_params.dart';

part 'start_params.freezed.dart';
part 'start_params.g.dart';

@freezed
abstract class StartParams extends LifeEventParams implements _$StartParams {
  const factory StartParams() = _StartParams;
  const StartParams._();

  factory StartParams.fromJson(Map<String, dynamic> json) => _$StartParamsFromJson(json);

  @override
  LifeEventType get type => LifeEventType.start;
}
