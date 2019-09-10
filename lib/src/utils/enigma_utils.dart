import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:logging/logging.dart';

import 'string_utils.dart';

class EnigmaUtils {
  static int getSatellitePosition(IBouquetItemService service) {
    if (service == null ||
        service.reference == null ||
        service.reference.length == 0) return 0;
    String mNameSpc = getNamespaceFromReference(service);
    if (mNameSpc.length < 5) return 0;
    mNameSpc = mNameSpc.substring(0, mNameSpc.length - 4);
    try {
      int decValue = int.parse(mNameSpc, radix: 16);
      return decValue;
    } catch (exception) {
      Logger.root.shout(exception);
      return 0;
    }
  }

  static String getNamespaceFromReference(IBouquetItemService service) {
    if (service == null ||
        service.reference == null ||
        service.reference.length == 0) return '';
    try {
      var sData = StringUtils.trimAll(service.reference).split(':');
      String mNameSpc = '';
      if (sData.length >= 10)
        mNameSpc = StringUtils.trimStart(sData[6], '0'.codeUnitAt(0));
      else
        mNameSpc = StringUtils.trimStart(sData[1], '0'.codeUnitAt(0));
      return mNameSpc;
    } catch (ex) {
      Logger.root.shout('GetNamespaceFromReference failed with error $ex');
      return '';
    }
  }

  static ServiceType serviceInfo(IBouquetItemService service) {
    if (service == null ||
        service.reference == null ||
        service.reference.length == 0) {
      return ServiceType.Unknown;
    }
    List<String> sData = StringUtils.trimAll(service.reference).split(':');
    var nameSpc = getNamespaceFromReference(service);
    if (nameSpc.toLowerCase().startsWith("eeee"))
      return ServiceType.DVBT;
    else if (nameSpc.toLowerCase().startsWith("ffff"))
      return ServiceType.DVBC;
    else if (sData.length >= 10 &&
        (sData[0] == "4097" ||
            sData[10].contains("//") ||
            (sData.length == 12 && sData[11] != null)))
      return ServiceType.Stream;
    else {
      var satPosition = getSatellitePosition(service);
      if (satPosition > 0) {
        return ServiceType.DVBS;
      }
      return ServiceType.Stream;
    }
  }

  static String unixTimeStamp() {
    return (DateTime.now().millisecondsSinceEpoch).toString();
  }
}
