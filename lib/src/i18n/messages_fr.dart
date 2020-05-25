// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static m0(command) => "La commande ${command} a échoué.";

  static m1(profileName) => "Echec de connexion vers ${profileName}.";

  static m2(code) => "Code de status HTTP ${code}.";

  static m3(profileName) => "L\'interface web a retourné un code 500. Quelque chose a planté sur votre récepteur. Essayez d\'ouvrir \n\n${profileName}\n\n dans votre browser internet.";

  static m4(profileName) => "Connecté à ${profileName}";

  static m5(profileName) => "Connexion vers ${profileName}";

  static m6(fileName) => "Sauvegardé ${fileName}";

  static m7(platform) => "La plateforme ${platform} n\'est pas supportée";

  static m8(profileName) => "Êtes-vous certain de vouloir effacer ${profileName}?";

  static m9(profileName) => "Redémarrer l\'IGU sur ${profileName}?";

  static m10(address, port) => "${address}:${port} semble être inaccessible.";

  static m11(port) => "En utilisant le port alternatif ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Tous droits réservés"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("A propos"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Ajouter un périphérique"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Connexion"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Effacer"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Effacer un périphérique"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Déconnecter"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Editer"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Editer un périphérique"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Redémarrer l\'IGU"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Sauvegarder"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Capture d\'écran"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Tout"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Seulement l\'OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Seulement l\'image"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Mettre en veille"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Flux"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Prendre une capture d\'écran"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Entrez les paramètres de connexion pour démarrer"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Ajouter un périphérique"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Apparence alternative"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Moyenne"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Bouquets"),
    "build" : MessageLookupByLibrary.simpleMessage("Compilation"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annuler"),
    "channel" : MessageLookupByLibrary.simpleMessage("Chaîne"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Chaîne (Bouquet) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Vérification des paramètres"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Vérification des ports"),
    "close" : MessageLookupByLibrary.simpleMessage("Fermer"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirmer"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Considérez de m\'offrir un café."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Le contenu n\'est actuellement plus disponible"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Apparence par défaut"),
    "details" : MessageLookupByLibrary.simpleMessage("Détails"),
    "devices" : MessageLookupByLibrary.simpleMessage("Equipements"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Désactiver Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("service DVB-C"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("service DVB-S"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("service DVB-T"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Activer Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Vérifiez votre connexion."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Vérifiez vos identifiants."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Vérifiez vos paramètres ."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Echec du téléchargement"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Impossible d\'initialiser le flux!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Le moteur TextToSpeech n\'a pas su s\'initialiser!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("L\'installation a échoué"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Adresse non valable"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Type enigma non valable"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Type Enigma non valable ou pas une interface Web Enigma."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Port http non valable"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Nom de périphérique non valable"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Port de flux non valable"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Port de transcodage non valable"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Login non valable"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("La langue n\'est pas disponible dans TextToSpeech."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Délai de fonctionnement dépassé."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Le port n\'est pas disponible!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Echec de la sauvegarde"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Réponse non valable."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("La forme n\'est pas valide"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Déconnecté"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Initialisation du flux"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Les niveaux du signal ne seront pas oralisés."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Informations & Support"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Flêches Gauche / Droite"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Vous aimez l\'application?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Fabricant"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Boutons chaînes +/-"),
    "more" : MessageLookupByLibrary.simpleMessage("Plus"),
    "no" : MessageLookupByLibrary.simpleMessage("Non"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Pas d\'information"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Oops"),
    "open" : MessageLookupByLibrary.simpleMessage("Ouvrir"),
    "options" : MessageLookupByLibrary.simpleMessage("Options"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Merci de soumettre les détails."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Merci de patienter"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Adresse"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("p.e. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Version"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Nom"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("p.e. MonRecepteur"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Port"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("habituellement 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Activer le flux"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Port du flux"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("habituellement 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("habituellement 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Activer le transcodage"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Transcodage sur le réseau local"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Port de transcodage"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("habituellement 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Utiliser SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Login"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("p.e. root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Laisser le login et le mot de passe vide? Cela nécessite de désactiver l\'authentification sur l\'interface Web."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Ignorer les prochaines erreurs de TextToSpeech?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Ouvrir les paramètres TextToSpeech maintenant?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Sauvegarder les changements?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Essayer de télécharger et installer les langues?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Nom de version"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Durée de la requête"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("La capture d\'écran a été sauvegardée avec succès dans la galerie"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Recherche par nom"),
    "services" : MessageLookupByLibrary.simpleMessage("Services"),
    "settings" : MessageLookupByLibrary.simpleMessage("Paramètres"),
    "share" : MessageLookupByLibrary.simpleMessage("Partager"),
    "signal" : MessageLookupByLibrary.simpleMessage("Signal"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Nos remerciements particuliers vont à"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Démarrer le moniteur"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Arrêter le moniteur"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Les flux nécessitent VLC player"),
    "streamService" : MessageLookupByLibrary.simpleMessage("service flux"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Merci aux testeurs"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Téléchargement"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Erreur"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Question"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Avertissement"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Essayer à nouveau"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Erreur inconnue."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Flêches Haut / Bas"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Utiliser dB comme niveau primaire"),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "voice" : MessageLookupByLibrary.simpleMessage("Voix"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Sauvegarder le périphérique malgré tout?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Le port de flux semble être fermé."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Le port de transcodage semble être fermé."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Oui")
  };
}
