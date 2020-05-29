// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static m0(command) => "Comando ${command} non riuscito.";

  static m1(profileName) => "Impossibile connettersi a ${profileName}.";

  static m2(code) => "Codice di stato HTTP ${code}.";

  static m3(profileName) => "L\'interfaccia Web ha restituito l\'errore 500. Qualcosa si è schiantato su Ricevitore. Prova ad aprire \n\n ${profileName} \n\n nel tuo browser web per saperne di più.";

  static m4(profileName) => "Connesso a ${profileName}";

  static m5(profileName) => "Connessione a ${profileName}";

  static m6(fileName) => "Salvato ${fileName}";

  static m7(platform) => "La piattaforma ${platform} non è supportata";

  static m8(profileName) => "Sei sicuro di voler eliminare ${profileName}?";

  static m9(profileName) => "Riavviare l\'interfaccia utente su ${profileName}?";

  static m10(address, port) => "${address}:${port} sembra essere irraggiungibile.";

  static m11(port) => "Utilizzo della porta alternativa ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Tutti i diritti riservati"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("Informazioni"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Aggiungi dispositivo"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Collega"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Elimina"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Elimina dispositivo"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Disconnetti"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Modifica"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Modifica dispositivo"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Riavvia la GUI"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Salva"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Immagine dello schermo"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Qualunque cosa"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Solo OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Solo immagine"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Manda a dormire"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Streaming"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Fai uno screenshot"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Inserisci le impostazioni di connessione per iniziare"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Aggiungi dispositivo"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Aspetto alternativo"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Media"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Mazzi"),
    "build" : MessageLookupByLibrary.simpleMessage("Costruisci"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annulla"),
    "channel" : MessageLookupByLibrary.simpleMessage("Canale"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Canale (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Verifica dei parametri"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Verifica delle porte"),
    "close" : MessageLookupByLibrary.simpleMessage("Chiudi"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Conferma"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Valuta di comprarmi un caffè."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Il contenuto non è al momento disponibile"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Aspetto predefinito"),
    "details" : MessageLookupByLibrary.simpleMessage("Dettagli"),
    "devices" : MessageLookupByLibrary.simpleMessage("dispositivi"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Disabilita Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("Servizio DVB-C"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("Servizio DVB-S"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("Servizio DVB-T"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Abilita Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Controlla la tua connessione."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Controlla le tue credenziali."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Controlla le tue impostazioni."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Scaricamento non riuscito"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Impossibile inizializzare lo streaming!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Impossibile inizializzare il motore di sintesi vocale!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Installazione non riuscita"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Indirizzo non valido"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Tipo di enigma non valido"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Tipo di Enigma non valido o interfaccia Web Enigma non valida."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Porta http non valida"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Nome dispositivo non valido"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Porta streaming non valida"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Porta di transcodifica non valida"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Nome utente non valido"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("La lingua di sintesi vocale non è disponibile."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Operazione scaduta."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("La porta non è disponibile!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Salvataggio non riuscito"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Risposta non valida."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Il modulo non è valido"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Disconnesso"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Inizializzazione del flusso"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("I livelli del segnale non verranno pronunciati."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informazioni e supporto"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Frecce a sinistra / destra"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Ti piace l\'app?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Produttore"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Pulsanti canale +/-"),
    "message" : MessageLookupByLibrary.simpleMessage("Messaggio"),
    "more" : MessageLookupByLibrary.simpleMessage("Altro"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Nessuna informazione"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Ooops"),
    "open" : MessageLookupByLibrary.simpleMessage("Apri"),
    "options" : MessageLookupByLibrary.simpleMessage("Opzioni"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Si prega di inviare i dettagli."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Attendere prego"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Indirizzo"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("cioè 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Versione"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Nome"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("cioè MyBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Parola d\'ordine"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Porta"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("di solito 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Abilita streaming"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Porta streaming"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("di solito 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("di solito 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Abilita transcodifica"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcodifica su rete locale"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Porta di transcodifica"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("di solito 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Usa SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Nome utente"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("cioè radice"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Lasciare il nome utente e la password vuoti? Ciò richiede la disattivazione dell\'autorizzazione sull\'interfaccia Web."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Ignorare ulteriori errori di sintesi vocale?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Apri ora le impostazioni di sintesi vocale?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Salvare le modifiche?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Provare a scaricare e installare le lingue?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Nome della liberatoria"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Richiedi il tempo"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Schermata salvata correttamente nella galleria"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Ricerca per nome"),
    "services" : MessageLookupByLibrary.simpleMessage("Servizi"),
    "settings" : MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "share" : MessageLookupByLibrary.simpleMessage("Condividi"),
    "signal" : MessageLookupByLibrary.simpleMessage("Segnale"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Un ringraziamento speciale per il supporto va a"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Avvia il monitor"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Ferma il monitor"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Lo streaming richiede un lettore VLC"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Servizio di streaming"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Grazie per il test a"),
    "time" : MessageLookupByLibrary.simpleMessage("Tempo"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Download"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Errore"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Domanda"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Avvertimento"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Riprova"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Errore sconosciuto."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Frecce in su / giù"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Usa dB come livello primario"),
    "version" : MessageLookupByLibrary.simpleMessage("Versione"),
    "voice" : MessageLookupByLibrary.simpleMessage("Voce"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Salvare il dispositivo comunque?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("La porta di streaming sembra essere chiusa."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("La porta di transcodifica sembra essere chiusa."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Sì")
  };
}
