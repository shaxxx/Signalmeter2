import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_chart_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import '../../message_provider.dart';

class SignalChartView extends StatefulWidget {
  @override
  _SignalChartViewState createState() => _SignalChartViewState();
}

class _SignalChartViewState extends State<SignalChartView> {
  var gradientColors = const [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalChartViewModel>(
      distinct: true,
      converter: (store) =>
          SignalChartViewModel.fromStore(store, MessageProvider.of(context)),
      builder: (context, viewModel) {
        var screenSize = MediaQuery.of(context).size;
        return Center(
          child: Container(
            padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 20),
            child: AspectRatio(
              aspectRatio:
                  (screenSize.longestSide + 50) / screenSize.shortestSide,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 10, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                            viewModel.requestTimeString() +
                                '  ' +
                                (screenSize.width >= 450
                                    ? viewModel.averageTimeString()
                                    : ''),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlChart(
                          chart: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawHorizontalGrid: false,
                                drawVerticalGrid: true,
                                verticalInterval: viewModel.useDb ? 2 : 10,
                                getDrawingVerticalGridLine: (value) {
                                  return const FlLine(
                                    color: Color(0xff67727d),
                                    strokeWidth: 1,
                                  );
                                },
                                getDrawingHorizontalGridLine: (value) {
                                  return const FlLine(
                                    color: Color(0xff67727d),
                                    strokeWidth: 0,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: false,
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  getTitles: (value) {
                                    return _getTitle(value, viewModel);
                                  },
                                  reservedSize: 30,
                                  margin: 12,
                                ),
                              ),
                              borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Color(0xff37434d), width: 1)),
                              minX: 0,
                              maxX: signalChartPoints.toDouble() - 1,
                              minY: 0,
                              maxY: viewModel.useDb ? 16 : 100,
                              lineBarsData: [
                                _getChartData(viewModel),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTitle(double value, SignalChartViewModel viewModel) {
    if (viewModel.useDb) {
      if (value == 1.0) {
        return '1 db';
      } else if (value == 8.0) {
        return '8 db';
      } else if (value == 16.0) {
        return '16 dB';
      }
      return '';
    }
    switch (value.toInt()) {
      case 10:
        return '10%';
      case 50:
        return '50%';
      case 100:
        return '100%';
    }
    return '';
  }

  LineChartBarData _getChartData(SignalChartViewModel viewModel) {
    var spots = List<FlSpot>();
    viewModel.chartPoints.forEach((x, y) {
      spots.add(FlSpot(x, y));
    });
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: gradientColors,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BelowBarData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    );
  }
}
