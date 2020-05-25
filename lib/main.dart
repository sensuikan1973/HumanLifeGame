import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'human_life_game_app.dart';

Future<void> main() async {
  // ref: https://flutter.dev/docs/testing/debugging

  // NOTE: 現状 Production Mode では不要
  if (!kReleaseMode) await DotEnv().load('config/.env');

  runApp(
    HumanLifeGameApp.inProviders(),
  );
}
