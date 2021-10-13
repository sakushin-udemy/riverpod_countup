import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup/data/count_data.dart';
import 'package:riverpod_countup/logic/button_animation_logic.dart';
import 'package:riverpod_countup/logic/logic.dart';
import 'package:riverpod_countup/logic/sound_logic.dart';
import 'package:riverpod_countup/provider.dart';

class ViewModel {
  Logic _logic = Logic();

  SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;

  late WidgetRef _ref;

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    this._ref = ref;

    _buttonAnimationLogicPlus = ButtonAnimationLogic(tickerProvider);
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider).state.count.toString();
  get countUp => _ref
      .watch(countDataProvider.select((value) => value.state.countUp))
      .toString();
  get countDown => _ref
      .watch(countDataProvider.select((value) => value.state.countDown))
      .toString();

  get animationPlus => _buttonAnimationLogicPlus.animationScale;

  void onIncrease() {
    _logic.increase();
    _buttonAnimationLogicPlus.start();
    update();
  }

  void onDecrease() {
    _logic.decrease();
    update();
  }

  void onReset() {
    _logic.reset();
    update();
  }

  void update() {
    CountData oldValue = _ref.watch(countDataProvider).state;
    _ref.watch(countDataProvider).state = _logic.countData;
    CountData newValue = _ref.watch(countDataProvider).state;

    _soundLogic.valueChanged(oldValue, newValue);
  }
}
