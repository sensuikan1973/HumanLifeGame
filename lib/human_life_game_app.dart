import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'api/auth.dart';
import 'api/dice.dart';
import 'api/firestore/store.dart';
import 'i18n/i18n.dart';
import 'i18n/i18n_delegate.dart';
import 'router.dart';
import 'screens/lobby/lobby.dart';

class HumanLifeGameApp extends StatelessWidget {
  const HumanLifeGameApp._();

  static Widget inProviders({Key key, Auth auth, Dice dice, Store store}) => MultiProvider(
        key: key,
        providers: [
          Provider(create: (_) => const AppRouter()),
          Provider(create: (_) => auth ?? const Auth()),
          Provider(create: (_) => store ?? Store(Firestore.instance)),
          Provider(create: (_) => dice ?? const Dice()),
        ],
        child: const HumanLifeGameApp._(),
      );

  @visibleForTesting
  static const supportedLocales = [Locale('en', 'US'), Locale('ja', 'JP')];

  @visibleForTesting
  static const defaultLocale = Locale('en', 'US');

  @visibleForTesting
  static ThemeData get theme => ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  @visibleForTesting
  static String onGenerateTitle(BuildContext context) => I18n.of(context).appTitle;

  @visibleForTesting
  static const List<LocalizationsDelegate<dynamic>> localizationDelegates = [
    I18nDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: onGenerateTitle,
        localizationsDelegates: localizationDelegates,
        supportedLocales: supportedLocales,
        locale: defaultLocale,
        theme: theme,
        home: Lobby.inProviders(),
        onGenerateRoute: context.watch<AppRouter>().generateRoutes,
      );
}
