import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:intl/intl.dart';

/// PlayRoom Locale Text
extension PlayRoom on I18n {
  String get rollDice => Intl.message(
        'Roll the dice',
        name: 'rollDice',
        locale: localeName,
      );
  String get lifeEventRecordesText => Intl.message(
        'Reserved area:lifeEventRecords',
        name: 'lifeEventRecordesText',
        locale: localeName,
      );
}
