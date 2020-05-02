#!/bin/bash
flutter pub run intl_translation:generate_from_arb \
--output-dir=lib/i18n/ \
--no-use-deferred-loading \
lib/i18n/i18n.dart lib/i18n/extensions/*.dart \
lib/i18n/intl_*.arb
