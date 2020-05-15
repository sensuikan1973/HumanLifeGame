import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../common/human.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  /// 手番順に基づく色
  List<Color> get _orderedColors => [Colors.red, Colors.blue, Colors.green, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    final playRoomModel = context.watch<PlayRoomModel>();
    return Card(
      child: SizedBox(
        width: 1050,
        height: 750,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: LifeRoad(
              playRoomModel.humanLife.lifeRoad,
              humans: [
                for (var i = 0; i < playRoomModel.orderedHumans.length; ++i)
                  Human(
                    playRoomModel.orderedHumans[i],
                    _orderedColors[i],
                  ),
              ],
              positionsByHumanId: playRoomModel.positionsByHumanId,
            ),
          ),
        ),
      ),
    );
  }
}
