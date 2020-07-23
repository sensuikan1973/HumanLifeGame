import 'package:HumanLifeGame/api/firestore/life_stage.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/entities/life_item.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/firestore/user_helper.dart';

void main() {
  test('possession', () async {
    final items = <LifeItemEntity>{
      const LifeItemEntity(key: 'doctor', type: LifeItemType.job, amount: 1),
      const LifeItemEntity(type: LifeItemType.money, amount: 600),
      const LifeItemEntity(type: LifeItemType.coffee, amount: 1),
    };
    final store = Store(MockFirestoreInstance());
    final lifeStage = LifeStageEntity(
      human: (await createUser(store)).ref,
      items: UnmodifiableSetView<LifeItemEntity>(items),
      currentLifeStepId: '12345',
    );
    expect(lifeStage.possession, 600);
  });
}
