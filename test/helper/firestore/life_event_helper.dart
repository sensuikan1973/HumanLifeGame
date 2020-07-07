import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/life_event_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/lose_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/select_direction_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';

const start = LifeEventEntity<StartParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.start,
  params: StartParams(),
);
const goals = LifeEventEntity<GoalParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.goal,
  params: GoalParams(),
);
const loses = LifeEventEntity<LoseLifeItemsParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.loseLifeItems,
  params: LoseLifeItemsParams(targetItems: []),
);
const gains = LifeEventEntity<GainLifeItemsParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.gainLifeItems,
  params: GainLifeItemsParams(targetItems: []),
);
const direc = LifeEventEntity<SelectDirectionParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.selectDirection,
  params: SelectDirectionParams(),
);
const blank = LifeEventEntity<NothingParams>(
  target: LifeEventTarget.myself,
  type: LifeEventType.nothing,
  params: NothingParams(),
);
