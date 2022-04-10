import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_countup/data/count_data.dart';

import 'count_data_changed_notifier.dart';

class SoundLogic with CountDataChangedNotifier {
  static const SOUND_DATA_UP = 'sounds/Onmtp-Flash07-1.mp3';
  static const SOUND_DATA_DOWN = 'sounds/Onmtp-Flash08-1.mp3';
  static const SOUND_DATA_RESET = 'sounds/Onmtp-Flash09-1.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  void valueChanged(CountData oldValue, CountData newValue) {
    if (newValue.countUp == 0 &&
        newValue.countDown == 0 &&
        newValue.count == 0) {
      playRestSound();
    } else if (oldValue.countUp + 1 == newValue.countUp) {
      playUpSound();
    } else if (oldValue.countDown + 1 == newValue.countDown) {
      playDownSound();
    }
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
