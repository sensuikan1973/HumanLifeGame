import 'package:flutter/material.dart';

import 'i18n.dart';

@immutable
class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) async => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
