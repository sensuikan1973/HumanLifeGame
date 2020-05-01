import 'dart:math';

import 'package:flutter/foundation.dart';

class PlayerActionModel extends ChangeNotifier {
  @visibleForTesting
  final int maxDiceNumber = 6;
  int _dice = 0;

  int get dice => _dice;

  Random rand = Random();

  void rollDice() {
    _dice = rand.nextInt(maxDiceNumber) + 1;
    notifyListeners();
  }
}
