import 'package:flutter/material.dart';

import 'human_life_game_app.dart';

Future<void> main() async {
  // ref: https://flutter.dev/docs/testing/debugging

  runApp(
    HumanLifeGameApp.inProviders(),
  );
}
