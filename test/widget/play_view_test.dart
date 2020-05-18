import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
  final orderedHumans = [HumanModel(id: 'h1', name: 'foo'), HumanModel(id: 'h2', name: 'bar')];
  final humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel(id: 'dummyUserId', name: 'dummyUser'),
    lifeRoad: LifeRoadModel(
      lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
        LifeRoadModel.dummyLifeEvents(),
      ),
    ),
  );

  testWidgets('show LifeStep, display size = (1440, 1024)', (tester) async {
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    final widgets = playRoomModel.humanLife.lifeRoad.height * playRoomModel.humanLife.lifeRoad.width;
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayView()),
    ));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(widgets));
  });
  testWidgets('show LifeStep, display size = (800, 500)', (tester) async {
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(800, 500));
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    final widgets = playRoomModel.humanLife.lifeRoad.height * playRoomModel.humanLife.lifeRoad.width;
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayView()),
    ));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(widgets));
  });
}
