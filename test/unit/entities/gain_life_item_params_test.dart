import 'package:HumanLifeGame/entities/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/target_life_item_params.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson', () {
    const target = TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 3000);
    const gainLifeItemParams = GainLifeItemsParams(targetItems: [target]);
    final paramsJson = gainLifeItemParams.toJson();
    expect(paramsJson['targetItems'].first['key'], target.key);
    expect(paramsJson['targetItems'].first['amount'], 3000);
    expect(paramsJson['targetItems'].first['type'], describeEnum(LifeItemType.money));
  });
}
