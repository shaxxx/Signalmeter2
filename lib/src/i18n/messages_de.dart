// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static m0(command) => "Befehl ${command} fehlgeschlagen.";

  static m1(profileName) => "Verbindung zu ${profileName} fehlgeschlagen.";

  static m2(code) => "HTTP-Statuscode ${code}.";

  static m3(profileName) => "Die Webschnittstelle hat den Fehler 500 zurückgegeben. Prozess auf dem Empfänger ausgefallen. Versuchen Sie, \n\n ${profileName} \n\n in Ihrem Webbrowser zu öffnen, um mehr zu erfahren.";

  static m4(profileName) => "Verbunden mit ${profileName}";

  static m5(profileName) => "Verbindung zu ${profileName} herstellen";

  static m6(fileName) => "${fileName} gespeichert";

  static m7(platform) => "Die Plattform ${platform} wird nicht unterstützt";

  static m8(profileName) => "Möchten Sie ${profileName} wirklich löschen?";

  static m9(profileName) => "Benutzeroberfläche für ${profileName} neu starten?";

  static m10(address, port) => "${address}:${port} scheint nicht erreichbar zu sein.";

  static m11(port) => "Alternativen Port ${port} verwenden";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Alle Rechte vorbehalten."),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("Über die App"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Gerät hinzufügen"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Verbinden"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Gerät löschen"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Trennen"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Gerät bearbeiten"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("GUI neu starten"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Speichern"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Screenshot"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Alles"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Nur OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Nur Bild"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Ruhemodus aktivieren"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Screenshot aufnehmen"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Verbindungseinstellungen eingeben, um zu starten"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Gerät hinzufügen"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Alternatives Design"),
    "appName" : MessageLookupByLibrary.simpleMessage("Signalmessgerät"),
    "average" : MessageLookupByLibrary.simpleMessage("Durchschnittlich"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Build"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "channel" : MessageLookupByLibrary.simpleMessage("Kanal"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Kanal (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Überprüfung der Parameter"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Überprüfung der Ports"),
    "close" : MessageLookupByLibrary.simpleMessage("Schließen"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Vielleicht spendieren Sie mir einen Kaffee."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Die Inhalte sind derzeit nicht verfügbar."),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Standarddesign"),
    "details" : MessageLookupByLibrary.simpleMessage("Details"),
    "devices" : MessageLookupByLibrary.simpleMessage("Geräte"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("TTS deaktivieren"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("DVB-C-Dienst"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("DVB-S-Dienst"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("DVB-T-Dienst"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("TTS aktivieren"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Überprüfen Sie Ihre Verbindung."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Überprüfen Sie Ihre Anmeldeinformationen."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Überprüfen Sie Ihre Einstellungen."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Herunterladen fehlgeschlagen"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Stream konnte nicht initialisiert werden!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Die TextToSpeech-Engine konnte nicht initialisiert werden!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Installation fehlgeschlagen"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Ungültige Adresse"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Ungültiger Enigma-Typ"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Ungültiger Enigma-Typ oder keine Enigma-Weboberfläche."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Ungültiger http-Port"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Ungültiger Gerätename"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Ungültiger Streaming-Port"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Ungültiger Transcodierungsport"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Ungültiger Benutzername"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("Die TextToSpeech-Sprache ist nicht verfügbar."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Zeitüberschreitung."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Der Port ist nicht verfügbar!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Gespeichert fehlgeschlagen"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Ungültige Antwort."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Ungültiges Formular"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Getrennt"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Initialisieren des Streams"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Signalpegel werden nicht gesprochen."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Info und Support"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Pfeile nach links/rechts"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Wie gefällt Ihnen die App?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Hersteller"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Kanal +/- Tasten"),
    "message" : MessageLookupByLibrary.simpleMessage("Nachricht"),
    "more" : MessageLookupByLibrary.simpleMessage("Mehr"),
    "no" : MessageLookupByLibrary.simpleMessage("Nein"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Keine Infos"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Hoppla"),
    "open" : MessageLookupByLibrary.simpleMessage("Öffnen"),
    "options" : MessageLookupByLibrary.simpleMessage("Optionen"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Bitte senden Sie die Details."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Bitte warten"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("d. h. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Version"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Name"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("d. h. MyBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Port"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("normalerweise 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Streaming aktivieren"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Streaming-Port"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("normalerweise 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("normalerweise 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Transcodierung aktivieren"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcodierung im lokalen Netzwerk"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Transcodierungsport"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("normalerweise 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("SSL verwenden"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Benutzername"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("d. h. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Benutzername und Passwort leer lassen? Deaktivieren Sie dazu die Autorisierung auf der Weboberfläche."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Weitere TextToSpeech-Fehler ignorieren?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("TextToSpeech-Einstellungen jetzt öffnen?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Änderungen speichern?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Versuchen Sie, Sprachen herunterzuladen und zu installieren?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Name des Release"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Zeit anfordern"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Der Screenshot wurde erfolgreich in der Galerie gespeichert."),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Nach Name suchen"),
    "services" : MessageLookupByLibrary.simpleMessage("Dienste"),
    "settings" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "share" : MessageLookupByLibrary.simpleMessage("Teilen"),
    "signal" : MessageLookupByLibrary.simpleMessage("Signal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Besonderer Dank für die Unterstützung geht an"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Monitor starten"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Monitor stoppen"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Für den Stream ist VLC Player erforderlich"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Streaming-Dienst"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Danke fürs Testen"),
    "time" : MessageLookupByLibrary.simpleMessage("Zeit"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Wird heruntergeladen"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Fehler"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Frage"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Warnung"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Unbekannter Fehler."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Aufwärts-/Abwärtspfeile"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("dB als Primärpegel verwenden"),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "voice" : MessageLookupByLibrary.simpleMessage("Sprache"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Gerät trotzdem speichern?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Der Streaming-Port scheint geschlossen zu sein."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Der Transcodierungsport scheint geschlossen zu sein."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Ja")
  };
}
