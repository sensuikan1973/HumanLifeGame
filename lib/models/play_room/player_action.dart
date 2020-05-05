import 'package:flutter/foundation.dart';

import '../../api/dice.dart';

class PlayerActionModel extends ChangeNotifier {
  PlayerActionModel(this._dice);

  final Dice _dice;

  int _roll = 0; // 出目
  int get roll => _roll;

  void rollDice() {
    _roll = _dice.roll();
    notifyListeners();
  }
}
