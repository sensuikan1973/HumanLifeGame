import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

void main() {
  group('PlayerAction', () {
    testWidgets("show 'start' text", (tester) async {
      await tester.pumpWidget(testableApp(home: PlayerAction()));
      await tester.pump();
      expect(find.text(I18n('ja').rollDice), findsOneWidget);
    });
  });
}
