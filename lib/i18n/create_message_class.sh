#!/bin/bash
flutter pub run intl_translation:generate_from_arb \
--output-dir=lib/i18n/ \
--no-use-deferred-loading \
lib/i18n/i18n.dart lib/i18n/extensions/*.dart \
lib/i18n/intl_*.arb

# 本当は exclude option 的なのがあれば使いたいけど、無い。
# See: https://github.com/dart-lang/dart_style/issues/864#issuecomment-544628480
# ↑みたくやってもいいけど、まあ format だけだしここに入れちゃってる
dart format ./ -l 120