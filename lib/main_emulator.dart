import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'human_life_game_app.dart';

const _firestoreEmulatorPort = 8080;
const _firestoreEmulatorDomain = 'localhost';

Future<void> main() async {
  // ref: https://flutter.dev/docs/testing/debugging

  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('config/.env');

  await Firestore.instance.settings(
    persistenceEnabled: false,
    host: '$_firestoreEmulatorDomain:$_firestoreEmulatorPort',
    sslEnabled: false,
  );

  runApp(
    HumanLifeGameApp.inProviders(),
  );
}
