import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_event.dart';
import 'life_event_params.dart';

part 'select_direction_params.freezed.dart';
part 'select_direction_params.g.dart';

@freezed
abstract class SelectDirectionParams extends LifeEventParams implements _$SelectDirectionParams {
  const factory SelectDirectionParams() = _SelectDirectionParams;
  const SelectDirectionParams._();

  factory SelectDirectionParams.fromJson(Map<String, dynamic> json) => _$SelectDirectionParamsFromJson(json);

  @override
  LifeEventType get type => LifeEventType.selectDirection;
}
