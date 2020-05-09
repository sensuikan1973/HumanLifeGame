import '../play_room/life_stage.dart';
import 'life_event.dart';
import 'life_event_params/gain_life_items_params.dart';
import 'life_event_params/life_event_params.dart';
import 'life_item.dart';

class LifeEventExecutor {
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
