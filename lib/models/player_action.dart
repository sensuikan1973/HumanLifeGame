import 'dart:math';

import 'package:flutter/foundation.dart';

class PlayerActionModel extends ChangeNotifier {
  @visibleForTesting
  static const int maxDiceNumber = 6;
  int _dice = 0;

  int get dice => _dice;

  void rollDice() {
    final rand = Random();
    _dice = rand.nextInt(maxDiceNumber) + 1;
    notifyListeners();
  }
}
