import 'package:flutter/material.dart';

class AnimationCombination {
  final Animation<double> animationScale;
  final Animation<double> animationRotation;

  AnimationCombination(
    this.animationScale,
    this.animationRotation,
  );
}
