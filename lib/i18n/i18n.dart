import 'package:HumanLifeGame/i18n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class I18n {
  I18n(this.localeName);

  static Future<I18n> load(Locale locale) {
    final name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) => I18n(localeName));
  }

  static I18n of(BuildContext context) => Localizations.of<I18n>(context, I18n);

  final String localeName;

  String get start => Intl.message(
        'Start',
        name: 'start',
        desc: 'Text for start button.',
        locale: localeName,
      );
}
