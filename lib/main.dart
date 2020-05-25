import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'human_life_game_app.dart';

Future<void> main() async {
  // ref: https://flutter.dev/docs/testing/debugging

  await DotEnv().load('config/.env');

  runApp(
    HumanLifeGameApp.inProviders(),
  );
}
