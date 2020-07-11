import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_params.dart';

part 'goal_params.freezed.dart';
part 'goal_params.g.dart';

@freezed
abstract class GoalParams extends LifeEventParams implements _$GoalParams {
  const factory GoalParams({@Default(LifeEventType.goal) LifeEventType type}) = _GoalParams;
  const GoalParams._();

  factory GoalParams.fromJson(Map<String, dynamic> json) => _$GoalParamsFromJson(json);
}
