import 'package:flutter/material.dart';
import 'dart:math';

class DisappearingFab extends StatefulWidget {
  final bool finalStateVisible;
  final Widget child;
  final Duration duration;
  final Duration initalDelay;
  static const Duration defaultDuration = Duration(milliseconds: 1000);
  static const Duration defaultInitialDelayDuration =
      Duration(milliseconds: 500);

  DisappearingFab({
    Key key,
    @required this.child,
    this.finalStateVisible = true,
    this.duration = defaultDuration,
    this.initalDelay = defaultInitialDelayDuration,
  }) : super(key: key);
  @override
  DisappearingFabState createState() => DisappearingFabState();
}

class DisappearingFabState extends State<DisappearingFab>
    with SingleTickerProviderStateMixin {
  bool didRun = false;
  AnimationController _controller;
  Animation<double> doubleAnimation;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {});
    });

    doubleAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeOut));
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!didRun) {
      didRun = true;
      await Future.delayed(widget.initalDelay, () {
        _controller.forward().orCancel;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int cycles = 1;
    if (_controller.isCompleted || _controller.isDismissed) {
      if (widget.finalStateVisible && _controller.value < 1.0) {
        _controller.forward().orCancel;
      }
      if (widget.finalStateVisible == false && _controller.value > 0.0) {
        _controller.reverse().orCancel;
      }
    }
    return AnimatedBuilder(
      animation: doubleAnimation,
      child: widget.child,
      builder: (context, child) {
        if (doubleAnimation.value == 0) {
          return SizedBox.shrink();
        }
        return Transform.rotate(
          angle: 2 * pi * doubleAnimation.value * cycles,
          child: Opacity(
            opacity: doubleAnimation.value,
            child: child,
          ),
        );
      },
    );
  }
}
