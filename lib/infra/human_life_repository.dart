import 'package:HumanLifeGame/models/human_life.dart';
import 'package:HumanLifeGame/models/life_road.dart';
import 'package:HumanLifeGame/models/user.dart';

class HumanLifeRepository {
  // 実際には外部 API からの fetch になるので、当然返り値は Future になる
  Future<HumanLifeModel> fetchDuumyHumanLife() => Future.value(
        HumanLifeModel(
          title: 'dummy HumanLife',
          author: UserModel('dummyUseUd', 'dummyUser', DateTime.now(), DateTime.now()),
          lifeRoad: LifeRoadModel.dummy(),
        ),
      );
}
