import 'package:intl/intl.dart';

//step 1: generate arb files
//flutter pub run intl_translation:extract_to_arb --output-dir=lib/src/i18n lib/src/i18n/messages.dart --locale=en
//step 2: copy (or update changes) from intl_messages.arb to each intl_messages_*.arb file manually
//step 3: generate dart files for each locale from arb
//flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/src/i18n  --no-use-deferred-loading lib/src/i18n/messages.dart lib/src/i18n/intl_messages.arb lib/src/i18n/intl_messages_hr.arb

class Messages {
  String get appName => Intl.message(
        'SignalMeter',
        name: 'appName',
      );
  String get devices => Intl.message(
        'Devices',
        name: 'devices',
      );
  String get bouquets => Intl.message(
        'Bouquets',
        name: 'bouquets',
      );
  String get services => Intl.message(
        'Services',
        name: 'services',
      );
  String get signal => Intl.message(
        'Signal',
        name: 'signal',
      );
  String get actionScreenshot => Intl.message(
        'Screenshot',
        name: 'actionScreenshot',
      );
  String get actionStream => Intl.message(
        'Stream',
        name: 'actionStream',
      );
  String errFailedConnect(String profileName) => Intl.message(
        "Failed to connect to $profileName.",
        args: [profileName],
        name: 'errFailedConnect',
      );
  String get errCheckYourConnection => Intl.message(
        'Check your connection.',
        name: 'errCheckYourConnection',
      );
  String get errCheckYourSettings => Intl.message(
        'Check your settings.',
        name: 'errCheckYourSettings',
      );
  String get errCheckYourCredentials => Intl.message(
        'Check your credentials.',
        name: 'errCheckYourCredentials',
      );
  String get errOperationTimedOut => Intl.message(
        'Operation timed out.',
        name: 'errOperationTimedOut',
      );
  String errCommandFailed(String command) => Intl.message(
        'Command $command failed.',
        args: [command],
        name: 'errCommandFailed',
      );
  String errRequestFailedWithStatusCode(code) => Intl.message(
        'HTTP Status code $code.',
        args: [code],
        name: 'errRequestFailedWithStatusCode',
      );
  String infConnectingTo(String profileName) => Intl.message(
        'Connecting to $profileName',
        args: [profileName],
        name: 'infConnectingTo',
      );
  String infConnectedTo(String profileName) => Intl.message(
        'Connected to $profileName',
        args: [profileName],
        name: 'infConnectedTo',
      );
  String get infDisconnected => Intl.message(
        'Disconnected',
        name: 'infDisconnected',
      );
  String get infInitializingStream => Intl.message(
        'Initializing stream',
        name: 'infInitializingStream',
      );
  String get requestTime => Intl.message(
        'Request time',
        name: 'requestTime',
      );
  String get dvbtService => Intl.message(
        'DVB-T service',
        name: 'dvbtService',
      );
  String get dvbcService => Intl.message(
        'DVB-C service',
        name: 'dvbcService',
      );
  String get streamService => Intl.message(
        'Stream service',
        name: 'streamService',
      );
  String get dvbsService => Intl.message(
        'DVB-S service',
        name: 'dvbsService',
      );
  String get errPortNotAvailable => Intl.message(
        'Port is not available!',
        name: 'errPortNotAvailable',
      );
  String get errFailedToInitializeStream => Intl.message(
        'Failed to initialize stream!',
        name: 'errFailedToInitializeStream',
      );
  String get actionAddProfile => Intl.message(
        'Add device',
        name: 'actionAddProfile',
      );
  String get actionEditProfile => Intl.message(
        'Edit device',
        name: 'actionEditProfile',
      );
  String get actionDeleteProfile => Intl.message(
        'Delete device',
        name: 'actionDeleteProfile',
      );
  String get actionConnect => Intl.message(
        'Connect',
        name: 'actionConnect',
      );
  String get actionSave => Intl.message(
        'Save',
        name: 'actionSave',
      );
  String get actionTakeScreenshot => Intl.message(
        'Take screenshot',
        name: 'actionTakeScreenshot',
      );
  String get actionSleep => Intl.message(
        'Send to sleep',
        name: 'actionSleep',
      );
  String get actionRestart => Intl.message(
        'Restart GUI',
        name: 'actionRestart',
      );
  String get titleQuestion => Intl.message(
        'Question',
        name: 'titleQuestion',
      );
  String questionDeleteProfile(String profileName) => Intl.message(
        'Are you sure you want to delete $profileName?',
        args: [profileName],
        name: 'questionDeleteProfile',
      );
  String questionRestartGui(String profileName) => Intl.message(
        'Restart user interface on $profileName?',
        args: [profileName],
        name: 'questionRestartGui',
      );
  String get actionScreenshotAll => Intl.message(
        'Everything',
        name: 'actionScreenshotAll',
      );
  String get actionScreenshotOsd => Intl.message(
        'OSD only',
        name: 'actionScreenshotOsd',
      );
  String get actionScreenshotPicture => Intl.message(
        'Picture only',
        name: 'actionScreenshotPicture',
      );
  String infSavedFilename(String fileName) => Intl.message(
        'Saved $fileName',
        args: [fileName],
        name: 'infSavedFilename',
      );
  String get errSaveFailed => Intl.message(
        'Saved failed',
        name: 'errSaveFailed',
      );
  String get startMonitor => Intl.message(
        'Start monitor',
        name: 'startMonitor',
      );
  String get stopMonitor => Intl.message(
        'Stop monitor',
        name: 'stopMonitor',
      );
  String get profileName => Intl.message(
        'Name',
        name: 'profileName',
      );
  String get profileNameHint => Intl.message(
        'i.e. MyBox',
        name: 'profileNameHint',
      );
  String get profileAddress => Intl.message(
        'Address',
        name: 'profileAddress',
      );
  String get profileAddressHint => Intl.message(
        'i.e. 192.168.1.2',
        name: 'profileAddressHint',
      );
  String get profileUsername => Intl.message(
        'Username',
        name: 'profileUsername',
      );
  String get profileUsernameHint => Intl.message(
        'i.e. root',
        name: 'profileUsernameHint',
      );
  String get profilePassword => Intl.message(
        'Password',
        name: 'profilePassword',
      );
  String get profilePasswordHint => Intl.message(
        '',
        name: 'profilePasswordHint',
      );
  String get profilePort => Intl.message(
        'Port',
        name: 'profilePort',
      );
  String get profilePortHint => Intl.message(
        'usually 80',
        name: 'profilePortHint',
      );
  String get profileStreamingEnable => Intl.message(
        'Enable streaming',
        name: 'profileStreamingEnable',
      );
  String get profileStreamingPort => Intl.message(
        'Streaming Port',
        name: 'profileStreamingPort',
      );
  String get profileStreamingPorthint => Intl.message(
        'usually 8001',
        name: 'profileStreamingPorthint',
      );
  String get profileTranscodingEnable => Intl.message(
        'Enable transcoding',
        name: 'profileTranscodingEnable',
      );
  String get profileTranscodingPort => Intl.message(
        'Transcoding Port',
        name: 'profileTranscodingPort',
      );
  String get profileTranscodingPortHint => Intl.message(
        'usually 8002',
        name: 'profileTranscodingPortHint',
      );
  String get profileEnigmaVersion => Intl.message(
        'Version',
        name: 'profileEnigmaVersion',
      );
  String get profileUseSsl => Intl.message(
        'Use SSL',
        name: 'profileUseSsl',
      );
  String warnUsingAlternativePort(String port) => Intl.message(
        'Using alternative port $port',
        args: [port],
        name: 'warnUsingAlternativePort',
      );
  String get profileTranscodingLocalLan => Intl.message(
        'Transcoding on local network',
        name: 'profileTranscodingLocalLan',
      );
  String get checkingParameters => Intl.message(
        'Checking parameters',
        name: 'checkingParameters',
      );
  String get questionSaveChanges => Intl.message(
        'Save changes?',
        name: 'questionSaveChanges',
      );
  String get errInvalidProfileName => Intl.message(
        'Invalid device name',
        name: 'errInvalidProfileName',
      );
  String get errInvalidAddress => Intl.message(
        'Invalid address',
        name: 'errInvalidAddress',
      );
  String get errInvalidUsername => Intl.message(
        'Invalid username',
        name: 'errInvalidUsername',
      );
  String get errInvalidHttpPort => Intl.message(
        'Invalid http port',
        name: 'errInvalidHttpPort',
      );
  String get errInvalidEnigmaType => Intl.message(
        'Invalid enigma type',
        name: 'errInvalidEnigmaType',
      );
  String get errInvalidStreamingPort => Intl.message(
        'Invalid streaming port',
        name: 'errInvalidStreamingPort',
      );
  String get errInvalidTranscodingPort => Intl.message(
        'Invalid transcoding port',
        name: 'errInvalidTranscodingPort',
      );
  String get errFailedToInitializeTtsEngine => Intl.message(
        'TextToSpeech engine failed to initialize!',
        name: 'errFailedToInitializeTtsEngine',
      );
  String get questionOpenTtsSettings => Intl.message(
        'Open TextToSpeech settings now?',
        name: 'questionOpenTtsSettings',
      );
  String get errNoTtsLanguageAvailable => Intl.message(
        'TextToSpeech language is not available.',
        name: 'errNoTtsLanguageAvailable',
      );
  String get infSignalLevelsWillNotBeSpoken => Intl.message(
        'Signal levels will not be spoken.',
        name: 'infSignalLevelsWillNotBeSpoken',
      );
  String get questionIgnoreFurtherTtsError => Intl.message(
        'Ignore further TextToSpeech errors?',
        name: 'questionIgnoreFurtherTtsError',
      );
  String get titleError => Intl.message(
        'Error',
        name: 'titleError',
      );
  String get titleWarning => Intl.message(
        'Warning',
        name: 'titleWarning',
      );
  String get titleDownloading => Intl.message(
        'Downloading',
        name: 'titleDownloading',
      );
  String get questionTryTtsLanguageDownload => Intl.message(
        'Try to download and install languages?',
        name: 'questionTryTtsLanguageDownload',
      );
  String get pleaseWait => Intl.message(
        'Please wait',
        name: 'pleaseWait',
      );
  String get errDownloadFailed => Intl.message(
        'Download failed',
        name: 'errDownloadFailed',
      );
  String get errInstallFailed => Intl.message(
        'Install failed',
        name: 'errInstallFailed',
      );
  String get version => Intl.message(
        'Version',
        name: 'version',
      );
  String get releaseName => Intl.message(
        'Release name',
        name: 'releaseName',
      );
  String get build => Intl.message(
        'Build',
        name: 'build',
      );
  String get manufacturer => Intl.message(
        'Manufacturer',
        name: 'manufacturer',
      );
  String get informationsSupport => Intl.message(
        'Informations & Support',
        name: 'informationsSupport',
      );
  String get aboutRightsReserved => Intl.message(
        'All rights reserved',
        name: 'aboutRightsReserved',
      );
  String get specialThanksGoesTo => Intl.message(
        'Special thanks for support goes to',
        name: 'specialThanksGoesTo',
      );
  String get thanksForTestingTo => Intl.message(
        'Thanks for testing to',
        name: 'thanksForTestingTo',
      );
  String get errInvalidEnigmaTypeOrNotEnigma => Intl.message(
        'Invalid Enigma type or not Enigma Web interface.',
        name: 'errInvalidEnigmaTypeOrNotEnigma',
      );
  String errServerError(String profileName) => Intl.message(
        'Web interface returned error 500. Something has crashed on recevier. Try to open \n\n$profileName\n\n in your web browser to find out more.',
        args: [profileName],
        name: 'errServerError',
      );
  String warnHttpPortClosed(String address, String port) => Intl.message(
        '$address:$port seems to be unreachable.',
        args: [address, port],
        name: 'warnHttpPortClosed',
      );
  String get warnTranscodingPortClosed => Intl.message(
        'Transcoding port seems to be closed.',
        name: 'warnTranscodingPortClosed',
      );
  String get warnStreamingPortClosed => Intl.message(
        'Streaming port seems to be closed.',
        name: 'warnStreamingPortClosed',
      );
  String get warnSaveTheProfileAnyway => Intl.message(
        'Save the device anyway?',
        name: 'warnSaveTheProfileAnyway',
      );
  String get voice => Intl.message(
        'Voice',
        name: 'voice',
      );
  String get checkingPorts => Intl.message(
        'Checking ports',
        name: 'checkingPorts',
      );
  String get contentNotAvailable => Intl.message(
        'Content is currently unavailable',
        name: 'contentNotAvailable',
      );
  String get failedToParseResponse => Intl.message(
        'Invalid response.',
        name: 'failedToParseResponse',
      );
  String get tryAgain => Intl.message(
        'Try again',
        name: 'tryAgain',
      );
  String get oops => Intl.message(
        'Oops',
        name: 'oops',
      );
  String get actionDisconnect => Intl.message(
        'Disconnect',
        name: 'actionDisconnect',
      );
  String get actionEdit => Intl.message(
        'Edit',
        name: 'actionEdit',
      );
  String get actionDelete => Intl.message(
        'Delete',
        name: 'actionDelete',
      );
  String get noInformation => Intl.message(
        'No information',
        name: 'noInformation',
      );
  String get actionAbout => Intl.message(
        'About',
        name: 'actionAbout',
      );
  String get close => Intl.message(
        "Close",
        name: 'close',
      );
  String get open => Intl.message(
        "Open",
        name: 'open',
      );
  String get details => Intl.message(
        "Details",
        name: 'details',
      );
  String platformNotSupported(String platform) => Intl.message(
        '$platform platform is not supported',
        args: [platform],
        name: 'platformNotSupported',
      );
  String get unknownError => Intl.message(
        "Unknown error.",
        name: 'unknownError',
      );
  String get pleaseSubmitDetails => Intl.message(
        "Please submit details.",
        name: 'pleaseSubmitDetails',
      );
  String get confirm => Intl.message(
        "Confirm",
        name: 'confirm',
      );
  String get yes => Intl.message(
        "Yes",
        name: 'yes',
      );
  String get no => Intl.message(
        "No",
        name: 'no',
      );
  String get ok => Intl.message(
        "OK",
        name: 'ok',
      );
  String get cancel => Intl.message(
        "Cancel",
        name: 'cancel',
      );
  String get average => Intl.message(
        "Average",
        name: 'average',
      );
  String get enableTts => Intl.message(
        "Enable Tts",
        name: 'enableTts',
      );
  String get disableTts => Intl.message(
        "Disable Tts",
        name: 'disableTts',
      );
  String get defaultLook => Intl.message(
        "Default look",
        name: 'defaultLook',
      );
  String get alternativeLook => Intl.message(
        "Alternative look",
        name: 'alternativeLook',
      );
  String get searchByName => Intl.message(
        "Search by name",
        name: 'searchByName',
      );
  String get streamRequiresVlc => Intl.message(
        "Stream requires VLC player",
        name: 'streamRequiresVlc',
      );
  String get formNotValid => Intl.message(
        "Form is not valid",
        name: 'formNotValid',
      );
  String get more => Intl.message(
        "More",
        name: 'more',
      );
  String get profileStreamingPorthintEnigma1 => Intl.message(
        'usually 31339',
        name: 'profileStreamingPorthintEnigma1',
      );
  String get considerCoffee => Intl.message(
        "Consider buying me a coffee.",
        name: 'considerCoffee',
      );
  String get likeTheApp => Intl.message(
        "Like the app?",
        name: 'likeTheApp',
      );
  String get questionEmptyUsernamePassword => Intl.message(
        "Leave username and password empty? This requires you to turn OFF authorization on Web interface.",
        name: 'questionEmptyUsernamePassword',
      );
  String get settings => Intl.message(
        "Settings",
        name: 'settings',
      );
  String get options => Intl.message(
        "Options",
        name: 'options',
      );
  String get useDbAsPrimaryLevel => Intl.message(
        "Use dB as primary level",
        name: 'useDbAsPrimaryLevel',
      );
}
