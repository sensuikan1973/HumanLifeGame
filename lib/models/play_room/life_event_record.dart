import '../../i18n/i18n.dart';

import '../common/human.dart';
import '../common/life_event.dart';

class LifeEventRecordModel {
  LifeEventRecordModel(this._i18n, this.human, this.lifeEventRecord);

  final HumanModel human;
  final LifeEventModel lifeEventRecord;
  final I18n _i18n;

  String get lifeEventRecordMessage => '${human.name} : ${_i18n.lifeStepEventType(lifeEventRecord.type)}';
}
