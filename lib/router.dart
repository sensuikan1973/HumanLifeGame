import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'models/common/human.dart';
import 'models/common/human_life.dart';
import 'models/common/life_road.dart';
import 'models/common/user.dart';
import 'models/play_room/play_room.dart';
import 'screens/play_room/play_room.dart';
import 'screens/sign_in/sign_in.dart';

@immutable
class Router {
  /// FIXME: 当然今だけ.
  String get initial => playRoom;
  final String signIn = '/sign_in';
  final String playRoom = '/play_room';

  Map<String, WidgetBuilder> get routes => {
        signIn: (context) => const SignIn(),
        playRoom: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<PlayRoomNotifier>(
                  create: (_) => PlayRoomNotifier(
                    I18n.of(context),
                    context.read<Dice>(),
                    // FIXME: Repository から取ってくる
                    HumanLifeModel(
                      title: 'dummy HumanLife',
                      author: UserModel(id: '123', name: 'dummyUser'),
                      lifeRoad: LifeRoadModel(
                        lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
                          LifeRoadModel.dummyLifeEvents(),
                        ),
                      ),
                    ),
                    [
                      HumanModel(id: '1', name: 'hoge', order: 0),
                      HumanModel(id: '2', name: 'fuga', order: 1),
                    ],
                  ),
                )
              ],
              child: const PlayRoom(),
            ),
      };
}
