import 'package:intl/intl.dart';

import '../i18n.dart';

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
  String rollAnnouncement(String name, int roll) => Intl.message(
        '$name rolled the dice. result: $roll',
        name: 'rollAnnouncement',
        args: [name, roll],
        locale: localeName,
      );
  String get playerActionYes => Intl.message(
        'YES',
        name: 'playerActionYes',
        locale: localeName,
      );
  String get playerActionNo => Intl.message(
        'NO',
        name: 'playerActionNo',
        locale: localeName,
      );
}
