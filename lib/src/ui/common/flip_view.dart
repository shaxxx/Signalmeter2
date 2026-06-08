// Vendored from the `flutter_flip_view` package (single-file widget), migrated
// to null safety. Inlined into the app so there is no external/path dependency
// to resolve or publish. Used only by the profile list item's flip animation.
//
// Original source: https://github.com/shaxxx/flutter_flip_view (fork of the
// pub.dev `flutter_flip_view` package).
//
// BSD 2-Clause License
//
// Copyright (c) 2019, WosLovesLife
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:math';

import 'package:flutter/material.dart';

typedef FlipWidgetBuilder = Widget Function(
    BuildContext context, bool isBackground);

class FlipView extends StatefulWidget {
  final Widget front;
  final Widget back;
  final Animation<double> animationController;
  final AxisDirection goBackDirection;
  final AxisDirection goFrontDirection;

  const FlipView({
    super.key,
    required this.front,
    required this.back,
    required this.animationController,
    AxisDirection? goBackDirection,
    AxisDirection? goFrontDirection,
  })  : goBackDirection = goBackDirection ?? AxisDirection.left,
        goFrontDirection = goFrontDirection ?? AxisDirection.left;

  @override
  FlipViewState createState() => FlipViewState();
}

class FlipViewState extends State<FlipView>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  AnimationStatus? _lastStatus;

  @override
  void initState() {
    super.initState();
    _animation = _calculateTweenSequence(widget.goBackDirection);

    widget.animationController.addStatusListener((AnimationStatus status) {
      if (_lastStatus == status) return;
      _lastStatus = status;

      if (!mounted) return;

      if (status == AnimationStatus.completed ||
          status == AnimationStatus.reverse) {
        _animation = _calculateTweenSequence(widget.goFrontDirection);
      } else if (status == AnimationStatus.dismissed ||
          status == AnimationStatus.forward) {
        _animation = _calculateTweenSequence(widget.goBackDirection);
      }
    });
  }

  Animation<double> _calculateTweenSequence(AxisDirection direction) {
    final reverse =
        (direction == AxisDirection.right || direction == AxisDirection.down);
    final frontTween = Tween(
      begin: 0.0,
      end: reverse ? -pi / 2.0 : pi / 2.0,
    );
    final backTween = Tween(
      begin: reverse ? pi / 2.0 : -pi / 2.0,
      end: 0.0,
    );
    return TweenSequence([
      TweenSequenceItem(tween: frontTween, weight: 0.5),
      TweenSequenceItem(tween: backTween, weight: 0.5),
    ]).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    final front = widget.front;
    final back = widget.back;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        final direction = (_animation.status == AnimationStatus.forward ||
                _animation.status == AnimationStatus.completed)
            ? widget.goBackDirection
            : widget.goFrontDirection;
        return Transform(
          transform: _buildTransform(direction),
          alignment: Alignment.center,
          child: IndexedStack(
            alignment: Alignment.center,
            index: widget.animationController.value < 0.5 ? 0 : 1,
            children: <Widget>[
              front,
              back,
            ],
          ),
        );
      },
    );
  }

  Matrix4 _buildTransform(AxisDirection direction) {
    final matrix = Matrix4.identity()..setEntry(3, 2, 0.001);
    switch (direction) {
      case AxisDirection.left:
      case AxisDirection.right:
        matrix.rotateY(_animation.value);
        break;
      case AxisDirection.up:
      case AxisDirection.down:
        matrix.rotateX(_animation.value);
        break;
    }
    return matrix;
  }
}
