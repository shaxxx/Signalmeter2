// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static m0(command) => "Fallo de Commando ${command}.";

  static m1(profileName) => "Fallo al conectar a ${profileName}.";

  static m2(code) => "Código de estado HTTP ${code}.";

  static m3(profileName) => "El Web interface devuelve error 500. Algo ha fallado en el receptor. Intenta abrir \n\n${profileName}\n\n en tu navegador para ver algo más.";

  static m4(profileName) => "Conectado a ${profileName}";

  static m5(profileName) => "Conectando a ${profileName}";

  static m6(fileName) => "Guardado: ${fileName}";

  static m7(platform) => "${platform} plataforma no soportada";

  static m8(profileName) => "¿Estás seguro que quieres borrar ${profileName}?";

  static m9(profileName) => "Reiniciar interfaz de usuario en ${profileName}?";

  static m10(address, port) => "${address}:${port} parece inalcanzable.";

  static m11(port) => "Usar puerto alternativo ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Todos los derechos reservados"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("Acerca de"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Añadir dispositivo"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Conectar"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Borrar"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Borrar dispositivo"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Desconectar"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Editar"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Editar dispositivo"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Reiniciar Enigma (GUI)"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Guardar"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Captura de Pantalla"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Todo"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Sólo OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Sólo Imagen"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Poner en StandBy"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Stream"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Capturar Pantalla"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Entra los ajustes de conexión para empezar"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Añadir dispositivo"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Vista alternativa"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Media"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Compilación"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancelar"),
    "channel" : MessageLookupByLibrary.simpleMessage("Canal"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Canal (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Comprobando parámetros"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Comprobando puertos"),
    "close" : MessageLookupByLibrary.simpleMessage("Cerrar"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirmar"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Invítame a un café."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("El contenido no está disponible"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Vista por defecto"),
    "details" : MessageLookupByLibrary.simpleMessage("Detalles"),
    "devices" : MessageLookupByLibrary.simpleMessage("Dispositivos"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Disable TaV"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("Servicio DVB-C"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("Servicio DVB-S"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("Servicio DVB-T"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Activar TaV"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Comprueba tu conexión."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Comprueba tus credenciales."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Comprueba tus ajustes."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Fallo al descargar"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("¡Fallo al iniciar el stream!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Fallo al iniciar el Texto a Voz"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Fallo al instalar"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Dirección inválida"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Tipo de Enigma inválido"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Tipo inválido de Enigma, o no hay Web interface."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Puerto http inválido"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Nombre de dispositivo inválido"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Puerto de Stream inválido"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Puerto de Transcodificación inválido"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Nombre de Usuario inválido"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("Idioma de Texto a Voz no disponible."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Operación fuera de tiempo."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("¡Puerto no disponible!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Fallo al guardar"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Respuesta inválida"),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Formulario no válido"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Desconectado"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Iniciando stream"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Los niveles de señal no se darán por voz."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informaciones y Soporte"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Flechas Izquierda / Derecha"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("¿Te gusta la app?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Fabricante"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Función Botones Canal +/-"),
    "message" : MessageLookupByLibrary.simpleMessage("Mensaje"),
    "more" : MessageLookupByLibrary.simpleMessage("Más"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("No hay información"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Ufffff"),
    "open" : MessageLookupByLibrary.simpleMessage("Abrir"),
    "options" : MessageLookupByLibrary.simpleMessage("Opciones"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Por favor, envía detalles."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Por favor espera"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Dirección"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("p.ej. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Versión"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Nombre Perfil"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("p.ej. Mi_Receptor"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Contraseña"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Puerto"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("normalmente 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Activar streaming"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Puerto de Streaming"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("normalmente 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("normalmente 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Activar transcodificación"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcodificar en red local"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Puerto de Transcodificación"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("normalmente 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Usar SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Nombre de Usuario"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("p.ej. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("¿Sin nombre de usuario y contraseña? Esto requiere que desactives la autenticación en el Web Interface."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("¿Ignorar futuros errores de Texto a Voz?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("¿Abrir ajustes de Texto a Voz?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("¿Guardar cambios?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("¿Intentar descargar e Instalar idiomas?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Nombre lanzamiento"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Tempo requerido"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Captura de Pantalla guardada en galería correctamente"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Buscar por nombre"),
    "services" : MessageLookupByLibrary.simpleMessage("Servicios"),
    "settings" : MessageLookupByLibrary.simpleMessage("Ajustes"),
    "share" : MessageLookupByLibrary.simpleMessage("Compartir"),
    "signal" : MessageLookupByLibrary.simpleMessage("Señal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Agradecimiento especial de soporte a"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Activar monitorización"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Detener monitorización"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Para stream se requiere Reproductor VLC"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Servicio de Stream"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Agradecimiento por las pruebas a"),
    "time" : MessageLookupByLibrary.simpleMessage("Tiempo"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Descargando"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Error"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Pregunta"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Aviso"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Intentar otra vez"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Error desconocido."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Flechas Arriba / Abajo"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Usar dB como nivel primario"),
    "version" : MessageLookupByLibrary.simpleMessage("Versión"),
    "voice" : MessageLookupByLibrary.simpleMessage("Voz"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("¿Guardar este perfil igualmente?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("El puerto de Streaming parece cerrado."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("El puerto de Transcodificación parece cerrado."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Si")
  };
}
