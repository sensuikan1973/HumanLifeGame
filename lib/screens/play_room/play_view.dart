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
  Widget build(BuildContext context) => SizedBox(
        width: 1050,
        height: 750,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1200,
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    SliverToBoxAdapter(
                      child: _playView(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Card _playView(BuildContext context) {
    final playRoomModel = context.watch<PlayRoomNotifier>();
    return Card(
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
    );
  }
}
