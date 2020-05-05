import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/infra/human_life_repository.dart';
import 'package:HumanLifeGame/infra/infra.dart';
import 'package:HumanLifeGame/infra/play_room_repository.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n_delegate.dart';

class HumanLifeGameApp extends StatelessWidget {
  const HumanLifeGameApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (context) => Router()),
          Provider(create: (context) => const Dice()),
          Provider(create: (context) => Infra(HumanLifeRepository(), PlayRoomRepository()))
        ],
        child: Consumer<Router>(
          builder: (_, router, __) => MaterialApp(
            onGenerateTitle: (context) => I18n.of(context).appTitle,
            localizationsDelegates: const [
              I18nDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'US'), Locale('ja', 'JP')],
            locale: const Locale('en'),
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: router.initialRoute,
            routes: router.routes,
          ),
        ),
      );
}
