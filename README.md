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

## Development

### Setup

See: https://flutter.dev/docs/get-started/web

### i18n

1. add English text to `i18n/extensions/*.dart`
2. create arb files

```sh
./lib/i18n/create_arb.sh
```

3. copy `i18n/intl_messages.arb` to `i18n/intl_en.arb`
4. add Japanese text to `i18n/intl_ja.arb`
5. create dart classes

```sh
./lib/i18n/create_message_class.sh
```

6. you can call `I18n.of(context).hoge`

### Document

```sh
See: https://github.com/dart-lang/dartdoc/pull/2175
FLUTTER_ROOT=~/development/flutter dartdoc --output doc/api && open doc/api/index.html
```
