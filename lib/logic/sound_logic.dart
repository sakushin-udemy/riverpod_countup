import 'package:audioplayers/audioplayers.dart';

class SoundLogic {
  static const SOUND_DATA_UP = 'sounds/Onmtp-Flash07-1.mp3';
  static const SOUND_DATA_DOWN = 'sounds/Onmtp-Flash08-1.mp3';
  static const SOUND_DATA_RESET = 'sounds/Onmtp-Flash09-1.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  void playUpSound() {
    _cache.play(SOUND_DATA_UP);
  }

  void playDownSound() {
    _cache.play(SOUND_DATA_DOWN);
  }

  void playRestSound() {
    _cache.play(SOUND_DATA_RESET);
  }
}
