import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:intl/intl.dart';

/// PlayRoom Locale Text
extension I18nPlayRoom on I18n {
  String get rollDice => Intl.message(
        'Roll the dice',
        name: 'rollDice',
        locale: localeName,
      );
  String get lifeEventRecordsText => Intl.message(
        'Reserved area:lifeEventRecords',
        name: 'lifeEventRecordsText',
        locale: localeName,
      );
  String rollAnnouncement(int roll) => Intl.message(
        'result: $roll',
        name: 'rollAnnouncement',
        args: [roll],
        locale: localeName,
      );
}
