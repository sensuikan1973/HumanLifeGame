import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/firestore/user_helper.dart';

void main() {
  test('totalMoney', () async {
    const items = [
      LifeItemEntity('doctor', LifeItemType.job, 1),
      LifeItemEntity('money', LifeItemType.money, 200),
      LifeItemEntity('money', LifeItemType.money, 300),
      LifeItemEntity('money', LifeItemType.money, 100),
      LifeItemEntity('coffee', LifeItemType.coffee, 1),
    ];
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
    final lifeStageModel = LifeStageModel(
      human: await createUser(store),
      lifeItems: items,
    );
    expect(lifeStageModel.totalMoney, 600);
  });
}
