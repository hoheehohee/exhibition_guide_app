import 'package:flutter/material.dart';
import 'package:exhibition_guide_app/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _locale;
  Locale get locale => _locale;

  LocaleProvider() {
    defaultLanguage();
  }

  Future<void> defaultLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _language = prefs.getString('language');
    setLocale(_language);
  }


  void setLocale(String value) {
    if (!L10n.all.contains(Locale(value))) return;
    _locale = Locale(value);
    print("#### value: $_locale");
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}