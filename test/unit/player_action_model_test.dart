import 'package:HumanLifeGame/models/player_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerActionModel', () {
    test("Dice value shuld be '1 <= value <= 6')", () {
      final model = PlayerActionModel()..rollDice();
      expect(model.dice, inInclusiveRange(1, PlayerActionModel.maxDiceNumber));
    });
  });
}
