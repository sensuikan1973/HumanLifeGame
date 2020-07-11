import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_params.dart';

part 'nothing_params.freezed.dart';
part 'nothing_params.g.dart';

@freezed
abstract class NothingParams extends LifeEventParams implements _$NothingParams {
  const factory NothingParams({@Default(LifeEventType.nothing) LifeEventType type}) = _NothingParams;
  const NothingParams._();

  factory NothingParams.fromJson(Map<String, dynamic> json) => _$NothingParamsFromJson(json);
}
