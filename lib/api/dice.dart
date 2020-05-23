import 'dart:math';

import 'package:flutter/foundation.dart';

@immutable
class Dice {
  const Dice({this.min = defaultMin, this.max = defaultMax});

  @visibleForTesting
  static const int defaultMin = 1;

  @visibleForTesting
  static const int defaultMax = 6;

  final int min;
  final int max;

  /// サイコロを振る
  int roll() => min + Random().nextInt(max - min + 1);
}
