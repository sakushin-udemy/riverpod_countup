import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup/logic.dart';
import 'package:riverpod_countup/provider.dart';

class ViewModel {
  Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    this._ref = ref;
  }

  get count => _ref.watch(countDataProvider).state.count.toString();
  get countUp => _ref
      .watch(countDataProvider.select((value) => value.state.countUp))
      .toString();
  get countDown => _ref
      .watch(countDataProvider.select((value) => value.state.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();

    _ref.watch(countDataProvider).state = _logic.countData;
  }

  void onDecrease() {
    _logic.decrease();

    _ref.watch(countDataProvider).state = _logic.countData;
  }

  void onReset() {
    _logic.reset();

    _ref.watch(countDataProvider).state = _logic.countData;
  }
}
