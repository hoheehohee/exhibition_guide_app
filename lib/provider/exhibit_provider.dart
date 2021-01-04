import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/model/exhibit_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _BASE_URL = 'http://115.144.53.222:8081/ilje/';

class ExhibitProvider extends ChangeNotifier {

  var _language;
  bool _loading = false;
  var _exhibitItem = null;
  List<ExhibitItem> _exhibitList = [];

  get loading => _loading;
  get exhibitList => _exhibitList;
  get exhibitItem => _exhibitItem;

  ExhibitProvider() {
    init();
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
      resp = await dio.get(_BASE_URL + '/contentsData.do');
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
      resp = await dio.get(_BASE_URL + '/contentsDataDetail.do', queryParameters: {"idx": idx});
      _exhibitItem = jsonDecode(resp.toString());
      _loading = false;
      notifyListeners();
    }catch(error) {
      print("##### setExhibitDetSel: $error");
    }
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
}