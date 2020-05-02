library widget_buuild_helper;

import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Widget testableApp({@required Widget home, String localeName = 'en'}) => MultiProvider(
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
          locale: Locale(localeName),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: home,
        ),
      ),
    );
