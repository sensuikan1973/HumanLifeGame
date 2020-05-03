import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:HumanLifeGame/models/play_room.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  group('LifeRoad', () {
    testWidgets('show LifeStep', (tester) async {
      await tester.pumpWidget(testableApp(locale: locale, home: LifeRoad()));
      await tester.pump();
      expect(find.byType(LifeStep), findsNWidgets(100));
    });
  });
}
