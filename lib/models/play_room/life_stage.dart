import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/firestore/user.dart';
import '../../entities/life_item.dart';
import '../../entities/life_step.dart';

part 'life_stage.freezed.dart';

@freezed
abstract class LifeStageModel with _$LifeStageModel {
  factory LifeStageModel({
    Document<UserEntity> human,
    List<LifeItemEntity> lifeItems,
    LifeStepEntity lifeStepEntity,
  }) = _LifeStageModel;

  @late
  int get totalMoney => lifeItems.isEmpty
      ? 0
      : lifeItems
          .where((item) => item.type == LifeItemType.money)
          .map((money) => money.amount)
          .reduce((val, el) => val + el);
}
