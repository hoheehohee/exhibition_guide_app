import 'package:exhibition_guide_app/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier {
  bool _isNetwork = true;
  double _fontSize = 16;
  String _language = 'ko';
  Locale _locale;

  bool get isNetwork => _isNetwork;
  String get language => _language;
  double get fontSize => _fontSize;
  Locale get locale => _locale;

  SettingProvider() {
    defaultLanguage();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void setIsNetwork() {
    _isNetwork = !_isNetwork;
    notifyListeners();
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