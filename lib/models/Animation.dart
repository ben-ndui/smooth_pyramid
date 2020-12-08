import 'package:flutter/material.dart';

class Animations {
  // Slide animation, from right to left (Slide animation)
  static fromLeft(Animation<double> _animation,
      Animation<double> _secondAnimation, Widget _child) {
    return SlideTransition(
      child: _child,
      position: Tween<Offset>(end: Offset.zero, begin: Offset(1.0, 0.0))
          .animate(_animation),
    );
  }

  // Slide animation, from left to right (Slide animation)
  static fromRight(Animation<double> _animation,
      Animation<double> _secondAnimation, Widget _child) {
    return SlideTransition(
      child: _child,
      position: Tween<Offset>(end: Offset.zero, begin: Offset(-1.0, 0.0))
          .animate(_animation),
    );
  }

  // Slide animation, from top to bottom (Slide animation)
  static fromTop(Animation<double> _animation,
      Animation<double> _secondAnimation, Widget _child) {
    return SlideTransition(
      child: _child,
      position: Tween<Offset>(end: Offset.zero, begin: Offset(0.0, -1.0))
          .animate(_animation),
    );
  }

  // Slide animation, from bottom to top (Slide animation)
  static fromBottom(Animation<double> _animation,
      Animation<double> _secondAnimation, Widget _child) {
    return SlideTransition(
      child: _child,
      position: Tween<Offset>(end: Offset.zero, begin: Offset(0.0, 1.0))
          .animate(_animation),
    );
  }

  // slide animation with grow effect
  static grow(Animation<double> _animation, Animation<double> _secondAnimation,
      Widget _child) {
    return ScaleTransition(
      child: _child,
      scale: Tween<double>(end: 1.0, begin: 0.0).animate(CurvedAnimation(
          parent: _animation,
          curve: Interval(0.00, 0.50, curve: Curves.linear))),
    );
  }

  // slide animation with shrink effect
  static shrink(Animation<double> _animation,
      Animation<double> _secondAnimation, Widget _child) {
    return ScaleTransition(
      child: _child,
      scale: Tween<double>(end: 1.0, begin: 0.0).animate(CurvedAnimation(
          parent: _animation,
          curve: Interval(0.50, 1.00, curve: Curves.linear))),
    );
  }
}
