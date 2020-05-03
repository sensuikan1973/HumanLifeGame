import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:intl/intl.dart';

/// Common Locale Text
extension I18nCommon on I18n {
  String get appTitle => Intl.message(
        'Human Life Game',
        name: 'appTitle',
        locale: localeName,
      );
}
