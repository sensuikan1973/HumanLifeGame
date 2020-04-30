import 'dart:math';

import 'package:flutter/material.dart';

class PlayerActionModel extends ChangeNotifier {
  final int _maxDiceNumber = 6;
  int _dice = 0;
  int get dice => _dice;

  Random rand = Random();
  void rollDice() {
    _dice = rand.nextInt(_maxDiceNumber) + 1;
    notifyListeners();
  }
}
