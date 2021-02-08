import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:exhibition_guide_app/model/booking_list_model.dart';
import 'package:exhibition_guide_app/model/faq_list_model.dart';
import 'package:exhibition_guide_app/model/qna_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageProvider with ChangeNotifier {
  final picker = ImagePicker();
  final Dio dio = new Dio();

  bool _loading = false;
  File _image;
  QnaListModel _qnaList = QnaListModel.fromJson({"data": []});
  FaqListModel _faqList = FaqListModel.fromJson({"data": []});
  BookingListModel _bookingList = BookingListModel.fromJson({"data": []});
  var _qnaItem = null;

  bool get loading => _loading;
  String get imageName => _image != null ? '첨부파일 1' : '';
  QnaListModel get qnaList => _qnaList;
  FaqListModel get faqList => _faqList;
  BookingListModel get bookingList => _bookingList;
  get qnaItem => _qnaItem;

  // 1:1문의하기 목록 조회
  Future<void> setQnaListSel() async {
    _loading = true;
    Response resp;

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginId = prefs.getString('loginId');
      resp = await dio.get(BASE_URL + '/qnaListData.do', queryParameters: { "loginID": loginId });
      final jsonData = json.decode("$resp");
      _qnaList = QnaListModel.fromJson(jsonData);
      _loading = false;
      notifyListeners();
    }catch(error) {
      print('##### setQnaListSell Error: $error');
    }
  }

  // 사진앨범 이미지 가져오기
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    } else {
      print('##### No image selected.');
    }
  }

  //1:1 문의 저장
  Future<String> setQna(String text) async {
    Response resp;

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginId = prefs.getString('loginId');
      resp = await dio.get(BASE_URL + '/qnaUpdateData.do', queryParameters: { "loginID": loginId, "questions":text });
      var map = Map<String, dynamic>.from(json.decode(resp.toString()));
      return map["state"];
    }catch(error) {
      print('##### setQna Error: $error');
    }
  }

  //1:1 문의 상세
  Future<void> getQna(int qnaId) async {
    Response resp;

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginId = prefs.getString('loginId');
      resp = await dio.get(BASE_URL + '/qnaDetailData.do', queryParameters: { "loginID": loginId, "qnaID":qnaId });
      _qnaItem = json.decode(resp.toString());
      notifyListeners();
    }catch(error) {
      print('##### setQna Error: $error');
    }
  }

  String getValue(String key) {
    return _qnaItem['data'][key];
  }

  Future<void> getFaqListSel() async {
    _loading = true;
    Response resp;

    try{
      resp = await dio.get(BASE_URL + '/faqData.do');
      final jsonData = json.decode("$resp");
      _faqList = FaqListModel.fromJson(jsonData);
      _loading = false;
      print(_faqList);
      notifyListeners();
    }catch(error) {
      print('##### getFaqListSel Error: $error');
    }
  }

  Future<void> setBookingStatListSel(int status) async {
    _loading = true;
    Response resp;
    // N:신청, C:취소, AC:관리자취소, Y:승인, B:완료
    String statusGubun = "";
    switch(status) {
      case 1: { statusGubun = "N"; }
      break;
      case 2: { statusGubun = "Y"; }
      break;
      case 3: { statusGubun = "B"; }
      break;
      case 4: { statusGubun = "C"; }
      break;
    }

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginId = prefs.getString('loginId');
      resp = await dio.get(BASE_URL + '/applyListData.do', queryParameters: { "loginID": loginId, "PAGE_INDEX":1, "PAGE_ROW":100 });
      final jsonData = json.decode("$resp");
      _bookingList = BookingListModel.fromJson(jsonData);
      print(_bookingList);
      _loading = false;
      notifyListeners();
    }catch(error) {
      print('##### getFaqListSel Error: $error');
    }
  }

  Future<String> setApplyCancel(String applyID) async {
    Response resp;

    try{
      resp = await dio.get(BASE_URL + '/applyStateUpdateData.do?loginID=3se61vr220cidol826d5&applyID=${applyID}');
      var map = Map<String, dynamic>.from(json.decode(resp.toString()));
      return map['state'];
    }catch(error) {
      print('##### getFaqListSel Error: $error');
    }
  }
}


