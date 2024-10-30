import 'dart:convert';

class Utils {
  static String? resultToSting(List<int> value) {
    // Filter to only include ASCII printable characters
    String? result;
    try {
      List<int> printableValues =
          value.where((c) => c >= 32 && c <= 126).toList();
      result = String.fromCharCodes(printableValues);
    } catch (e) {
      print(e);
      return result;
    }

    return result;
  }

  static List<int> convertStringToByte(String value) {
    return utf8.encode(value);
  }
}
