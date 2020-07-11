import '../../api/firestore/life_event_record.dart';
import '../../api/firestore/life_road.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../../entities/life_step_entity.dart';
import '../../entities/position.dart';
import 'life_stage.dart';

class PlayRoomState {
  PlayRoomState();

  Doc<LifeRoadEntity> lifeRoad;

  /// 現在手番の人に方向選択を求めているかどうか
  bool requireSelectDirection = false;

  /// サイコロの出目
  int roll = 0;

  /// 参加者
  List<Doc<UserEntity>> humans;

  /// 現在手番の Human
  Doc<UserEntity> currentTurnHuman;

  /// 全 Human の人生の進捗
  List<LifeStageModel> lifeStages = [];

  /// 全 Human の LifeEvent 履歴
  List<LifeEventRecordEntity> everyLifeEventRecords = [];

  /// お知らせ
  String announcement = 'announcement';

  /// 部屋タイトル
  String roomTitle = 'Room Title';

  /// 参加者全員がゴールに到着したかどうか
  bool get allHumansReachedTheGoal =>
      lifeStages.isNotEmpty && lifeStages.every((lifeStage) => lifeStage.lifeStepEntity.isGoal);

  /// 参加者全員の Position
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages)
          lifeStage.human.entity.uid: lifeRoad.entity.getPosition(lifeStage.lifeStepEntity),
      };

  /// 現在手番の Human が位置する LifeStep
  LifeStepEntity get currentHumanLifeStep =>
      lifeStages.firstWhere((lifeStage) => lifeStage.human == currentTurnHuman).lifeStepEntity;
}
