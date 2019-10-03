// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
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
  String get localeName => 'hr';

  static m0(command) => "Naredba ${command} neuspješna.";

  static m1(profileName) => "Povezivanje na ${profileName} nije uspjelo.";

  static m2(code) => "HTTP status ${code} .";

  static m3(profileName) => "Web sučelje vratilo je pogrešku 500. Nešto se srušilo na prijemniku. Neispravni znakovi u listi kanala?? Pokušajte otvoriti ${profileName} u svom web-pregledniku da biste saznali više.";

  static m4(profileName) => "Spojen na ${profileName}";

  static m5(profileName) => "Spajam se na ${profileName}";

  static m6(fileName) => "Spremljeno kao ${fileName}";

  static m7(platform) => "Platforma ${platform} nije podržana";

  static m8(profileName) => "Briši uređaj ${profileName}?";

  static m9(profileName) => "Ponovno pokreni sučelje na ${profileName}?";

  static m10(address, port) => "${address} : ${port} se čini trenutno nedostupnim.";

  static m11(port) => "Koristim alternativni port ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Sva prava zadržana"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("O programu"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Dodaj uređaj"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Spajanje"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Briši"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Izbriši uređaj"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Prekid"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Uredi"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Uredi uređaj"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Restartaj sučelje"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Spremi"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Snimka ekrana"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Snimi sve"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Snimi OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Slika bez OSD"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Stanje mirovanja"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Snimi zaslon"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Alternativni izgled"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Prosječno"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Kategorije"),
    "build" : MessageLookupByLibrary.simpleMessage("Build"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Odustani"),
    "channel" : MessageLookupByLibrary.simpleMessage("Kanal"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Provjeravam parametre"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Provjeravam portove"),
    "close" : MessageLookupByLibrary.simpleMessage("Zatvori"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Potvrdi"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Možete platiti kavu."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Sadržaj trenutno nije dostupan"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Zadani izgled"),
    "details" : MessageLookupByLibrary.simpleMessage("Detalji"),
    "devices" : MessageLookupByLibrary.simpleMessage("Uređaji"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Isključi čitanje"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("DVB-C usluga"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("DVB-S usluga"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("DVB-T usluga"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Čitaj signal"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Provjerite mrežnu vezu."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Provjerite pristupne podatke."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Provjerite postavke."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Preuzimanje neuspješno"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Inicijalizacija Stream-a neuspješna!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Neuspješna inicijalizacija pretvaranja teksta u govor!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Instalacija neuspješna"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Neispravna adresa"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Neispravan verzija enigme"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Pogrešna verzija Enigme ili nije Enigma web sučelje."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Neispravan http port"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Neispravno ime profila"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Neispravan stream port"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Neispravan port za transkodiranje"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Neispravno korisničko ime"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("Odabrani jezik pretvaranja nije dostupan."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Vrijeme spajanja isteklo."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Port nije otvoren!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Spremanje neuspješno."),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Neispravan odgovor."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Postoje neispravna polja"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Veza prekinuta"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Preuzimam stream"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Razina signala neće biti izgovarana."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informacije i podrška"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Sviđa Vam se aplikacija?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Proizvođač"),
    "more" : MessageLookupByLibrary.simpleMessage("Više"),
    "no" : MessageLookupByLibrary.simpleMessage("Ne"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Nema informacija"),
    "ok" : MessageLookupByLibrary.simpleMessage("U redu"),
    "oops" : MessageLookupByLibrary.simpleMessage("Oops"),
    "open" : MessageLookupByLibrary.simpleMessage("Otvori"),
    "options" : MessageLookupByLibrary.simpleMessage("Opcije"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Molimo javite detalje."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Molimo pričekajte"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Adresa"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("npr. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Verzija"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Naziv"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("npr. Prijemnik doma"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Lozinka"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Port"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Omogući stream"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Stream port"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("obično 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Omogući transkodiranje"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transkodiranje na lokalnoj mreži"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Transcoding Port"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Koristi SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Login"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("npr. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Želite ostaviti korisničko ime i lozinku praznima? Zahtjeva isključenu autorizaciju na Web poslužitelju prijemnika."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Ignoriraj daljnje greške pretvaranja teksta u govor?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Otvori postavke pretvaranja teksta u govor?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Spremi promjene?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Pokušaj preuzeti i instalirati jezike?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Ime izdanja"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Vrijeme zahtjeva"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Snimka ekrana spremljena u galeriju"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Pretraga po nazivu"),
    "services" : MessageLookupByLibrary.simpleMessage("Kanali"),
    "settings" : MessageLookupByLibrary.simpleMessage("Postavke"),
    "share" : MessageLookupByLibrary.simpleMessage("Share"),
    "signal" : MessageLookupByLibrary.simpleMessage("Signal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Posebna zahvala na podršci"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Pokreni"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Zaustavi"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Stream zahtjeva VLC player"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Stream usluga"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Zahvala na testiranju"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Preuzimam"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Greška"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Pitanje"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Upozorenje"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Pokušaj ponovno"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Nepoznata greška."),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Koristi dB kao primarnu mjeru"),
    "version" : MessageLookupByLibrary.simpleMessage("Verzija"),
    "voice" : MessageLookupByLibrary.simpleMessage("Glas"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Ipak nastavi sa spremanjem?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Streaming port se čini zatvorenim."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Port za transkodiranje se čini zatvorenim."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Da")
  };
}
