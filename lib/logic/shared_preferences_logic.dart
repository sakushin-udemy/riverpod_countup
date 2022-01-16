import 'package:riverpod_countup/data/count_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'count_data_changed_notifier.dart';

class SharedPreferencesLogic with CountDataChangedNotifier {
  static const keyCount = 'COUNT';
  static const keyCountUp = 'COUNT_UP';
  static const keyCountDown = 'COUNT_DOWN';

  @override
  void valueChanged(CountData oldValue, CountData newValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(keyCount, newValue.count);
    sharedPreferences.setInt(keyCountUp, newValue.countUp);
    sharedPreferences.setInt(keyCountDown, newValue.countDown);
  }

  static Future<CountData> read() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return CountData(
      count: await sharedPreferences.getInt(keyCount) ?? 0,
      countUp: await sharedPreferences.getInt(keyCountUp) ?? 0,
      countDown: await sharedPreferences.getInt(keyCountDown) ?? 0,
    );
  }
}
