import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/api/firestore/life_item.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:HumanLifeGame/models/common/life_event_params/exchange_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/life_event_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/lose_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/target_life_item_params.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:HumanLifeGame/services/life_event_service.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/firestore/user_helper.dart';

void main() {
  test('gainLifeItems', () async {
    const items = [LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 200)];
    final store = Store(MockFirestoreInstance());
    final lifeStageModel = LifeStageModel(
      human: await createUser(store),
      lifeItems: items,
    );
    const gain = LifeEventEntity<GainLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: GainLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'doctor', type: LifeItemType.job, amount: 1),
        TargetLifeItemParams(key: 'coffee', type: LifeItemType.coffee, amount: 1),
      ]),
      type: LifeEventType.gainLifeItems,
    );

    final model = const LifeEventService().executeEvent(gain, lifeStageModel);

    expect(model.lifeItems[0].amount, 200);
    expect(model.lifeItems[0].key, 'money');
    expect(model.lifeItems[1].amount, 1);
    expect(model.lifeItems[1].key, 'doctor');
    expect(model.lifeItems[2].amount, 1);
    expect(model.lifeItems[2].key, 'coffee');
  });

  test('loseLifeItems', () async {
    const items = [LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 200)];
    final store = Store(MockFirestoreInstance());
    final lifeStageModel = LifeStageModel(
      human: await createUser(store),
      lifeItems: items,
    );
    const lose = LifeEventEntity<LoseLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: LoseLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 5000),
      ]),
      type: LifeEventType.loseLifeItems,
    );

    final model = const LifeEventService().executeEvent(lose, lifeStageModel);

    expect(model.lifeItems[0].amount, 200);
    expect(model.lifeItems[0].key, 'money');
    expect(model.lifeItems[1].amount, -1000);
    expect(model.lifeItems[1].key, 'money');
    expect(model.lifeItems[2].amount, -5000);
    expect(model.lifeItems[2].key, 'money');
  });

  test('exchangeLifeItems', () async {
    const items = [LifeItemEntity(key: 'car', type: LifeItemType.vehicle, amount: 1)];
    final store = Store(MockFirestoreInstance());
    final lifeStageModel = LifeStageModel(
      human: await createUser(store),
      lifeItems: items,
    );
    const exchange = LifeEventEntity<ExchangeLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: ExchangeLifeItemsParams(
        targetItems: [
          TargetLifeItemParams(key: 'HumanLifeGames Inc.', type: LifeItemType.stock, amount: 1),
        ],
        baseItems: [
          TargetLifeItemParams(key: 'car', type: LifeItemType.vehicle, amount: 1),
        ],
      ),
      type: LifeEventType.exchangeLifeItems,
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
