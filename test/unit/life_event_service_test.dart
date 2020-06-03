import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/exchange_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/lose_life_items_params.dart';
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
    final lifeStageModel = LifeStageModel(
      human: const HumanModel(id: 'human_1', name: 'foo', order: 0),
      lifeItems: items,
    );
    final gain = LifeEventModel(
      LifeEventTarget.myself,
      const GainLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'doctor', type: LifeItemType.job, amount: 1),
        TargetLifeItemParams(key: 'coffee', type: LifeItemType.coffee, amount: 1),
      ]),
    );

    final model = const LifeEventService().executeEvent(gain, lifeStageModel);

    expect(model.lifeItems[0].amount, 200);
    expect(model.lifeItems[0].key, 'money');
    expect(model.lifeItems[1].amount, 1);
    expect(model.lifeItems[1].key, 'doctor');
    expect(model.lifeItems[2].amount, 1);
    expect(model.lifeItems[2].key, 'coffee');
  });

  test('loseLifeItems', () {
    final items = [
      LifeItemModel('money', LifeItemType.money, 200),
    ];
    final lifeStageModel = LifeStageModel(
      human: const HumanModel(id: 'human_1', name: 'foo', order: 0),
      lifeItems: items,
    );
    final lose = LifeEventModel(
      LifeEventTarget.myself,
      const LoseLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 5000),
      ]),
    );

    final model = const LifeEventService().executeEvent(lose, lifeStageModel);

    expect(model.lifeItems[0].amount, 200);
    expect(model.lifeItems[0].key, 'money');
    expect(model.lifeItems[1].amount, -1000);
    expect(model.lifeItems[1].key, 'money');
    expect(model.lifeItems[2].amount, -5000);
    expect(model.lifeItems[2].key, 'money');
  });

  test('exchangeLifeItems', () {
    final items = [
      LifeItemModel('car', LifeItemType.vehicle, 1),
    ];
    final lifeStageModel = LifeStageModel(
      human: const HumanModel(id: 'human_1', name: 'foo', order: 0),
      lifeItems: items,
    );
    final exchange = LifeEventModel(
      LifeEventTarget.myself,
      const ExchangeLifeItemsParams(
        targetItems: [
          TargetLifeItemParams(key: 'HumanLifeGames Inc.', type: LifeItemType.stock, amount: 1),
        ],
        baseItems: [
          TargetLifeItemParams(key: 'car', type: LifeItemType.vehicle, amount: 1),
        ],
      ),
    );
    var model = const LifeEventService().executeEvent(exchange, lifeStageModel);
    expect(model.lifeItems[0].amount, 1);
    expect(model.lifeItems[0].key, 'car');
    expect(model.lifeItems[1].amount, -1);
    expect(model.lifeItems[1].key, 'car');
    expect(model.lifeItems[2].amount, 1);
    expect(model.lifeItems[2].key, 'HumanLifeGames Inc.');

    // ２回目の交換では、交換の条件を満たしていないため交換できない
    model = const LifeEventService().executeEvent(exchange, model);
    expect(model.lifeItems.length, 3);
    expect(model.lifeItems[0].amount, 1);
    expect(model.lifeItems[0].key, 'car');
    expect(model.lifeItems[1].amount, -1);
    expect(model.lifeItems[1].key, 'car');
    expect(model.lifeItems[2].amount, 1);
    expect(model.lifeItems[2].key, 'HumanLifeGames Inc.');
  });
}
