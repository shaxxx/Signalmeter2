class ApplicationSettings {
  ApplicationSettings() {
    this.ttsErrorCount = 0;
    this.ignoreTtsError = false;
    this.streamActivated = false;
  }

  DateTime lastAskedForTtsSettings;

  bool streamActivated;

  bool ignoreTtsError;

  int ttsErrorCount;
}
