#!/bin/bash
flutter pub run intl_translation:extract_to_arb \
--output-dir=./lib/i18n \
lib/i18n/i18n.dart lib/i18n/extensions/*.dart
