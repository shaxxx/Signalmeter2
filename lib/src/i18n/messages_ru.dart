// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static m0(command) => "Команда ${command} не выполнена.";

  static m1(profileName) => "Не удалось подключиться к ${profileName}.";

  static m2(code) => "Код состояния HTTP {код}.";

  static m3(profileName) => "Веб-интерфейс вернул ошибку 500. В ресивере произошла ошибка. Попробуйте открыть \n\n ${profileName} \n\n в своем веб-браузере, чтобы узнать больше.";

  static m4(profileName) => "Подключено к ${profileName}";

  static m5(profileName) => "Подключение к ${profileName}";

  static m6(fileName) => "Сохранено ${fileName}";

  static m7(platform) => "Платформа ${platform} не поддерживается";

  static m8(profileName) => "Вы уверены, что хотите удалить ${profileName}?";

  static m9(profileName) => "Перезапустить пользовательский интерфейс в ${profileName}?";

  static m10(address, port) => "Похоже, ${address}:${port} недоступен.";

  static m11(port) => "Использование альтернативного порта ${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("Все права защищены"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("Инфо"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("Добавить устройство"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("Подключиться"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("Удалить устройство"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("Отключить"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("Редактировать"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("Изменить устройство"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("Перезапустить графический интерфейс"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("Сохранить"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("Скриншот"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("Все"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("Только OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("Только изображение"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("Перевести в спящий режим"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("Поток"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("Сделать скриншот"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("Чтобы начать, введите настройки подключения"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("Добавить устройство"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("Альтернативный вид"),
    "appName" : MessageLookupByLibrary.simpleMessage("SignalMeter"),
    "average" : MessageLookupByLibrary.simpleMessage("Средний"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("Пакеты"),
    "build" : MessageLookupByLibrary.simpleMessage("Сборка"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Отмена"),
    "channel" : MessageLookupByLibrary.simpleMessage("Канал"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("Канал (пакет) +/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("Проверка параметров"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("Проверка портов"),
    "close" : MessageLookupByLibrary.simpleMessage("Закрыть"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("Подумайте о том, чтобы купить мне кофе."),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("Контент в настоящее время недоступен"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("Вид по умолчанию"),
    "details" : MessageLookupByLibrary.simpleMessage("Подробно"),
    "devices" : MessageLookupByLibrary.simpleMessage("Устройства"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("Отключить Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("Служба DVB-C"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("Служба DVB-S"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("Служба DVB-T"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("Включить Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("Проверьте ваше подключение."),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("Проверьте свои учетные данные."),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("Проверьте ваши настройки."),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("Ошибка загрузки"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("Не удалось инициализировать поток!"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("Не удалось инициализировать модуль TextToSpeech!"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("Установка не выполнена"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("Недействительный адрес"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("Недействительный тип Enigma"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("Недействительный тип Enigma или веб-интерфейс, не связанный с Enigma."),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("Недействительный http-порт"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("Недействительное имя устройства"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("Недействительный порт потоковой передачи"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("Недействительный порт перекодировки"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("Недопустимое имя пользователя"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("Язык TextToSpeech недоступен."),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("Время операции истекло."),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("Порт недоступен!"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("Сохранено не выполнено"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("Недействительный ответ."),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("Форма не действительна"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("Отключено"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("Инициализация потока"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("Уровни сигналов не будут произноситься."),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("Информация и поддержка"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("Стрелки влево/вправо"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("Понравилось приложение?"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("Производитель"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("Канал +/- кнопки"),
    "message" : MessageLookupByLibrary.simpleMessage("Cообщение"),
    "more" : MessageLookupByLibrary.simpleMessage("Дополнительно"),
    "no" : MessageLookupByLibrary.simpleMessage("Нет"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("Нет данных"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "oops" : MessageLookupByLibrary.simpleMessage("Ой"),
    "open" : MessageLookupByLibrary.simpleMessage("Открыть"),
    "options" : MessageLookupByLibrary.simpleMessage("Параметры"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("Пожалуйста, отправьте подробные сведения."),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("Пожалуйста, подождите"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("Адрес"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("т. е. 192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("Версия"),
    "profileName" : MessageLookupByLibrary.simpleMessage("Имя"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("т.е. MyBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("Пароль"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("Порт"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("обычно 80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("Включить потоковую передачу"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("Потоковый порт"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("обычно 8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("обычно 31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("Включить перекодировку"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("Перекодировка в локальной сети"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("Порт перекодировки"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("обычно 8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("Использовать SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("т. е. корневая папка"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("Оставить имя пользователя и пароль пустыми? Для этого необходимо отключить авторизацию в веб-интерфейсе."),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("Игнорировать дальнейшие ошибки TextToSpeech?"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("Открыть настройки TextToSpeech сейчас?"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("Сохранить изменения?"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("Попробовать скачать и установить языки?"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("Имя выпуска"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("Время запроса"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("Скриншот успешно сохранен в галерее"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("Поиск по имени"),
    "services" : MessageLookupByLibrary.simpleMessage("Службы"),
    "settings" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "share" : MessageLookupByLibrary.simpleMessage("Поделиться"),
    "signal" : MessageLookupByLibrary.simpleMessage("Сигнал"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("Отдельное спасибо за поддержку"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("Запустить монитор"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("Остановить монитор"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("Для потока требуется проигрыватель VLC"),
    "streamService" : MessageLookupByLibrary.simpleMessage("Служба потока"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("Спасибо за тестирование"),
    "time" : MessageLookupByLibrary.simpleMessage("Время"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("Загрузка"),
    "titleError" : MessageLookupByLibrary.simpleMessage("Ошибка"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("Вопрос"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("Предупреждение"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Попробовать еще раз"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Неизвестная ошибка."),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("Стрелки вверх/вниз"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("Использовать дБ в качестве основного уровня"),
    "version" : MessageLookupByLibrary.simpleMessage("Версия"),
    "voice" : MessageLookupByLibrary.simpleMessage("Голос"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("Сохранить устройство в любом случае?"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("Похоже, порт потоковой передачи закрыт."),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("Похоже, порт перекодировки закрыт."),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("Да")
  };
}
