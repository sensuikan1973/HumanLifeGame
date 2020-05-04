import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:intl/intl.dart';

/// Common Locale Text
extension I18nCommon on I18n {
  String get appTitle => Intl.message(
        'Human Life Game',
        name: 'appTitle',
        locale: localeName,
      );
  String get lifeStepStartText => Intl.message(
        'Start',
        name: 'lifeStepStartText',
        locale: localeName,
      );
  String get lifeStepGoalText => Intl.message(
        'Goal',
        name: 'lifeStepGoalText',
        locale: localeName,
      );
  String get lifeStepGainItemText => Intl.message(
        'Gain Item :',
        name: 'lifeStepGainItemText',
        locale: localeName,
      );
}
