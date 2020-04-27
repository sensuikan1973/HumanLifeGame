import 'package:HumanLifeGame/domain/play_room/play_room.dart';
import 'package:flutter/material.dart';

import 'i18n/i18n_delegate.dart';

class HumanLifeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: const [
          I18nDelegate(),
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ja', 'JP'),
        ], // TODO: いつか Locale(‘en’, ‘US’) もサポートする
        locale: const Locale('ja'),
        title: 'Human Life Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlayRoom(),
      );
}
