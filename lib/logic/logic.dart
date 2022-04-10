import 'package:riverpod_countup/data/count_data.dart';

class Logic {
  CountData _countData = CountData(
    count: 0,
    countUp: 0,
    countDown: 0,
  );

  get countData => _countData;

  void increase() {
    _countData = _countData.copyWith(
      count: _countData.count + 1,
      countUp: _countData.countUp + 1,
    );
  }

  void decrease() {
    _countData = _countData.copyWith(
      count: _countData.count - 1,
      countDown: _countData.countDown + 1,
    );
  }

  void reset() {
    _countData = CountData(
      count: 0,
      countUp: 0,
      countDown: 0,
    );
  }

  void init(CountData countData) {
    _countData = countData;
  }
}
