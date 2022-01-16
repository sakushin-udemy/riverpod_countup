import 'package:flutter/material.dart';

import 'animation_combination.dart';

class ButtonAnimation extends StatelessWidget {
  final AnimationCombination animationCombination;
  final Widget child;
  const ButtonAnimation({
    Key? key,
    required this.animationCombination,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animationCombination.animationScale,
      child: RotationTransition(
        turns: animationCombination.animationRotation,
        child: child,
      ),
    );
  }
}
