import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('totalMoney', () {
    final items = [
      LifeItemModel('doctor', LifeItemType.job, 1),
      LifeItemModel('money', LifeItemType.money, 200),
      LifeItemModel('money', LifeItemType.money, 300),
      LifeItemModel('money', LifeItemType.money, 100),
      LifeItemModel('coffee', LifeItemType.coffee, 1),
    ];
    final lifeStageModel = LifeStageModel(HumanModel(id: 'human_1', name: 'foo', order: 0))..lifeItems = items;
    expect(lifeStageModel.totalMoney, 600);
  });
}
