// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static m0(command) => "Commando ${command} failed.";

  static m1(profileName) => "Kon niet verbinden met ${profileName}.";

  static m2(code) => "HTTP Status code ${code}.";

  static m3(profileName) => "Webinterface heeft fout 500 aangegeven. Er is iets vastgelopen op de ontvanger. Probeer \n\n${profileName}\n\n te openen in uw webbrowser om nader te onderzoeken.";

  static m4(profileName) => "Verbonden met ${profileName}";

  static m5(profileName) => "Verbindt met ${profileName}";

  static m6(fileName) => "Opgeslagen ${fileName}";

  static m7(platform) => "${platform} platform is niet ondersteund";

  static m8(profileName) => "Weet u zeker dat u ${profileName} wilt verwijderen?";

  static m9(profileName) => "Herstart de gebruikersinterface op ${profileName}?";

  static m10(address, port) => "${address}:${port} lijkt onbereikbaar.";

  static m11(port) => "Gebruik een afwijkende poort ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Alle rechten voorbehouden"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("Over"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Voeg een apparaat toe"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Verbinden"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Verwijder"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Verwijder het apparaat"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Verbreek"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Aanpassen"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Pas het apparaat aan"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Herstart de GUI"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Opslaan"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Screenshot"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Alles"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Enkel de OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Enkel het beeld"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Sluit af"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Maak een screenshot"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Voer verbindingsinstellingen in om te starten"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Voeg een apparaat toe"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Alternatief uiterlijk"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Gemiddeld"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Build"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annuleren"),
    "channel" : MessageLookupByLibrary.simpleMessage("Kanaal"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Zender (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Controleer de parameters"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Controleer de poorten"),
    "close" : MessageLookupByLibrary.simpleMessage("Sluiten"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Bevestig"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("U zou een mij een kop koffie kunnen aanbieden."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("De inhoud is momenteel onbereikbaar"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Standaard uiterlijk"),
    "details" : MessageLookupByLibrary.simpleMessage("Details"),
    "devices" : MessageLookupByLibrary.simpleMessage("Apparaten"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Déactiveer Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("DVB-C service"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("DVB-S service"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("DVB-T service"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Activeer Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Controleer uw verbinding."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Controleer uw toegang."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Controleer uw instellingen."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("De download mislukte"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Starten van de stream is mislukt!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("De texttospeech applicatie start niet!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Installatie mislukte"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Onjuist adres"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Onjuist enigma type"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Incorrect Enigma type of geen Enigma Web interface."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Onjuiste http poort"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Onjuiste apparaatnaam"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Onjuiste streaming poort"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Onjuiste transcoding poort"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Onjuiste gebruikersnaam"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("TextToSpeech taal is niet beschikbaar."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Actie gestopt. Time out."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Poort is niet beschikbaar!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Opslaan mislukt"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Onjuiste reactie."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("De vorm is onjuist"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Ontkoppeld"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Start de stream"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Signaalwaardes worden niet uitgesproken."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informatie & Support"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Left / Right pijlen"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Wat vindt je van de app?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Fabrikant"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Zender +/- knoppen"),
    "more" : MessageLookupByLibrary.simpleMessage("Meer"),
    "no" : MessageLookupByLibrary.simpleMessage("Nee"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Geen informatie"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "oops" : MessageLookupByLibrary.simpleMessage("Oops"),
    "open" : MessageLookupByLibrary.simpleMessage("Open"),
    "options" : MessageLookupByLibrary.simpleMessage("Opties"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Geef de details door."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Een ogenblik aub"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Adres"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("i.e. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Versie"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Naam"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("i.e. MijnBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Wachtwoord"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Poort"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("meestal 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Activeer streaming"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Streaming Poort"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("meestal 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("meestal 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Activeer transcoding"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcoding via het locale netwerk"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Transcoding Poort"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("meestal 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Gebruik SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("i.e. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Vul geen gebruikersnaam of wachtwoord in? Dit vereist dat u de autorisatie op de webinterface uitschakelt."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Negeer alle verdere TextToSpeech fouten?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Open nu de TextToSpeech instellingen ?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Sla de wijzigingen op?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Moet ik proberen om talen te downloaden?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Release naam"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Verzoek de tijd "),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Het screenshot is met succes in de gally opgeslagen"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Zoek op naam"),
    "services" : MessageLookupByLibrary.simpleMessage("Zenders"),
    "settings" : MessageLookupByLibrary.simpleMessage("Instellingen"),
    "share" : MessageLookupByLibrary.simpleMessage("Deel"),
    "signal" : MessageLookupByLibrary.simpleMessage("Signaal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Speciale dank voor de ondersteuning naar"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Start de monitor"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Stop de monitor"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Stream vereist VLC player"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Stream service"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Bedankt voor het testen"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Downloading"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Fout"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Vraag"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Waarschuwing"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Probeer het nogmaals"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Onbekende fout."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Up / Down pijlen"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Gebruik dB als eerste nivo"),
    "version" : MessageLookupByLibrary.simpleMessage("Versie"),
    "voice" : MessageLookupByLibrary.simpleMessage("Stem"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Moet het apparaat toch opgeslagen worden?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Streaming poort lijkt gesloten."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Transcoding poort lijkt gesloten."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Ja")
  };
}
