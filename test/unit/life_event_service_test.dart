import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/target_life_item_params.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:HumanLifeGame/services/life_event_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('gainLifeItems', () {
    final items = [
      LifeItemModel('money', LifeItemType.money, 200),
    ];
    final lifeStageModel = LifeStageModel(human: HumanModel(id: 'human_1', name: 'foo', order: 0), lifeItems: items);
    final gains = LifeEventModel(
        LifeEventTarget.myself,
        const GainLifeItemsParams(targetItems: [
          TargetLifeItemParams(key: 'doctor', type: LifeItemType.job, amount: 1),
          TargetLifeItemParams(key: 'coffee', type: LifeItemType.coffee, amount: 1),
        ]));

    final model = const LifeEventService().executeEvent(gains, lifeStageModel);

    expect(model.lifeItems[0].amount, 200);
    expect(model.lifeItems[0].key, 'money');
    expect(model.lifeItems[1].amount, 1);
    expect(model.lifeItems[1].key, 'doctor');
    expect(model.lifeItems[2].amount, 1);
    expect(model.lifeItems[2].key, 'coffee');
  });
}
