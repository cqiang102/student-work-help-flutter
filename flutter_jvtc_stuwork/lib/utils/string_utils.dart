import 'dart:convert' as convert;
class StringUtils {
  static bool isNull(String str) {
    if (str == null) return true;
    if (str.trim() == "") return true;
    if (str.length == 0) return true;
    if (str.isEmpty) return true;
    return false;
  }

  static bool isNotNull(String str) {
    return !(isNull(str));
  }
  /*
  * Base64加密
  */
  static String base64Encode(String data){
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }
/*
  * Base64解密
  */
  static String base64Decode(String data){
    List<int> bytes = convert.base64Decode(data);
    String result = convert.utf8.decode(bytes);
    return result;
  }
}
