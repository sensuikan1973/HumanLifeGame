import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

export 'extensions/i18n_common.dart';
export 'extensions/i18n_play_room.dart';

class I18n {
  I18n(this.localeName);

  static Future<I18n> load(Locale locale) async {
    final name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;
    await initializeMessages(localeName);
    return I18n(localeName);
  }

  static I18n of(BuildContext context) => Localizations.of<I18n>(context, I18n);

  final String localeName;
}
