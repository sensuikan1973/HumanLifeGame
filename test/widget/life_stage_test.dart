import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  final orderedHumans = [HumanModel(id: 'h1', name: 'foo'), HumanModel(id: 'h2', name: 'bar')];
  final humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel('dummyUserId', 'dummyUser', DateTime.now(), DateTime.now()),
    lifeRoad: LifeRoadModel.dummy(),
  );

  testWidgets('show initial total moneys', (tester) async {
    final playRoomModel = PlayRoomModel(i18n, orderedHumans: orderedHumans, humanLife: humanLife);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('0'), findsNWidgets(playRoomModel.lifeStages.length));
  });

  testWidgets('show variable total moneys', (tester) async {
    final playRoomModel = PlayRoomModel(i18n, orderedHumans: orderedHumans, humanLife: humanLife);
    for (final lifeStage in playRoomModel.lifeStages) {
      lifeStage.lifeItems.add(LifeItemModel('key', LifeItemType.money, 200));
    }
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('200'), findsNWidgets(playRoomModel.lifeStages.length));
  });

  testWidgets('show current player', (tester) async {
    final playRoomModel = PlayRoomModel(i18n, orderedHumans: orderedHumans, humanLife: humanLife);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    final currentPlayerSelector = find.byIcon(Icons.chevron_right);
    final row = tester.element(currentPlayerSelector).findAncestorWidgetOfExactType<Row>();
    final currentPlayerNameText = find.text(playRoomModel.currentPlayer.name);
    expect(row.children, contains(currentPlayerNameText.evaluate().first.widget));
  });
}
