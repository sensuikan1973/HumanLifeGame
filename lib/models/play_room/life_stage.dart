import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/firestore/life_item.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../../api/life_step_entity.dart';
import '../../entities/life_item_type.dart';

part 'life_stage.freezed.dart';

@freezed
abstract class LifeStageModel implements _$LifeStageModel {
  const factory LifeStageModel({
    Doc<UserEntity> human,
    List<LifeItemEntity> lifeItems,
    LifeStepEntity lifeStepEntity,
  }) = _LifeStageModel;
  const LifeStageModel._();

  int get totalMoney => lifeItems.isEmpty
      ? 0
      : lifeItems
          .where((item) => item.type == LifeItemType.money)
          .map((money) => money.amount)
          .reduce((val, el) => val + el);
}
