// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static m0(command) => "命令${command}失败。";

  static m1(profileName) => "连接到${profileName}失败。";

  static m2(code) => "HTTP状态代码${code}。";

  static m3(profileName) => "网络接口返回错误500。接收器上发生崩溃。尝试在网络浏览器中打开\n\n${profileName}\n\n以了解更多。";

  static m4(profileName) => "已连接到${profileName}";

  static m5(profileName) => "正在连接到${profileName}";

  static m6(fileName) => "已保存${fileName}";

  static m7(platform) => "${platform}平台不支持";

  static m8(profileName) => "您确定要删除${profileName}吗？";

  static m9(profileName) => "在${profileName}上重新启动用户接口？";

  static m10(address, port) => "${address}:${port}似乎无法访问。";

  static m11(port) => "使用备用端口${port}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutRightsReserved" : MessageLookupByLibrary.simpleMessage("版权所有"),
    "actionAbout" : MessageLookupByLibrary.simpleMessage("关于"),
    "actionAddProfile" : MessageLookupByLibrary.simpleMessage("添加设备"),
    "actionConnect" : MessageLookupByLibrary.simpleMessage("连接"),
    "actionDelete" : MessageLookupByLibrary.simpleMessage("删除"),
    "actionDeleteProfile" : MessageLookupByLibrary.simpleMessage("删除设备"),
    "actionDisconnect" : MessageLookupByLibrary.simpleMessage("断开"),
    "actionEdit" : MessageLookupByLibrary.simpleMessage("编辑"),
    "actionEditProfile" : MessageLookupByLibrary.simpleMessage("编辑设备"),
    "actionRestart" : MessageLookupByLibrary.simpleMessage("重新启动GUI"),
    "actionSave" : MessageLookupByLibrary.simpleMessage("保存"),
    "actionScreenshot" : MessageLookupByLibrary.simpleMessage("屏幕截图"),
    "actionScreenshotAll" : MessageLookupByLibrary.simpleMessage("所有"),
    "actionScreenshotOsd" : MessageLookupByLibrary.simpleMessage("仅OSD"),
    "actionScreenshotPicture" : MessageLookupByLibrary.simpleMessage("仅图片"),
    "actionSleep" : MessageLookupByLibrary.simpleMessage("进入睡眠"),
    "actionStream" : MessageLookupByLibrary.simpleMessage("流"),
    "actionTakeScreenshot" : MessageLookupByLibrary.simpleMessage("截屏"),
    "addProfileShowcaseText" : MessageLookupByLibrary.simpleMessage("输入连接设置以开始"),
    "addProfileShowcaseTitle" : MessageLookupByLibrary.simpleMessage("添加设备"),
    "alternativeLook" : MessageLookupByLibrary.simpleMessage("备选外观"),
    "appName" : MessageLookupByLibrary.simpleMessage("信号仪"),
    "average" : MessageLookupByLibrary.simpleMessage("平均"),
    "bouquets" : MessageLookupByLibrary.simpleMessage("分组"),
    "build" : MessageLookupByLibrary.simpleMessage("建立"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "channel" : MessageLookupByLibrary.simpleMessage("频道"),
    "channelUpDown" : MessageLookupByLibrary.simpleMessage("频道（分组）+/-"),
    "checkingParameters" : MessageLookupByLibrary.simpleMessage("检查参数"),
    "checkingPorts" : MessageLookupByLibrary.simpleMessage("检查端口"),
    "close" : MessageLookupByLibrary.simpleMessage("关闭"),
    "confirm" : MessageLookupByLibrary.simpleMessage("确认"),
    "considerCoffee" : MessageLookupByLibrary.simpleMessage("考虑给我买杯咖啡。"),
    "contentNotAvailable" : MessageLookupByLibrary.simpleMessage("内容当前不可用"),
    "defaultLook" : MessageLookupByLibrary.simpleMessage("默认外观"),
    "details" : MessageLookupByLibrary.simpleMessage("详情"),
    "devices" : MessageLookupByLibrary.simpleMessage("设备"),
    "disableTts" : MessageLookupByLibrary.simpleMessage("禁用Tts"),
    "dvbcService" : MessageLookupByLibrary.simpleMessage("DVB-C服务"),
    "dvbsService" : MessageLookupByLibrary.simpleMessage("DVB-S服务"),
    "dvbtService" : MessageLookupByLibrary.simpleMessage("DVB-T服务"),
    "enableTts" : MessageLookupByLibrary.simpleMessage("启用Tts"),
    "errCheckYourConnection" : MessageLookupByLibrary.simpleMessage("检查您的连接。"),
    "errCheckYourCredentials" : MessageLookupByLibrary.simpleMessage("检查您的凭证。"),
    "errCheckYourSettings" : MessageLookupByLibrary.simpleMessage("检查您的设置。"),
    "errCommandFailed" : m0,
    "errDownloadFailed" : MessageLookupByLibrary.simpleMessage("下载失败"),
    "errFailedConnect" : m1,
    "errFailedToInitializeStream" : MessageLookupByLibrary.simpleMessage("初始化流失败！"),
    "errFailedToInitializeTtsEngine" : MessageLookupByLibrary.simpleMessage("TextToSpeech引擎初始化失败！"),
    "errInstallFailed" : MessageLookupByLibrary.simpleMessage("安装失败"),
    "errInvalidAddress" : MessageLookupByLibrary.simpleMessage("无效地址"),
    "errInvalidEnigmaType" : MessageLookupByLibrary.simpleMessage("无效Enigma类型"),
    "errInvalidEnigmaTypeOrNotEnigma" : MessageLookupByLibrary.simpleMessage("无效Enigma类型或非Enigma网络接口。"),
    "errInvalidHttpPort" : MessageLookupByLibrary.simpleMessage("无效http端口"),
    "errInvalidProfileName" : MessageLookupByLibrary.simpleMessage("无效设备名称"),
    "errInvalidStreamingPort" : MessageLookupByLibrary.simpleMessage("无效流端口"),
    "errInvalidTranscodingPort" : MessageLookupByLibrary.simpleMessage("无效转码端口"),
    "errInvalidUsername" : MessageLookupByLibrary.simpleMessage("无效用户名"),
    "errNoTtsLanguageAvailable" : MessageLookupByLibrary.simpleMessage("TextToSpeech语言不可用。"),
    "errOperationTimedOut" : MessageLookupByLibrary.simpleMessage("操作超时。"),
    "errPortNotAvailable" : MessageLookupByLibrary.simpleMessage("端口不可用！"),
    "errRequestFailedWithStatusCode" : m2,
    "errSaveFailed" : MessageLookupByLibrary.simpleMessage("保存失败"),
    "errServerError" : m3,
    "failedToParseResponse" : MessageLookupByLibrary.simpleMessage("无效回应。"),
    "formNotValid" : MessageLookupByLibrary.simpleMessage("形式无效"),
    "infConnectedTo" : m4,
    "infConnectingTo" : m5,
    "infDisconnected" : MessageLookupByLibrary.simpleMessage("断开"),
    "infInitializingStream" : MessageLookupByLibrary.simpleMessage("初始化流"),
    "infSavedFilename" : m6,
    "infSignalLevelsWillNotBeSpoken" : MessageLookupByLibrary.simpleMessage("信号电平不会读出。"),
    "informationsSupport" : MessageLookupByLibrary.simpleMessage("信息和支持"),
    "leftRigtArrows" : MessageLookupByLibrary.simpleMessage("左/右箭头"),
    "likeTheApp" : MessageLookupByLibrary.simpleMessage("喜欢这个App吗？"),
    "manufacturer" : MessageLookupByLibrary.simpleMessage("制造商"),
    "mapChannelUpDownTo" : MessageLookupByLibrary.simpleMessage("频道+/-按钮"),
    "message" : MessageLookupByLibrary.simpleMessage("信息"),
    "more" : MessageLookupByLibrary.simpleMessage("更多"),
    "no" : MessageLookupByLibrary.simpleMessage("没有"),
    "noInformation" : MessageLookupByLibrary.simpleMessage("没有信息"),
    "ok" : MessageLookupByLibrary.simpleMessage("确定"),
    "oops" : MessageLookupByLibrary.simpleMessage("哎呀"),
    "open" : MessageLookupByLibrary.simpleMessage("打开"),
    "options" : MessageLookupByLibrary.simpleMessage("选项"),
    "platformNotSupported" : m7,
    "pleaseSubmitDetails" : MessageLookupByLibrary.simpleMessage("请提交详细信息。"),
    "pleaseWait" : MessageLookupByLibrary.simpleMessage("请稍候"),
    "profileAddress" : MessageLookupByLibrary.simpleMessage("地址"),
    "profileAddressHint" : MessageLookupByLibrary.simpleMessage("即192.168.1.2"),
    "profileEnigmaVersion" : MessageLookupByLibrary.simpleMessage("版本"),
    "profileName" : MessageLookupByLibrary.simpleMessage("名称"),
    "profileNameHint" : MessageLookupByLibrary.simpleMessage("即MyBox"),
    "profilePassword" : MessageLookupByLibrary.simpleMessage("密码"),
    "profilePasswordHint" : MessageLookupByLibrary.simpleMessage(""),
    "profilePort" : MessageLookupByLibrary.simpleMessage("端口"),
    "profilePortHint" : MessageLookupByLibrary.simpleMessage("通常为80"),
    "profileStreamingEnable" : MessageLookupByLibrary.simpleMessage("启用流"),
    "profileStreamingPort" : MessageLookupByLibrary.simpleMessage("流端口"),
    "profileStreamingPorthint" : MessageLookupByLibrary.simpleMessage("通常为8001"),
    "profileStreamingPorthintEnigma1" : MessageLookupByLibrary.simpleMessage("通常为31339"),
    "profileTranscodingEnable" : MessageLookupByLibrary.simpleMessage("启用转码"),
    "profileTranscodingLocalLan" : MessageLookupByLibrary.simpleMessage("在本地网络上进行转码"),
    "profileTranscodingPort" : MessageLookupByLibrary.simpleMessage("转码端口"),
    "profileTranscodingPortHint" : MessageLookupByLibrary.simpleMessage("通常为8002"),
    "profileUseSsl" : MessageLookupByLibrary.simpleMessage("使用SSL"),
    "profileUsername" : MessageLookupByLibrary.simpleMessage("用户名"),
    "profileUsernameHint" : MessageLookupByLibrary.simpleMessage("即root"),
    "questionDeleteProfile" : m8,
    "questionEmptyUsernamePassword" : MessageLookupByLibrary.simpleMessage("将用户名和密码留空？这要求您在网络接口上关闭授权。"),
    "questionIgnoreFurtherTtsError" : MessageLookupByLibrary.simpleMessage("忽略其他TextToSpeech错误？"),
    "questionOpenTtsSettings" : MessageLookupByLibrary.simpleMessage("立即打开TextToSpeech设置？"),
    "questionRestartGui" : m9,
    "questionSaveChanges" : MessageLookupByLibrary.simpleMessage("保存更改？"),
    "questionTryTtsLanguageDownload" : MessageLookupByLibrary.simpleMessage("尝试下载并安装语言？"),
    "releaseName" : MessageLookupByLibrary.simpleMessage("发布名称"),
    "requestTime" : MessageLookupByLibrary.simpleMessage("请求时间"),
    "screenshotSaved" : MessageLookupByLibrary.simpleMessage("屏幕截图成功保存到图库"),
    "searchByName" : MessageLookupByLibrary.simpleMessage("按名称搜索"),
    "services" : MessageLookupByLibrary.simpleMessage("服务"),
    "settings" : MessageLookupByLibrary.simpleMessage("设置"),
    "share" : MessageLookupByLibrary.simpleMessage("分享"),
    "signal" : MessageLookupByLibrary.simpleMessage("信号"),
    "specialThanksGoesTo" : MessageLookupByLibrary.simpleMessage("特别感谢支持"),
    "startMonitor" : MessageLookupByLibrary.simpleMessage("启动监视器"),
    "stopMonitor" : MessageLookupByLibrary.simpleMessage("停止监视器"),
    "streamRequiresVlc" : MessageLookupByLibrary.simpleMessage("流需要VLC播放器"),
    "streamService" : MessageLookupByLibrary.simpleMessage("流服务"),
    "thanksForTestingTo" : MessageLookupByLibrary.simpleMessage("感谢测试"),
    "time" : MessageLookupByLibrary.simpleMessage("时间"),
    "titleDownloading" : MessageLookupByLibrary.simpleMessage("正在下载"),
    "titleError" : MessageLookupByLibrary.simpleMessage("错误"),
    "titleQuestion" : MessageLookupByLibrary.simpleMessage("问题"),
    "titleWarning" : MessageLookupByLibrary.simpleMessage("警告"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("重试"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("未知错误。"),
    "upDownArrows" : MessageLookupByLibrary.simpleMessage("上/下箭头"),
    "useDbAsPrimaryLevel" : MessageLookupByLibrary.simpleMessage("使用dB作为主要电平"),
    "version" : MessageLookupByLibrary.simpleMessage("版本"),
    "voice" : MessageLookupByLibrary.simpleMessage("语音"),
    "warnHttpPortClosed" : m10,
    "warnSaveTheProfileAnyway" : MessageLookupByLibrary.simpleMessage("仍然保存设备吗？"),
    "warnStreamingPortClosed" : MessageLookupByLibrary.simpleMessage("流端口似乎已关闭。"),
    "warnTranscodingPortClosed" : MessageLookupByLibrary.simpleMessage("转码端口似乎已关闭。"),
    "warnUsingAlternativePort" : m11,
    "yes" : MessageLookupByLibrary.simpleMessage("是")
  };
}
