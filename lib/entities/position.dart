import 'package:flutter/foundation.dart';

@immutable
class Position {
  const Position(this.y, this.x);
  final int y;
  final int x;
}
