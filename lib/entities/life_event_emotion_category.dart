/// Event が対象者にもたらす感情カテゴリ
enum LifeEventEmotionCategory {
  /// 恩恵を受ける種類の Event を指す
  positive,

  /// 損害を受ける種類の Event を指す
  negative,

  /// 特に何の恩恵も損害も受けない種類の Event を指す
  normal,

  /// 恩恵を受けるか損害を受けるかが不定な種類の Event を指す
  challenge,
}
