import 'package:flutter/foundation.dart';

class SettingProvider with ChangeNotifier {
  double _fontSize = 18;
  bool _isNetwork = true;

  double get fontSize => _fontSize;
  bool get isNetwork => _isNetwork;

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void setIsNetwork() {
    _isNetwork = !_isNetwork;
    notifyListeners();
  }

}