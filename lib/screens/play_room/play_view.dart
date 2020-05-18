import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../common/human.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  /// 手番順に基づく色
  List<Color> get _orderedColors => [Colors.red, Colors.blue, Colors.green, Colors.yellow];
  Size get _desktop => const Size(1440, 1020);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final model = context.watch<PlayRoomNotifier>();

    final lifeStepSize = Size(
      screen.width >= _desktop.width ? 150 : 130,
      100,
    );
    final lifeRoadSize = Size(
      lifeStepSize.width * model.humanLife.lifeRoad.width,
      lifeStepSize.height * model.humanLife.lifeRoad.height,
    );

    return SizedBox(
      width: 1050,
      height: 750,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: lifeStepSize.height * model.humanLife.lifeRoad.height,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    child: _playView(model, lifeRoadSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card _playView(PlayRoomNotifier model, Size size) => Card(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: LifeRoad(
              model.humanLife.lifeRoad,
              size.width,
              size.height,
              humans: [
                for (var i = 0; i < model.orderedHumans.length; ++i)
                  Human(
                    model.orderedHumans[i],
                    _orderedColors[i],
                  ),
              ],
              positionsByHumanId: model.positionsByHumanId,
            ),
          ),
        ),
      );
}
