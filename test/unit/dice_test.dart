import 'package:HumanLifeGame/api/dice.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/dice.dart';

void main() {
  test('default: 1 <= roll <= 6 ', () {
    const dice = Dice();
    expect(dice.roll(), inInclusiveRange(Dice.defaultMin, Dice.defaultMax));
  });

  test('custom: 2 <= roll <= 4 ', () {
    const dice = Dice(min: 2, max: 4);
    expect(dice.roll(), inInclusiveRange(2, 4));
  });

  test('mock roll()', () {
    final dice = MockDice(3);
    expect(dice.roll(), 3);
  });
}
