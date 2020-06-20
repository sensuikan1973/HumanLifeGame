import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'api/auth.dart';
import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'i18n/i18n_delegate.dart';
import 'router.dart';

class HumanLifeGameApp extends StatelessWidget {
  const HumanLifeGameApp._();

  static Widget inProviders({Key key, Auth auth, Dice dice, Firestore fireStore}) => MultiProvider(
        key: key,
        providers: [
          Provider(create: (_) => Router()),
          Provider(create: (_) => auth ?? const Auth()),
          Provider(create: (_) => fireStore ?? Firestore.instance),
          Provider(create: (_) => dice ?? const Dice()),
        ],
        child: const HumanLifeGameApp._(),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
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
        initialRoute: context.watch<Router>().initial,
        routes: context.watch<Router>().routes,
      );
}
