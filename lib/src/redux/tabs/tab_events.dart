import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class ActiveTabChangedEvent {
  final TabPagesEnum tabPage;
  ActiveTabChangedEvent(this.tabPage);
}

@immutable
class TabPagesActiveChangedEvent {
  final bool active;
  TabPagesActiveChangedEvent(this.active);
}

@immutable
class SignalChartFullScreenActiveChangedEvent {
  final bool active;
  SignalChartFullScreenActiveChangedEvent(this.active);
}

@immutable
class ChangeSignalView {
  final SignalViewEnum view;
  ChangeSignalView(this.view);
}
