import 'dart:math';
import 'package:flutter/material.dart';

/// A circular progress indicator with gradient effect.
class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator({
    Key key,
    this.strokeWidth = 18.0,
    @required this.colors,
    this.stops,
    this.value,
    this.child,
  }) : super(key: key);

  final Widget child;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The value of this progress indicator with 0.0 corresponding
  /// to no progress having been made and 1.0 corresponding to all the progress
  /// having been made.
  final double value;

  /// The colors the gradient should obtain at each of the stops.
  ///
  /// If [stops] is non-null, this list must have the same length as [stops].
  ///
  /// This list must have at least two colors in it (otherwise, it's not a
  /// gradient!).
  final List<Color> colors;

  /// A list of values from 0.0 to 1.0 that denote fractions along the gradient.
  ///
  /// If non-null, this list must have the same length as [colors].
  ///
  /// If the first value is not 0.0, then a stop with position 0.0 and a color
  /// equal to the first color in [colors] is implied.
  ///
  /// If the last value is not 1.0, then a stop with position 1.0 and a color
  /// equal to the last color in [colors] is implied.
  ///
  /// The values in the [stops] list must be in ascending order. If a value in
  /// the [stops] list is less than an earlier value in the list, then its value
  /// is assumed to equal the previous value.
  ///
  /// If stops is null, then a set of uniformly distributed stops is implied,
  /// with the first stop at 0.0 and the last stop at 1.0.
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientArcPainter(
        progress: value,
        colors: colors,
        stops: stops,
        strokeWidth: strokeWidth,
      ),
      child: child,
    );
  }
}

class GradientArcPainter extends CustomPainter {
  const GradientArcPainter({
    @required this.progress,
    @required this.colors,
    @required this.stops,
    @required this.strokeWidth,
  })  : assert(progress != null),
        assert(strokeWidth != null),
        super();

  final double progress;
  final List<Color> colors;
  final List<double> stops;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: pi / 2,
      endAngle: 5 * (pi / 2),
      tileMode: TileMode.repeated,
      colors: colors,
      stops: stops,
    );

    final backgroundGradient = new SweepGradient(
      startAngle: pi / 2,
      endAngle: 5 * (pi / 2),
      tileMode: TileMode.repeated,
      colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
    );

    final backPaint = new Paint()
      ..shader = backgroundGradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (strokeWidth / 2);
    final startAngle = (pi / 2) + (pi / 16 * 3);
    final totalSweepAngle = ((2 * pi) - (2 * (pi / 16 * 3)));
    final sweepAngle = totalSweepAngle * progress;

    canvas.drawArc(
      new Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweepAngle,
      false,
      backPaint,
    );

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
