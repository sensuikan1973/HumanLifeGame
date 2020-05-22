import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../common/human.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  /// 手番順に基づく色
  List<Color> get _orderedColors => [Colors.red, Colors.blue, Colors.green, Colors.yellow];
  Size get _desktopSize => const Size(1440, 1024);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final model = context.watch<PlayRoomNotifier>();

    final lifeStepSize = Size(
      screenSize.width >= _desktopSize.width ? 150 : 130,
      100,
    );
    final lifeRoadSize = Size(
      lifeStepSize.width * model.humanLife.lifeRoad.width,
      lifeStepSize.height * model.humanLife.lifeRoad.height,
    );

    return Card(
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

  DecoratedBox _playView(PlayRoomNotifier model, Size size) => DecoratedBox(
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
      );
}
