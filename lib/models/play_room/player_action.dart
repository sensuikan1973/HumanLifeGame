import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../common/life_step.dart';

class PlayerActionNotifier extends ChangeNotifier {
  PlayerActionNotifier(this._dice);

  final Dice _dice;

  /// 出目
  int get roll => _roll;
  int _roll = 0;

  /// 一度も振られていないかどうか
  bool get neverRolled => _roll == 0;

  /// 方向の選択
  Direction _direction;
  Direction get direction => _direction;
  set direction(Direction value) {
    _direction = value;
    notifyListeners();
  }

  void rollDice() {
    _roll = _dice.roll();
    notifyListeners();
  }
}
