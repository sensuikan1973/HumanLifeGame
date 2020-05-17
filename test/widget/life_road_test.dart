import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final model = LifeRoadModel(
    lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
      LifeRoadModel.dummyLifeEvents(),
    ),
  );
  testWidgets('show LifeStep', (tester) async {
    await tester.pumpWidget(testableApp(home: LifeRoad(model)));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(model.width * model.height));
  });
}
