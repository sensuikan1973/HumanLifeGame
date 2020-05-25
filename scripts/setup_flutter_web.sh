flutter config --enable-web
flutter pub get
flutter packages pub run build_runner build
cp config/.env.sample config/.env
