import '../models/common/human_life.dart';
import '../models/common/life_road.dart';
import '../models/common/user.dart';

class HumanLifeRepository {
  // 実際には外部 API からの fetch になるので、当然返り値は Future になる
  Future<HumanLifeModel> fetchDummyHumanLife() => Future.value(
        HumanLifeModel(
          title: 'dummy HumanLife',
          author: UserModel(id: 'dummyUseUd', name: 'dummyUser'),
          lifeRoad: LifeRoadModel(
            lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
              LifeRoadModel.dummyLifeEvents(),
            ),
          ),
        ),
      );
}
