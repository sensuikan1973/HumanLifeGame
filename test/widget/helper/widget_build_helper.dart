import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Widget testableApp({
  @required Widget home,
  Store store,
  Router router = const Router(),
  Auth auth = const Auth(),
  Dice dice = const Dice(),
  Locale locale = const Locale('en', 'US'),
}) =>
    MultiProvider(
      providers: [
        Provider(create: (_) => router),
        Provider(create: (_) => auth),
        Provider(create: (_) => dice),
        Provider(create: (_) => store ?? Store(MockFirestoreInstance())),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => I18n.of(context).appTitle,
        localizationsDelegates: const [
          I18nDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('ja', 'JP')],
        locale: locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: home,
        onGenerateRoute: router.generateRoutes,
      ),
    );
