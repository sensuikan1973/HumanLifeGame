# HumanLifeGame

[![Flutter Version](https://img.shields.io/badge/Flutter-beta-64B5F6.svg?logo=flutter)](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
[![Figma](https://img.shields.io/badge/Figma-429bf5.svg?logo=figma)](https://www.figma.com/file/nXa9iPmXYOHOA77GvjBLdj/HumanLifeGame)
[![SpreadSheet](https://img.shields.io/badge/SpreadSheet-grey.svg?logo=google%20sheets)](https://docs.google.com/spreadsheets/d/1ghhCb5Ux7Mj52QEMrPy4rUhteCk3KgohG1JM29yjhS0)
[![API_Document](https://img.shields.io/badge/API_Document-025697.svg?logo=dart)](https://sensuikan1973.github.io/HumanLifeGame/)  
![Flutter Format](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Format/badge.svg)
![Flutter_Analyzer](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Analyzer/badge.svg)
[![Flutter_Web_Deploy](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Web_Deploy/badge.svg)](https://human-life-game-dev.web.app/)
![Flutter Test](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Test/badge.svg)  
[![Codecov](https://codecov.io/gh/sensuikan1973/HumanLifeGame/branch/master/graph/badge.svg)](https://codecov.io/gh/sensuikan1973/HumanLifeGame)
[![HumanLifeGame_Server](https://img.shields.io/badge/ServerSide-000000.svg?logo=github)](https://github.com/sensuikan1973/HumanLifeGame_Server)

## What's is this game ?

Play now Human Life Game on Web. You can also create original map.

## Development

### Setup

1. https://flutter.dev/docs/get-started/web
2. `cp config/.env.sample config/.env`
3. Edit `config/.env`

### [Local Hosting](https://firebase.google.com/docs/hosting/deploying)
**You must serve hosting for Authentication**
```sh
flutter build web # optional
firebase use dev
firebase serve --only hosting --port=5000
```

### [Code Generate](https://pub.dev/packages/freezed)
```sh
flutter packages pub run build_runner build
```

### [i18n](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

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
