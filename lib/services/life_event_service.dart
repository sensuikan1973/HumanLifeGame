import 'package:flutter/foundation.dart';

import '../models/common/life_event.dart';
import '../models/common/life_event_params/gain_life_items_params.dart';
import '../models/common/life_event_params/life_event_params.dart';
import '../models/common/life_item.dart';
import '../models/play_room/life_stage.dart';

@immutable
class LifeEventService {
  const LifeEventService();

  LifeStageModel executeEvent(LifeEventModel lifeEvent, LifeStageModel lifeStage) {
    // FIXME: 他の EventType もサポートすること
    if (lifeEvent.type != LifeEventType.gainLifeItems) return lifeStage;

    final params = lifeEvent.params as GainLifeItemsParams;
    final items = [
      for (final item in params.targetItems) LifeItemModel(item.key, item.type, item.amount),
    ];
    return lifeStage..lifeItems.addAll(items);
  }
}
