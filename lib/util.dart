import 'package:exhibition_guide_app/model/booking_reg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 언어별 텍스트
String getTextByLanguage(item, String key, String language) {
  try {
    final _language = language;
    var l = "";

    if (_language == 'en') l = "_eng";
    else if (_language == 'zh') l = "_chn";
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

// value check
String getValue(String value, {String nullString}) {
  if (value == null || value.isEmpty || value == "") {
    return nullString != null ? nullString : "";
  }
  return value;
}

// 장애여부 구분
// 1:없음, 2:시각장애 , 3:청각장애 , 4:지체장애 , 5:기타
String obstacleStatus(String value) {
  if (value == '1' || value == null || value == '') return "없음";
  else if (value == '2') return "시각장애";
  else if (value == '3') return "청각장애";
  else if (value == '4') return "지체장애";
  else if (value == '5') return "기타";
}

// 신청 타압
// type1	신청대상 유아여부
// type2	신청대상 초등학생 저학년유무
// type3	신청대상 초등학생 고학년유무
// type4	신청대상 중학생유무
// type5	신청대상 고등학생유무
// type6	신청대상 성인유무
String applyType(BookingRegModel bd) {
  var result = "";

  bd.toJson().forEach((key, value) {
    if (key == "type1" &&  value == 'Y') result += "유아여부 / ";
    else if (key == "type2" &&  value == 'Y') result += "초등저학년 (1-3) / ";
    else if (key == "type3" &&  value == 'Y') result += "초등고학년 (4-6) / ";
    else if (key == "type4" &&  value == 'Y') result += "중학생 / ";
    else if (key == "type5" &&  value == 'Y') result += "고등학생 / ";
    else if (key == "type6" &&  value == 'Y') result += "성인 / ";
  });

  if (result.isNotEmpty) result = result.substring(1, result.length - 2);
  return result;
}

// 이용예역신청 value check
String bookingCheck(BookingRegModel bd) {
  var result = "";
  bd.toJson().forEach((key, value) {
    if (value == null || value == "") {
      switch(key) {
        case 'applyDate': result = "이용날짜를 입력하세요."; break;
        case 'applyTime': result = "이용시간을 입력하세요."; break;
        case 'name': result = "신청자명을 입력하세요."; break;
        case 'tel': result = "연락처를 입력하세요."; break;
        case 'langType': result = "외국인 구분을 선택하세요."; break;
        case 'obstacle': result = "장애여부를 선택하세요."; break;
        case '': result = " 입력하세요."; break;
        case '': result = " 입력하세요."; break;

      }
    }
  });

  return result;
}