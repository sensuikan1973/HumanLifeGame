import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../common/life_road.dart';
import 'human.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // この変更は listenable にしておき、Human の位置更新を下位に伝える
    final playRoomModel = Provider.of<PlayRoomModel>(context, listen: true);

    return SizedBox(
      width: 1050,
      height: 700,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
        ),
        child: Center(
          child: LifeRoad(
            playRoomModel.humanLife.lifeRoad,
            humans: playRoomModel.humans.map((humanModel) => Human(humanModel)).toList(),
            positionsByHumanId: playRoomModel.positionsByHumanId,
          ),
        ),
      ),
    );
  }
}
