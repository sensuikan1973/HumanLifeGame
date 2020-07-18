import '../../api/firestore/life_event_record.dart';
import '../../api/firestore/life_road.dart';
import '../../api/firestore/life_stage.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../../api/life_step_entity.dart';
import '../../entities/position.dart';

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
  List<LifeStageEntity> lifeStages = [];

  /// 全 Human の LifeEvent 履歴
  List<LifeEventRecordEntity> everyLifeEventRecords = [];

  /// お知らせ
  String announcement = 'announcement';

  /// 部屋タイトル
  String roomTitle = 'Room Title';

  /// 参加者全員がゴールに到着したかどうか
  bool get allHumansReachedTheGoal =>
      lifeStages.isNotEmpty &&
      lifeStages.every((lifeStage) => lifeRoad.entity.getStepEntity(lifeStage.currentLifeStepId).isGoal);

  /// 参加者全員の Position
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages)
          lifeStage.human.documentID: lifeRoad.entity.getPosition(
            lifeRoad.entity.getStepEntity(lifeStage.currentLifeStepId),
          ),
      };

  /// 現在手番の Human が位置する LifeStep
  LifeStepEntity get currentHumanLifeStep => lifeRoad.entity.getStepEntity(
        lifeStages.firstWhere((lifeStage) => lifeStage.human.documentID == currentTurnHuman.id).currentLifeStepId,
      );
}
