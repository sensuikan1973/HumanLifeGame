import 'package:HumanLifeGame/models/common/human.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'models/play_room/play_room.dart';
import 'models/play_room/player_action.dart';
import 'screens/play_room/play_room.dart';

class Router {
  final String initialRoute = '/';

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PlayerActionModel(context.read<Dice>()),
            ),
            ChangeNotifierProxyProvider<PlayerActionModel, PlayRoomModel>(
              create: (_) => PlayRoomModel(
                I18n.of(context),
                // FIXME: Repository から取ってくる
                orderedHumans: [HumanModel('123', 'hoge'), HumanModel('456', 'fuga')],
              ),
              update: (context, playerAction, playRoom) => playRoom..playerAction = playerAction,
            )
          ],
          child: const PlayRoom(),
        ),
  };
}
