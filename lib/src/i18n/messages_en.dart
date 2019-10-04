// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(command) => "Command ${command} failed.";

  static m1(profileName) => "Failed to connect to ${profileName}.";

  static m2(code) => "HTTP Status code ${code}.";

  static m3(profileName) => "Web interface returned error 500. Something has crashed on recevier. Try to open \n\n${profileName}\n\n in your web browser to find out more.";

  static m4(profileName) => "Connected to ${profileName}";

  static m5(profileName) => "Connecting to ${profileName}";

  static m6(fileName) => "Saved ${fileName}";

  static m7(platform) => "${platform} platform is not supported";

  static m8(profileName) => "Are you sure you want to delete ${profileName}?";

  static m9(profileName) => "Restart user interface on ${profileName}?";

  static m10(address, port) => "${address}:${port} seems to be unreachable.";

  static m11(port) => "Using alternative port ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("All rights reserved"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("About"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Add device"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Connect"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Delete device"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Disconnect"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Edit device"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Restart GUI"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Save"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Screenshot"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Everything"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("OSD only"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Picture only"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Send to sleep"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Take screenshot"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Enter connection settings to start"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Add device"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Alternative look"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Average"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Build"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "channel" : MessageLookupByLibrary.simpleMessage("Channel"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Checking parameters"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Checking ports"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Consider buying me a coffee."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Content is currently unavailable"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Default look"),
    "details" : MessageLookupByLibrary.simpleMessage("Details"),
    "devices" : MessageLookupByLibrary.simpleMessage("Devices"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Disable Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("DVB-C service"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("DVB-S service"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("DVB-T service"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Enable Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Check your connection."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Check your credentials."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Check your settings."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Download failed"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Failed to initialize stream!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("TextToSpeech engine failed to initialize!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Install failed"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Invalid address"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Invalid enigma type"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Invalid Enigma type or not Enigma Web interface."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Invalid http port"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Invalid device name"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Invalid streaming port"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Invalid transcoding port"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Invalid username"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("TextToSpeech language is not available."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Operation timed out."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Port is not available!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Saved failed"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Invalid response."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Form is not valid"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Disconnected"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Initializing stream"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Signal levels will not be spoken."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informations & Support"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Like the app?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Manufacturer"),
    "more" : MessageLookupByLibrary.simpleMessage("More"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("No information"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Oops"),
    "open" : MessageLookupByLibrary.simpleMessage("Open"),
    "options" : MessageLookupByLibrary.simpleMessage("Options"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Please submit details."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Please wait"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Address"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("i.e. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Version"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Name"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("i.e. MyBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Port"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("usually 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Enable streaming"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Streaming Port"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("usually 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("usually 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Enable transcoding"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcoding on local network"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Transcoding Port"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("usually 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Use SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Username"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("i.e. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Leave username and password empty? This requires you to turn OFF authorization on Web interface."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Ignore further TextToSpeech errors?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Open TextToSpeech settings now?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Save changes?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Try to download and install languages?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Release name"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Request time"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Screenshot successfully saved to gallery"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Search by name"),
    "services" : MessageLookupByLibrary.simpleMessage("Services"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "share" : MessageLookupByLibrary.simpleMessage("Share"),
    "signal" : MessageLookupByLibrary.simpleMessage("Signal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Special thanks for support goes to"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Start monitor"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Stop monitor"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Stream requires VLC player"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Stream service"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Thanks for testing to"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Downloading"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Error"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Question"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Warning"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Try again"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Unknown error."),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Use dB as primary level"),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "voice" : MessageLookupByLibrary.simpleMessage("Voice"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Save the device anyway?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Streaming port seems to be closed."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Transcoding port seems to be closed."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
