import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


/**
 * ko: 한국, en: 영어, ja: 일본, cn: 중국
 *
 */
class LanguageProvider extends ChangeNotifier {
  String _language = 'ko';

  String get language => _language;

  LanguageProvider() {
    defaultLanguage();
  }

  Future<void> defaultLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language');
    notifyListeners();
  }

  void setLanguage(String value) async {
    _language = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _language);
    notifyListeners();
  }
}