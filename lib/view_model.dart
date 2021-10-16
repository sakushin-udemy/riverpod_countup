import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup/data/count_data.dart';
import 'package:riverpod_countup/logic/button_animation_logic.dart';
import 'package:riverpod_countup/logic/count_data_changed_notifier.dart';
import 'package:riverpod_countup/logic/logic.dart';
import 'package:riverpod_countup/logic/sound_logic.dart';
import 'package:riverpod_countup/provider.dart';

class ViewModel {
  Logic _logic = Logic();

  SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;
  late ButtonAnimationLogic _buttonAnimationLogicMinus;
  late ButtonAnimationLogic _buttonAnimationLogicReset;

  late WidgetRef _ref;

  List<CountDataChangedNotifier> notifiers = [];

  void init(WidgetRef ref, TickerProvider tickerProvider) {
    this._ref = ref;

    ValueChangedCondition conditionPlus =
        (CountData oldValue, CountData newValue) {
      return oldValue.countUp + 1 == newValue.countUp;
    };

    _buttonAnimationLogicPlus =
        ButtonAnimationLogic(tickerProvider, conditionPlus);
    _buttonAnimationLogicMinus = ButtonAnimationLogic(tickerProvider,
        (CountData oldValue, CountData newValue) {
      return oldValue.countDown + 1 == newValue.countDown;
    });
    _buttonAnimationLogicReset = ButtonAnimationLogic(
      tickerProvider,
      (oldValue, newValue) => newValue.countUp == 0 && newValue.countDown == 0,
    );
    _soundLogic.load();

    notifiers = [
      _soundLogic,
      _buttonAnimationLogicPlus,
      _buttonAnimationLogicMinus,
      _buttonAnimationLogicReset,
    ];
  }

  get count => _ref.watch(countDataProvider).state.count.toString();
  get countUp => _ref
      .watch(countDataProvider.select((value) => value.state.countUp))
      .toString();
  get countDown => _ref
      .watch(countDataProvider.select((value) => value.state.countDown))
      .toString();

  get animationPlus => _buttonAnimationLogicPlus.animationScale;
  get animationMinus => _buttonAnimationLogicMinus.animationScale;
  get animationReset => _buttonAnimationLogicReset.animationScale;

  void onIncrease() {
    _logic.increase();
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

    notifiers.forEach((element) => element.valueChanged(oldValue, newValue));
  }
}
