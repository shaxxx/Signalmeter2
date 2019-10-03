import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../message_provider.dart';
import 'signal_progressbar_viewmodel.dart';

class SignalProgressbarView extends StatelessWidget {
  final LinearGradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.2, 0.3, 0.5, 0.75],
    colors: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalProgressbarViewModel>(
      distinct: true,
      converter: (store) => SignalProgressbarViewModel.fromStore(
        store,
        MessageProvider.of(context),
      ),
      builder: (context, viewModel) {
        return Column(
          children: <Widget>[
            viewModel.dbIsPrimaryLevel
                ? dbProgress(viewModel)
                : snrProgress(viewModel),
            viewModel.dbIsPrimaryLevel
                ? snrProgress(viewModel)
                : dbProgress(viewModel),
            berProgress(viewModel),
            acgProgress(viewModel),
          ],
        );
      },
    );
  }

  Widget snrProgress(SignalProgressbarViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LinearPercentIndicator(
        animation: false,
        lineHeight: 30.0,
        animationDuration: 0,
        percent: viewModel.snrDouble(),
        center: Text(
          viewModel.snrString(),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
        linearGradient: gradient,
        clipLinearGradient: true,
      ),
    );
  }

  Widget dbProgress(SignalProgressbarViewModel viewModel) {
    if (!viewModel.hasdb) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LinearPercentIndicator(
        animation: false,
        lineHeight: 30.0,
        animationDuration: 0,
        percent: viewModel.dbDouble(),
        center: Text(
          viewModel.dbString(),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
        linearGradient: gradient,
        clipLinearGradient: true,
      ),
    );
  }

  Widget berProgress(SignalProgressbarViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LinearPercentIndicator(
        animation: false,
        lineHeight: 30.0,
        animationDuration: 0,
        percent: viewModel.berDouble(),
        center: Text(
          viewModel.berString(),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
        linearGradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [
              0.0,
              0.2,
            ],
            colors: [
              Colors.orange,
              Colors.red,
            ]),
        clipLinearGradient: true,
      ),
    );
  }

  Widget acgProgress(SignalProgressbarViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LinearPercentIndicator(
        animation: false,
        lineHeight: 30.0,
        animationDuration: 0,
        percent: viewModel.acgDouble(),
        center: Text(
          viewModel.acgString(),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
        linearGradient: gradient,
        clipLinearGradient: true,
      ),
    );
  }
}
