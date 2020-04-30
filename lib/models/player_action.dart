import 'dart:math';

import 'package:flutter/material.dart';

class PlayerActionModel extends ChangeNotifier {
  int _dice = 0;
  int get dice => _dice;
  Random rand = Random();
  void rollDice() {
    _dice = rand.nextInt(6) + 1;
    notifyListeners();
  }
}
