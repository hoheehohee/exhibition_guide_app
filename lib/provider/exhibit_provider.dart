import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/booking/booking_result_view.dart';
import 'package:exhibition_guide_app/model/booking_modify_model.dart';
import 'package:exhibition_guide_app/model/booking_reg_model.dart';
import 'package:exhibition_guide_app/model/exhibit_content_data_model.dart';
import 'package:exhibition_guide_app/model/exhibit_list_model.dart';
import 'package:exhibition_guide_app/model/exhibit_theme_item_model.dart';
import 'package:exhibition_guide_app/model/exhibit_theme_model.dart' as ETM;
import 'package:get/get.dart' as Getx;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../message.dart';


class ExhibitProvider with ChangeNotifier {
  final Dio dio = new Dio();

  bool _isAudio = false;
  bool _loading = false;
  bool _isAutoExhibit = false;
  bool _isPermanentExhibition = false;
  bool _isConsent = false;

  var _language;
  var _exhibitItem = null;
  String _menuType = "";

  ExhibitContentsDataModel _exhibitHighlightDataOne = ExhibitContentsDataModel.fromJson({"data": []});
  ExhibitContentsDataModel _exhibitHighlightDataTwo = ExhibitContentsDataModel.fromJson({"data": []});
  ExhibitContentsDataModel _exhibitHighlightDataThree = ExhibitContentsDataModel.fromJson({"data": []});
  ExhibitContentsDataModel _exhibitContentDataOne = ExhibitContentsDataModel.fromJson({"data": []});
  ExhibitContentsDataModel _exhibitContentDataTwo = ExhibitContentsDataModel.fromJson({"data": []});
  ExhibitContentsDataModel _exhibitContentDataThree = ExhibitContentsDataModel.fromJson({"data": []});
  ETM.ExhibitThemeModel _exhibitThemeData = ETM.ExhibitThemeModel.fromJson({"data": []});
  ETM.ExhibitThemeModel _exhibitAllMenuData = ETM.ExhibitThemeModel.fromJson({"data": []});
  ETM.ExhibitThemeModel _exhibitAllMenuItems = ETM.ExhibitThemeModel.fromJson({"data": []});


  BookingRegModel _bookingRegData = BookingRegModel.fromJson({});
  BookingModifyModel _bookingModifyData = BookingModifyModel.fromJson({});

  List<ExhibitItem> _exhibitList = [];
  List<ExhibitThemeItemModel> _exhibitThemeItem = [];
  List _imgList = [
    'https://monthlyart.com/wp-content/uploads/2020/07/Kukje-Gallery-Wook-kyung-Choi-Untitled-c.-1960s-34-x-40-cm.jpg',
    'https://i.pinimg.com/originals/2c/14/9a/2c149a9c12290855b200229d311f2bb7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTouyEvqQGwUrD5GtMb5rDfnZz3UARwHHCATA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIY1We4FiCxJfLMb5ju015QPtNZS6kQlsZ7w&usqp=CAU',
  ];

  bool get loading => _loading;
  bool get isPermanentExhibition => _isPermanentExhibition;
  bool get isAutoExhibit => _isAutoExhibit;
  bool get isAudio => _isAudio;
  bool get isConsent => _isConsent;
  List get imageList => _imgList;
  List<ExhibitThemeItemModel> get exhibitThemeItem => _exhibitThemeItem;
  List<dynamic> _holiday = [];

  String get language => _language;
  String get menuType => _menuType;
  List<dynamic> get holiday => _holiday;
  ExhibitContentsDataModel get exhibitHighlightDataOne => _exhibitHighlightDataOne;
  ExhibitContentsDataModel get exhibitHighlightDataTwo => _exhibitHighlightDataTwo;
  ExhibitContentsDataModel get exhibitHighlightDataThree => _exhibitHighlightDataThree;
  ExhibitContentsDataModel get exhibitContentDataOne => _exhibitContentDataOne;
  ExhibitContentsDataModel get exhibitContentDataTwo => _exhibitContentDataTwo;
  ExhibitContentsDataModel get exhibitContentDataThree => _exhibitContentDataThree;
  ETM.ExhibitThemeModel get exhibitAllMenuData => _exhibitAllMenuData;
  ETM.ExhibitThemeModel get exhibitAllMenuItems => _exhibitAllMenuItems;

  BookingRegModel get bookingRegData => _bookingRegData;
  BookingModifyModel get bookingModifyData => _bookingModifyData;

  get exhibitList => _exhibitList;
  get exhibitItem => _exhibitItem;

  ExhibitProvider() {
    init();
  }

  String getTextByLanguage(int index, String key) {

    if (index > -1 && (_loading || _exhibitList.length == 0)) {
      return "";
    } else if (index == -1 && (_loading || _exhibitItem == null)) {
      return "";
    }

    final item = index > -1 ? _exhibitList[index] : _exhibitItem;
    var l = '';

    if (_language == 'en') l = "_eng";
    else if (_language == 'zh') l = "_chn";
    else if (_language == 'ja') l = "_jpn";

    return index > -1 ? item.toJson()[key + l] : _exhibitItem[key + l];
  }

  void setMenyType(String type) {
    _menuType = type;
  }

  void setIsPermanentExhibition() {
    _isPermanentExhibition = !_isPermanentExhibition;
    notifyListeners();
  }

  void setIsAutoExhibi() {
    _isAutoExhibit = !_isAutoExhibit;
    notifyListeners();
  }

  void setIsAudio() {
    _isAudio = !_isAudio;
    notifyListeners();
  }

  void setImageList() {
    // API 연동 구현
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language');
  }

  Future<void> setExhibitSel() async {
    _loading = true;
    init();
    Response resp;

    try {
      resp = await dio.get(BASE_URL + '/contentsData.do');
      final jsonData = json.decode('{"exhibitItem": $resp}');
      var map = Map<String, dynamic>.from(jsonData);
      var data = ExhibitListModel.fromJson(map);
      _exhibitList = data.exhibitItem;

      _loading = false;
      notifyListeners();
    } catch(error) {
      _loading = false;
      print('##### getExhibitSel: $error');
    }
  }

  Future<void> setExhibitDetSel(int idx) async {
    _loading = true;
    init();
    Response resp;

    try{
      resp = await dio.get(BASE_URL + '/contentsDataDetail.do', queryParameters: {"idx": idx});
      _exhibitItem = jsonDecode(resp.toString());
      _loading = false;
      notifyListeners();
    }catch(error) {
      _loading = false;
      print("##### setExhibitDetSel: $error");
    }
  }

  //전시유물, 전시물 목록 API조회
  Future<void> setExhibitContentDataSel(String type, String exhibitionType, { String search }) async {
    _loading = true;
    init();
    Response respOne;
    Response respTwo;
    Response respThree;

    print("###### search: ${{"contentsType": type, "exhibitionType": exhibitionType, "highlightYN": 'Y', "searchString": search}.toString()}");
    try {
      respOne = await dio.get(
        BASE_URL + '/contentsData.do',
        queryParameters: {"contentsType": type, "exhibitionType": exhibitionType, "highlightYN": 'Y', "searchString": search}
      );
      final jsonData = json.decode('{"data": $respOne}');
      _exhibitContentDataOne = ExhibitContentsDataModel.fromJson(jsonData);

      respTwo = await dio.get(
        BASE_URL + '/contentsData.do',
        queryParameters: {"contentsType": type.isEmpty ? 'B' : type, "exhibitionType": exhibitionType,  "searchString": search }
      );

      final jsonDataTwo = json.decode('{"data": $respTwo}');
      _exhibitContentDataTwo = ExhibitContentsDataModel.fromJson(jsonDataTwo);

      if (type.isEmpty) {
        respThree = await dio.get(
            BASE_URL + '/contentsData.do',
            queryParameters: {"contentsType": "A", "exhibitionType": exhibitionType }
        );
        final jsonThree = json.decode('{"data": $respThree}');
        _exhibitContentDataThree = ExhibitContentsDataModel.fromJson(jsonThree);
      }

      _loading = false;
      notifyListeners();
    } catch(error) {
      _loading = false;
      print("##### setExhibitContentDataSel: $error}");
    }
  }

  //전시유물, 전시물 목록 API조회
  Future<void> setExhibitContentDataTwoSel(String exhibitionCode) async {
    _loading = true;
    init();
    Response respOne;
    Response respTwo;
    Response respThree;

    try {
      respOne = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"highlightYN": 'Y', "exhibitionCode": exhibitionCode}
      );
      final jsonData = json.decode('{"data": $respOne}');
      _exhibitContentDataOne = ExhibitContentsDataModel.fromJson(jsonData);

      respTwo = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"contentsType": 'B', "exhibitionCode": exhibitionCode }
      );

      final jsonDataTwo = json.decode('{"data": $respTwo}');
      _exhibitContentDataTwo = ExhibitContentsDataModel.fromJson(jsonDataTwo);

      respThree = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"contentsType": "A", "exhibitionCode": exhibitionCode }
      );
      final jsonThree = json.decode('{"data": $respThree}');
      _exhibitContentDataThree = ExhibitContentsDataModel.fromJson(jsonThree);


      _loading = false;
      notifyListeners();
    } catch(error) {
      _loading = false;
      print("##### setExhibitContentDataSel: $error}");
    }
  }

  //전시유물 테마 목록 API 조회
  Future<void> setExhibitThemeListSel(String type) async {
    _loading = true;
    init();
    Response resp;

    try {
      resp = await dio.get(BASE_URL + '/exhibitionData.do', queryParameters: {"location": type});
      final jsonData = json.decode('{"data": $resp}');
      _exhibitThemeData = ETM.ExhibitThemeModel.fromJson(jsonData);

      _exhibitThemeItem = List.generate(_exhibitThemeData.data.length, (index) {
        ETM.Data _data = _exhibitThemeData.data[index];

        return ExhibitThemeItemModel(
          title: _data.exhibitionName,
          titleEng: _data.exhibitionNameEng,
          titleChn: _data.exhibitionNameChn,
          titleJpn: _data.exhibitionNameJpn,
          subTitle: _data.subName,
          subTitleEng: _data.subNameEng,
          subTitleChn: _data.subNameChn,
          subTitleJpn: _data.subNameJpn,
          content: _data.content,
          contentChn: _data.contentChn,
          contentEng: _data.contentEng,
          contentJpn: _data.contentJpn,
          exhibitionCode: _data.exhibitionCode,
          imgPath: _data.listBackground,
          isOpen: false
        );

      });
      _loading = false;
      notifyListeners();
    } catch(error) {
      _loading = false;
      print("##### setExhibitContentDataSel: $error}");
    }
  }

  // 하이라이트 전시물 목록
  Future<void> setExhibitHighlightListSel ({ String search }) async {
    _loading = true;
    init();
    Response respOne;
    Response respTwo;
    Response respThree;

    try {
      respOne = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"contentsType": "B", "highlightYN": 'Y', "searchString": search}
      );
      final jsonData = json.decode('{"data": $respOne}');
      _exhibitHighlightDataOne = ExhibitContentsDataModel.fromJson(jsonData);

      respTwo = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"contentsType": "A", "highlightYN": 'Y', "exhibitionType": "A", "searchString": search}
      );
      final jsonDataTwo = json.decode('{"data": $respTwo}');
      _exhibitHighlightDataTwo = ExhibitContentsDataModel.fromJson(jsonDataTwo);

      respThree = await dio.get(
          BASE_URL + '/contentsData.do',
          queryParameters: {"contentsType": "A", "highlightYN": 'Y', "exhibitionType": "B", "searchString": search}
      );
      final jsonDataThree = json.decode('{"data": $respThree}');
      _exhibitHighlightDataThree = ExhibitContentsDataModel.fromJson(jsonDataThree);

      _loading = false;
      notifyListeners();
    } catch (error) {
      _loading = false;
      print("##### setExhibitHighlightListSel error: $error");
    }
  }

  // 이용예약신청 데이터 form
  void setBookingData(String key, value) {
    final temp = _bookingRegData.toJson();
    try{
      if (key == 'isConsent') {
        _isConsent = !_isConsent;
      } else {
        temp[key] = value;
        _bookingRegData = BookingRegModel.fromJson(temp);
      }

    }catch(error) {
      print("#### error: $error");
    }

    notifyListeners();
  }

  // 이용예약신청 데이터 form
  void setBookingModifyData(String key, value) {
    final temp = _bookingModifyData.toJson();
    try{
      if (key == 'isConsent') {
        _isConsent = !_isConsent;
      } else {
        temp[key] = value;
        _bookingModifyData = BookingModifyModel.fromJson(temp);
      }

    }catch(error) {
      print("#### error: $error");
    }

    notifyListeners();
  }

  // 이용예약신청 데이터 form 초기화
  void setBookingDataInitial() {
    _bookingRegData = BookingRegModel.fromJson({});
  }

  Future<void> setBookingRegCall() async {
    _loading = true;
    Response resp;

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _bookingRegData.loginID = prefs.getString('loginId');
      resp = await dio.get(
        BASE_URL + "/applyInsertData.do",
        queryParameters: _bookingRegData.toJson(),
      );

      final result = jsonDecode(resp.toString());

      _loading = false;

      if (result["state"] == 'Y') setBookingDetSelCall(result["applyID"]);
      _loading = false;

    }catch(error) {
      _loading = false;
      print("##### setBookingRegCall error: $error");
    }
  }

  Future<void> setBookingModifyCall() async {
    _loading = true;
    Response resp;

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _bookingRegData.loginID = prefs.getString('loginId');
      resp = await dio.get(
        BASE_URL + "/applyUpdateData.do",
        queryParameters: _bookingRegData.toModifyJson(),
      );

      final result = jsonDecode(resp.toString());

      _loading = false;

      if (result["state"] == 'Y') setBookingDetSelCall(_bookingRegData.applyID);
      _loading = false;

    }catch(error) {
      _loading = false;
      print("##### setBookingRegCall error: $error");
    }
  }

  Future<void> setBookingDetSelCall(int applyID) async {
    Response resp;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginID = prefs.getString('loginId');

    try{
      resp = await dio.get(
        BASE_URL + "/applyDetailData.do",
        queryParameters: {"applyID": applyID, "loginID": loginID},
      );
      final result = json.decode(resp.toString());
      _bookingRegData = BookingRegModel.fromJson(result);

      Getx.Get.offAll(BookingResultView());

    } catch(error) {
      print("##### setBookingDetSelCall error: $error");
    }
  }

  Future<void> setBookingDetSelCallByModify(int applyID) async {
    Response resp;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginID = prefs.getString('loginId');
    _loading = true;
    try{
      resp = await dio.get(
        BASE_URL + "/applyDetailData.do",
        queryParameters: {"applyID": applyID, "loginID": loginID},
      );
      final result = json.decode(resp.toString());
      _bookingRegData = BookingRegModel.fromJson(result);
      _loading = false;
      notifyListeners();
    } catch(error) {
      _loading = false;
      print("##### setBookingDetSelCall error: $error");
    }
  }

  Future<void> setExhibitAllListSel() async {
    print("#### menuType: $_menuType");
    _loading = true;
    try{
      Response resp;
      Map<String, String> params = {};
      if (_menuType == "F4") params = {"location": "A", "exhibitionType": "A"};
      else if (_menuType == "F5") params = {"location": "B", "exhibitionType": "A"};
      else if (_menuType == "plan") params = {"exhibitionType": "A"};

      resp = await dio.get(
        BASE_URL + "/exhibitionData.do",
        queryParameters: params
      );

      final jsonData = json.decode('{"data": $resp}');
      _exhibitAllMenuData = ETM.ExhibitThemeModel.fromJson(jsonData);

      final code = _exhibitAllMenuData.data[0].exhibitionCode;
      if (code != null && code.isNotEmpty) {
        setExhibitAllMenuItemsSel(code);
      }
      _loading = false;

      notifyListeners();
    }catch(error) {
      _loading = false;
      print("##### setExhibitAllListSel error: $error");
    }
  }

  Future<void> setExhibitAllMenuItemsSel(String code) async {
    _loading = true;
    try{
      Response resp;
      resp = await dio.get(
          BASE_URL + "/exhibitionData.do",
          queryParameters: {"exhibitionCode": code}
      );;
      final jsonData = json.decode('{"data": $resp}');
      _exhibitAllMenuItems = ETM.ExhibitThemeModel.fromJson(jsonData);
      _loading = false;
      notifyListeners();
    }catch(error) {
      _loading = false;
      print("##### setExhibitAllMenuItemsSel error: $error");
    }
  }

  Future<void> setHolidaySel() async {

    try {
      String params = DateFormat('yyyyMM').format(DateTime.now());
      String nowDay = DateFormat('dd').format(DateTime.now());
      Response resp;
      Dio dio = new Dio();
      resp = await dio.get(
          BASE_URL + "/reservationOpenDateData.do",
          queryParameters: {"searchMonth": params}
      );
      final data = json.decode(resp.toString());
      _holiday = data;
      _holiday[0][params].insert(0, int.parse(nowDay));

      notifyListeners();
    }catch(error) {
      print("##### setHolidaySel error: $error");
    }
  }
}