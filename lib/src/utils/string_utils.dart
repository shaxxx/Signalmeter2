class StringUtils {
  /// Remove illegal XML characters from a string.
  static String sanitizeXmlString(String xml) {
    if (xml == null) {
      throw ArgumentError.notNull('xml');
    }

    var buffer = StringBuffer();
    for (var c in xml.split('')) {
      if (isLegalXmlChar(c.codeUnitAt(0))) {
        buffer.writeCharCode(c.codeUnitAt(0));
      }
    }
    return buffer.toString();
  }

  /// Whether a given character is allowed by XML 1.0.
  static bool isLegalXmlChar(int asciiCode) {
    // == '\t' == 9
    // == '\n' == 10
    // == '\r' == 13
    return (asciiCode == 9 ||
        asciiCode == 10 ||
        asciiCode == 13 ||
        (asciiCode >= 32 && asciiCode <= 55295) ||
        (asciiCode >= 57344 && asciiCode <= 65533) ||
        (asciiCode >= 65536 && asciiCode <= 1114111));
  }

  static bool stringIsNullOrEmpty(String text) {
    if (text?.isEmpty ?? true) return true;
    return false;
  }

  static String trimAll(String text) {
    if (text == null) {
      return text;
    }
    if (text.isEmpty) {
      return text;
    }
    var result = text.trim();
    if (result.isEmpty) {
      return result;
    }
    if (result.startsWith('\n')) {
      return trimAll(result.substring(1));
    }
    if (result.startsWith('\t')) {
      return trimAll(result.substring(1));
    }
    if (result.endsWith('\n')) {
      return trimAll(result.substring(0, result.length - 1));
    }
    if (result.endsWith('\t')) {
      return trimAll(result.substring(0, result.length - 1));
    }
    return result;
  }

  static String trimStart(String text, int charCode) {
    if (text == null) return text;
    if (charCode == null) return text;
    var char = String.fromCharCode(charCode);
    while (text.startsWith(char)) {
      text = text.substring(1);
    }
    return text;
  }

  static String trimEnd(String text, int charCode) {
    if (text == null) return text;
    if (charCode == null) return text;
    var char = String.fromCharCode(charCode);
    while (text.endsWith(char)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }
}
