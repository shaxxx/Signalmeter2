import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class ActiveTabChangedEvent {
  final TabPagesEnum tabPage;
  const ActiveTabChangedEvent(this.tabPage);
}

@immutable
class TabPagesActiveChangedEvent {
  final bool active;
  const TabPagesActiveChangedEvent(this.active);
}

@immutable
class SignalChartFullScreenActiveChangedEvent {
  final bool active;
  const SignalChartFullScreenActiveChangedEvent(this.active);
}

@immutable
class ChangeSignalView {
  final SignalViewEnum view;
  const ChangeSignalView(this.view);
}
