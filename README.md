# HumanLifeGame

[![Flutter Version](https://img.shields.io/badge/Flutter-beta-64B5F6.svg)](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
[![Figma](https://img.shields.io/badge/Figma-a260bf.svg)](https://www.figma.com/file/nXa9iPmXYOHOA77GvjBLdj/HumanLifeGameGenarator)  
![Flutter Format](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Format/badge.svg)
![Flutter_Analyzer](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Analyzer/badge.svg)
![Flutter_Build_Web](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Build_Web/badge.svg)
![Flutter Test](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Test/badge.svg)  
[![Codecov](https://codecov.io/gh/sensuikan1973/HumanLifeGame/branch/master/graph/badge.svg)](https://codecov.io/gh/sensuikan1973/HumanLifeGame)

## What's is this game ?

Play now Human Life Game on Web. You can also create original map.

## [Setup](https://flutter.dev/web)

## Document

```sh
See: https://github.com/dart-lang/dartdoc/pull/2175
FLUTTER_ROOT=~/development/flutter dartdoc --output doc/api && open doc/api/index.html
```

## i18n対応
1. i18n/i18n.dartに英語で文言を追加

2. arbファイルの生成
```sh
./lib/i18n/create_arb.sh
```
3. i18n/intl_ja.arbに日本語で文言を追加し、i18n/intl_en.arbにi18n/intl_messages.arbをコピーする。

4. 作成したarbファイルにlocaleを追加する
```
# intl_en.arb
"@@locale": "en",
# intl_ja.arb
"@@locale": "ja",
```

5. classファイルの生成
./lib/i18n/create_message_class.sh

6. I18n.of(context).hogeで呼び出す