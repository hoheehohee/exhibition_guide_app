import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:exhibition_guide_app/model/qna_list_model.dart';
import 'package:flutter/foundation.dart';

class MyPageProvider with ChangeNotifier {
  bool _loading = false;
  QnaListModel _qnaList = QnaListModel.fromJson({"data": []});

  bool get loading => _loading;
  QnaListModel get qnaList => _qnaList;

  Future<void> setQnaListSel() async {
    _loading = true;
    Response resp;
    Dio dio = new Dio();

    try{
      resp = await dio.get(BASE_URL + '/qnaListData.do', queryParameters: { "loginID": TEST_LOGIN_TOKEN });
      final jsonData = json.decode("$resp");
      _qnaList = QnaListModel.fromJson(jsonData);
      _loading = false;
      notifyListeners();
    }catch(error) {
      print('##### setQnaListSell Error: $error');
    }
  }
}