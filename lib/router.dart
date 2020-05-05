import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:flutter/material.dart';

class Router {
  final String initialRoute = '/';

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const PlayRoom(),
  };
}
