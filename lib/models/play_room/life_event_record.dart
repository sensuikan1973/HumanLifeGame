import 'package:firestore_ref/firestore_ref.dart';

import '../../api/firestore/user.dart';
import '../../i18n/i18n.dart';
import '../common/life_event.dart';

class LifeEventRecordModel {
  LifeEventRecordModel(this._i18n, this.human, this.lifeEventRecord);

  final Document<UserEntity> human;
  final LifeEventModel lifeEventRecord;
  final I18n _i18n;

  String get lifeEventRecordMessage => '${human.entity.displayName} : ${_i18n.lifeStepEventType(lifeEventRecord.type)}';
}
