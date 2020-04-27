import 'package:HumanLifeGame/domain/play_room/play_room.dart';
import 'package:flutter/material.dart';

class HumanLifeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Human Life Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlayRoom(),
      );
}
