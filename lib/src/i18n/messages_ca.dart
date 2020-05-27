// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static m0(command) => "Error de Commanda ${command}.";

  static m1(profileName) => "Error en connectar a ${profileName}.";

  static m2(code) => "Còdig d\'estat HTTP ${code}.";

  static m3(profileName) => "El Web interface dóna error 500. Alguna cosa falla al receptor. Intenta obrir \n\n${profileName}\n\n en el teu navegador per intentar veure alguna cosa més.";

  static m4(profileName) => "Connectat a ${profileName}";

  static m5(profileName) => "Connectant a ${profileName}";

  static m6(fileName) => "Guardat: ${fileName}";

  static m7(platform) => "${platform} plataforma no soportada";

  static m8(profileName) => "Estàs seguro que vols esborrar ${profileName}?";

  static m9(profileName) => "Reiniciar interfaç d\'usuari a ${profileName}?";

  static m10(address, port) => "${address}:${port} no sembla funcionar.";

  static m11(port) => "Utilitzar port alternatiu ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Tots els drets reservats"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("En quant a"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Afegir dispositiu"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Connectar"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Esborrar"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Esborrar dispositiu"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Desconnectar"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Editar"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Editar dispositiu"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Reiniciar Enigma (GUI)"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Guardar"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Captura de Pantalla"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Tot"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Només OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Només Imagen"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Posar en StandBy"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Capturar Pantalla"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Entra els ajustos de connexió per a començar"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Afegir dispositiu"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Vista alternativa"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Mitja"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Compilació"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel·lar"),
    "channel" : MessageLookupByLibrary.simpleMessage("Canal"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Canal (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Comprovant paràmetres"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Comprovant ports"),
    "close" : MessageLookupByLibrary.simpleMessage("Tancar"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirmar"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Convída\'m a un cafè."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("El contingut no està disponible"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Vista per defecte"),
    "details" : MessageLookupByLibrary.simpleMessage("Detalls"),
    "devices" : MessageLookupByLibrary.simpleMessage("Dispositius"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Desactivar TaV"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("Servei DVB-C"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("Servei DVB-S"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("Servei DVB-T"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Activar TaV"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Comprova la connexió."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Comprova les credencials."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Comprova els ajustos."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Error al descarregar"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Error en iniciar el Stream!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Error a l\'iniciar el Texte a Veu"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Error a l\'instal·lar"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Direcció invàlida"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Tipus d\'Enigma invàlid"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Tipus invàlid d\'Enigma, o no hi ha Web interface."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Port http invàlid"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Nom de dispositiu invàlid"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Port de Stream invàlid"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Port de Transcodificació invàlid"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Nom d\'Usuari invàlid"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("Idioma de Texte a Veu no disponible."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Operació fora de temps."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Port no disponible!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Error al guardar"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Resposta invàlida"),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Formulari no vàlid"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Desconnectat"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Iniciant stream"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Els nivells de senyal no se diran per veu."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informacions i Suport"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Fletxes Esquerra / Dreta"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("¿T\'agrada l\'app?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Fabricant"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Funció Botons Canal +/-"),
    "more" : MessageLookupByLibrary.simpleMessage("Més"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("No hi ha informació"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Ufffff"),
    "open" : MessageLookupByLibrary.simpleMessage("Obrir"),
    "options" : MessageLookupByLibrary.simpleMessage("Opcions"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Si us plau, envia detalls."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Si us plau espera"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Direcció"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("p.ex. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Versió"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Nom Perfil"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("p.ex. El_Meu_Receptor"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Contrasenya"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Port"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("normalment 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Activar streaming"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Port de Streaming"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("normalment 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("normalment 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Activar transcodificació"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcodificar en xarxa local"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Port de Transcodificació"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("normalment 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Utilitzar SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Nom d\'Usuari"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("p.ex. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Sense nom d\'usuari i contrasenya? Això requereix que desactivis l\'autenticació al Web Interface."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Ignorar futurs errors de Texte a Veu?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Obrir ajustos de Texte a Veu?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Guardar canvia?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Intentar descarregar i Instal·lar idiomes?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Nom llançament"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Temps requerit"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Captura de Pantalla guardada a la galeria correctament"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Buscar per nom"),
    "services" : MessageLookupByLibrary.simpleMessage("Serveis"),
    "settings" : MessageLookupByLibrary.simpleMessage("Ajustos"),
    "share" : MessageLookupByLibrary.simpleMessage("Compartir"),
    "signal" : MessageLookupByLibrary.simpleMessage("Senyal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Agraïment especial de suport a"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Activar monitorització"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Detener monitorització"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Per a fer stream es necessita el reproductor VLC"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Servei de Stream"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Agraïment per les proves a"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Descarregant"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Error"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Pregunta"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Avis"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Intentar una altra vegada"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Error desconegut."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Fletxes Amunt / Avall"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Utilitzar dB como nivell primari"),
    "version" : MessageLookupByLibrary.simpleMessage("Versión"),
    "voice" : MessageLookupByLibrary.simpleMessage("Voz"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Guardar aquest perfil igualment?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("El port de Streaming sembla tancat."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("El port de Transcodificació sembla tancat."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Si")
  };
}
