import 'package:flutter/material.dart';

import 'screens/play_room/play_room.dart';

class Router {
  final String initialRoute = '/';

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const PlayRoom(),
  };
}
