import 'package:flutter/foundation.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = 'ko';

  String get language => _language;

  void setLanguage(String value) {
    _language = value;
    notifyListeners();
  }
}
