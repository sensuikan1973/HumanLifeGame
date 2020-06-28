import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget testableApp({
  @required Widget home,
  Store store,
  Router router = const Router(),
  Auth auth = const Auth(),
  Dice dice = const Dice(),
  Locale locale = HumanLifeGameApp.defaultLocale,
}) =>
    MultiProvider(
      providers: [
        Provider(create: (_) => router),
        Provider(create: (_) => auth),
        Provider(create: (_) => dice),
        Provider(create: (_) => store ?? Store(MockFirestoreInstance())),
      ],
      child: MaterialApp(
        onGenerateTitle: HumanLifeGameApp.onGenerateTitle,
        localizationsDelegates: HumanLifeGameApp.localizationDelegates,
        supportedLocales: HumanLifeGameApp.supportedLocales,
        locale: locale,
        theme: HumanLifeGameApp.theme,
        home: home,
        onGenerateRoute: router.generateRoutes,
      ),
    );
