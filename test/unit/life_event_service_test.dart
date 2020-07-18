import 'package:HumanLifeGame/api/firestore/life_stage.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/entities/life_event.dart';
import 'package:HumanLifeGame/entities/life_event_params/exchange_life_items_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/lose_life_items_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/target_life_item_params.dart';
import 'package:HumanLifeGame/entities/life_event_target.dart';
import 'package:HumanLifeGame/entities/life_event_type.dart';
import 'package:HumanLifeGame/entities/life_item.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:HumanLifeGame/services/life_event_service.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../helper/firestore/user_helper.dart';

void main() {
  test('gainLifeItems', () async {
    const items = [LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 200)];
    final store = Store(MockFirestoreInstance());
    final lifeStage = LifeStageEntity(
      human: (await createUser(store)).ref,
      items: items,
      currentLifeStepId: Uuid().v4(),
    );
    const gain = LifeEventEntity<GainLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: GainLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'doctor', type: LifeItemType.job, amount: 1),
        TargetLifeItemParams(key: 'coffee', type: LifeItemType.coffee, amount: 1),
      ]),
      type: LifeEventType.gainLifeItems,
    );

    final lifeStageAfterEvent = const LifeEventService().executeEvent(gain, lifeStage);

    expect(lifeStageAfterEvent.items[0].amount, 200);
    expect(lifeStageAfterEvent.items[0].key, 'money');
    expect(lifeStageAfterEvent.items[1].amount, 1);
    expect(lifeStageAfterEvent.items[1].key, 'doctor');
    expect(lifeStageAfterEvent.items[2].amount, 1);
    expect(lifeStageAfterEvent.items[2].key, 'coffee');
  });

  test('loseLifeItems', () async {
    const items = [LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 200)];
    final store = Store(MockFirestoreInstance());
    final lifeStage = LifeStageEntity(
      human: (await createUser(store)).ref,
      items: items,
      currentLifeStepId: Uuid().v4(),
    );
    const lose = LifeEventEntity<LoseLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: LoseLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 5000),
      ]),
      type: LifeEventType.loseLifeItems,
    );

    final lifeStageAfterEvent = const LifeEventService().executeEvent(lose, lifeStage);

    expect(lifeStageAfterEvent.items[0].amount, 200);
    expect(lifeStageAfterEvent.items[0].key, 'money');
    expect(lifeStageAfterEvent.items[1].amount, -1000);
    expect(lifeStageAfterEvent.items[1].key, 'money');
    expect(lifeStageAfterEvent.items[2].amount, -5000);
    expect(lifeStageAfterEvent.items[2].key, 'money');
  });

  test('exchangeLifeItems', () async {
    const items = [LifeItemEntity(key: 'car', type: LifeItemType.vehicle, amount: 1)];
    final store = Store(MockFirestoreInstance());
    final lifeStage = LifeStageEntity(
      human: (await createUser(store)).ref,
      items: items,
      currentLifeStepId: Uuid().v4(),
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
    final lifeStageAfterEvent1 = const LifeEventService().executeEvent(exchange, lifeStage);
    expect(lifeStageAfterEvent1.items[0].amount, 1);
    expect(lifeStageAfterEvent1.items[0].key, 'car');
    expect(lifeStageAfterEvent1.items[1].amount, -1);
    expect(lifeStageAfterEvent1.items[1].key, 'car');
    expect(lifeStageAfterEvent1.items[2].amount, 1);
    expect(lifeStageAfterEvent1.items[2].key, 'HumanLifeGames Inc.');

    // ２回目の交換では、交換の条件を満たしていないため交換できない
    final lifeStageAfterEvent2 = const LifeEventService().executeEvent(exchange, lifeStage);
    expect(lifeStageAfterEvent2.items.length, 3);
    expect(lifeStageAfterEvent2.items[0].amount, 1);
    expect(lifeStageAfterEvent2.items[0].key, 'car');
    expect(lifeStageAfterEvent2.items[1].amount, -1);
    expect(lifeStageAfterEvent2.items[1].key, 'car');
    expect(lifeStageAfterEvent2.items[2].amount, 1);
    expect(lifeStageAfterEvent2.items[2].key, 'HumanLifeGames Inc.');
  });
}
