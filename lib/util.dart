import 'package:shared_preferences/shared_preferences.dart';

// 언어별 텍스트
String getTextByLanguage(item, String key, String language) {
  try {
    final _language = language;
    var l = "";

    if (_language == 'en') l = "_eng";
    else if (_language == 'cn') l = "_chn";
    else if (_language == 'ja') l = "_jpn";
    return item.toJson()[key + l];

  }catch(error) {
    return "";
  }
}

// 전시물 구분
String getContentType(String type) {
  var result = "";
  if (type == 'A') result = "패널";
  else if (type == 'B') result = "유물";

  return result;
}