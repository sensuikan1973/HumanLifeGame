import 'package:HumanLifeGame/router.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'i18n/i18n_delegate.dart';

class HumanLifeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (context) => Router()),
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
