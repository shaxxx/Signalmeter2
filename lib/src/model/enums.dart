enum MonitorStatus { stopped, running }

enum ConnectionStatusEnum {
  disconnected,
  connecting,
  connected,
  error,
  disconnecting
}

enum LoadingStatus {
  idle,
  loading,
  error,
  success,
}

enum TabPagesEnum {
  //Profiles,
  Bouquets,
  Services,
  Signal,
  More,
}

enum ServiceType {
  DVBS,
  DVBT,
  DVBC,
  Stream,
  Unknown,
}

enum TtsStatus {
  Speaking,
  Idle,
  Error,
}

enum TtsInitializationStatus {
  Uninitalized,
  Initalized,
  Error,
  ShouldInitialize,
}

enum SignalViewEnum {
  Linear,
  CircularSnr,
  CircularDb,
  CircularAcg,
  CircularBer,
}

enum ChannelUpDownButtonsEnum {
  ChannelUpDown,
  LeftRightArrows,
  UpDownArrows,
}
