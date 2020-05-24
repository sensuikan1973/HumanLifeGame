import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../common/life_step.dart';

class PlayerActionNotifier extends ChangeNotifier {
  PlayerActionNotifier(this._dice);

  final Dice _dice;

  /// 出目
  var roll = 0;

  /// 一度も振られていないかどうか
  bool get neverRolled => roll == 0;

  /// 方向の選択
  Direction direction;
}
