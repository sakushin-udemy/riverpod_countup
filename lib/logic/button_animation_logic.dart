import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_countup/data/count_data.dart';

import '../animation_combination.dart';
import 'count_data_changed_notifier.dart';

class ButtonAnimationLogic with CountDataChangedNotifier {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotation;

  late AnimationCombination _animationCombination;

  get animationCombination => _animationCombination;

  ValueChangedCondition startCondition;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: Duration(milliseconds: 500),
    );

    _animationScale = _animationController
        .drive(CurveTween(curve: Interval(0.1, 0.7)))
        .drive(Tween(begin: 1.0, end: 1.8));

    _animationRotation = _animationController
        .drive(CurveTween(
            curve: Interval(
          0.4,
          0.8,
          curve: ButtonRotateCurve(),
        )))
        .drive(Tween(begin: 0.0, end: 1.0));

    _animationCombination =
        AnimationCombination(_animationScale, _animationRotation);
  }

  @override
  void dispose() {
    _animationController.dispose();
  }

  void start() {
    _animationController.forward().whenComplete(
          () => _animationController.reset(),
        );
  }

  @override
  void valueChanged(CountData oldValue, CountData newValue) {
    if (startCondition(oldValue, newValue)) {
      start();
    }
  }
}

class ButtonRotateCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(2 * math.pi * t) / 16;
  }
}
