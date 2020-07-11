import 'package:HumanLifeGame/api/firestore/life_item.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/firestore/user_helper.dart';

void main() {
  test('totalMoney', () async {
    const items = [
      LifeItemEntity(key: 'doctor', type: LifeItemType.job, amount: 1),
      LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 200),
      LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 300),
      LifeItemEntity(key: 'money', type: LifeItemType.money, amount: 100),
      LifeItemEntity(key: 'coffee', type: LifeItemType.coffee, amount: 1),
    ];
    final store = Store(MockFirestoreInstance());
    final lifeStageModel = LifeStageModel(
      human: await createUser(store),
      lifeItems: items,
    );
    expect(lifeStageModel.totalMoney, 600);
  });
}
