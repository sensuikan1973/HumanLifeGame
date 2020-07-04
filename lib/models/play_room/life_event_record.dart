import 'package:firestore_ref/firestore_ref.dart';

import '../../api/firestore/life_event.dart';
import '../../api/firestore/user.dart';
import '../../i18n/i18n.dart';

class LifeEventRecordModel {
  LifeEventRecordModel(this._i18n, this.human, this.lifeEvent);

  final Document<UserEntity> human;
  final LifeEventEntity lifeEvent;
  final I18n _i18n;

  String get lifeEventRecordMessage => '${human.entity.displayName} : ${_i18n.lifeStepEventType(lifeEvent.type)}';
}
