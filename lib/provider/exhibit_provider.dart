import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/model/exhibit_content_data_model.dart';
import 'package:exhibition_guide_app/model/exhibit_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../message.dart';


class ExhibitProvider with ChangeNotifier {

  bool _isAudio = false;
  bool _loading = false;
  bool _isAutoExhibit = false;
  bool _isPermanentExhibition = false;

  var _language;
  var _exhibitItem = null;

  ExhibitContentsDataModel _exhibitContentData = ExhibitContentsDataModel.fromJson({"data": []});

  List<ExhibitItem> _exhibitList = [];
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
  List get imageList => _imgList;
  ExhibitContentsDataModel get exhibitContentData => _exhibitContentData;

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
    else if (_language == 'cn') l = "_chn";
    else if (_language == 'ja') l = "_jpn";

    return index > -1 ? item.toJson()[key + l] : _exhibitItem[key + l];
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
    Dio dio = new Dio();

    try {
      resp = await dio.get(BASE_URL + '/contentsData.do');
      final jsonData = json.decode('{"exhibitItem": $resp}');
      var map = Map<String, dynamic>.from(jsonData);
      var data = ExhibitListModel.fromJson(map);
      _exhibitList = data.exhibitItem;

      _loading = false;
      notifyListeners();
    } catch(error) {
      print('##### getExhibitSel: $error');
    }
  }

  Future<void> setExhibitDetSel(int idx) async {
    _loading = true;
    init();
    Response resp;
    Dio dio = new Dio();

    try{
      resp = await dio.get(BASE_URL + '/contentsDataDetail.do', queryParameters: {"idx": idx});
      _exhibitItem = jsonDecode(resp.toString());
      _loading = false;
      notifyListeners();
    }catch(error) {
      print("##### setExhibitDetSel: $error");
    }
  }

  //전시유물, 전시물 목록 API조회
  Future<void> setExhibitContentDataSel(String type) async {
    _loading = true;
    init();
    Response resp;
    Dio dio = new Dio();

    try {
      resp = await dio.get(BASE_URL + '/contentsData.do', queryParameters: {"contentsType": type});
      final jsonData = json.decode('{"data": $resp}');
      _exhibitContentData = ExhibitContentsDataModel.fromJson(jsonData);
      _loading = false;
      notifyListeners();
    } catch(error) {
      print("##### setExhibitContentDataSel: $error}");
    }
  }
}