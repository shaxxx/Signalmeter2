import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gradient_circular_progress_indicator.dart';

class CircularProgressView extends StatelessWidget {
  final String stringValue;
  final double doubleValue;
  final String footerString;
  final Size screenSize;
  final List<Color> colors;
  final List<double> stops;

  const CircularProgressView({
    Key key,
    @required this.stringValue,
    @required this.doubleValue,
    @required this.footerString,
    @required this.screenSize,
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
    ],
    this.stops = const [0.2, 0.3, 0.5, 0.75],
  })  : assert(stringValue != null),
        assert(doubleValue != null),
        assert(footerString != null),
        assert(screenSize != null),
        assert(screenSize != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxSize = (screenSize.shortestSide / 4) * 3;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      maxSize = maxSize - 60;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      alignment: AlignmentDirectional.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxSize,
          maxWidth: maxSize,
        ),
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.clip,
          children: <Widget>[
            Container(
              child: Container(
                child: GradientCircularProgressIndicator(
                  colors: colors,
                  stops: stops,
                  strokeWidth: 25.0,
                  value: doubleValue,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: AutoSizeText(
                        stringValue,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 150.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: maxSize / 3.6,
                child: AutoSizeText(
                  footerString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
