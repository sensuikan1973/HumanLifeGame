import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:intl/intl.dart';

/// PlayRoom Locale Text
extension PlayRoom on I18n {
  String get rollDice => Intl.message(
        'roll the dice',
        name: 'rollDice',
        locale: localeName,
      );
}
