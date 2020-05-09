import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);

  testWidgets('show initial total moneys', (tester) async {
    final playRoomModel = PlayRoomModel(i18n);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('0'), findsNWidgets(2));
  });

  testWidgets('show variable total moneys', (tester) async {
    final playRoomModel = PlayRoomModel(i18n);
    for (final lifeStage in playRoomModel.lifeStages) {
      lifeStage.lifeItems.add(LifeItemModel('key', LifeItemType.money, 200));
    }
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('200'), findsNWidgets(2));
  });

  testWidgets('show current player', (tester) async {
    final playRoomModel = PlayRoomModel(i18n);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    final currentPlayerSelector = find.byIcon(Icons.chevron_right);
    final row = tester.element(currentPlayerSelector).findAncestorWidgetOfExactType<Row>();
    final human1Name = find.text('human_1_name');
    expect(row.children, contains(human1Name.evaluate().first.widget));
  });
}
