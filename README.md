# HumanLifeGame

[![Flutter Version](https://img.shields.io/badge/Flutter-beta-64B5F6.svg?logo=flutter)](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels)
[![Figma](https://img.shields.io/badge/Figma-grey.svg?logo=figma)](https://www.figma.com/file/nXa9iPmXYOHOA77GvjBLdj/HumanLifeGame)
[![GoogleDrive](https://img.shields.io/badge/GoogleDrive-grey.svg?logo=google%20drive)](https://drive.google.com/drive/u/0/folders/1yxBm-ArcEtR_Tfe949nEzk5b6jnjjFV7)
[![API_Document](https://img.shields.io/badge/API_Document-025697.svg?logo=dart)](https://sensuikan1973.github.io/HumanLifeGame/)  
![Flutter Format](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Format/badge.svg)
![Flutter_Analyzer](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Analyzer/badge.svg)
[![Flutter_Web_Deploy](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Web_Deploy/badge.svg)](https://human-life-game-dev.web.app/)
![Flutter Test](https://github.com/sensuikan1973/HumanLifeGame/workflows/Flutter_Test/badge.svg)  
[![Codecov](https://codecov.io/gh/sensuikan1973/HumanLifeGame/branch/master/graph/badge.svg)](https://codecov.io/gh/sensuikan1973/HumanLifeGame)
[![HumanLifeGame_Server](https://img.shields.io/badge/ServerSide-000000.svg?logo=github)](https://github.com/sensuikan1973/HumanLifeGame_Server)

## What's this game ?

Play now Human Life Game on Web. You can also create original _Life_.

## Development

### Setup

1. https://flutter.dev/docs/get-started/web
2. `cp config/.env.sample config/.env && vim config/.env`

### [Local Hosting](https://firebase.google.com/docs/hosting/deploying)
```sh
firebase serve --only hosting
```

### with [Firebase Emulator](https://firebase.google.com/docs/emulator-suite)
```sh
# Server Side
firebase emulators:start --only firestore,functions
```

then, run by `main_emulator` config. (Note: [Auth Trigger is not supported](https://firebase.google.com/docs/emulator-suite#which_firebase_features_and_platforms_are_supported))

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

### [DartDoc](https://pub.dev/packages/dartdoc)
```sh
FLUTTER_HOME=~/development/flutter/ \
&& FLUTTER_ROOT=$FLUTTER_HOME dartdoc --output docs/ \
&& open docs/index.html
```