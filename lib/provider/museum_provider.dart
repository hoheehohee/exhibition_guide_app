import 'package:flutter/foundation.dart';

class MuseumProvider extends ChangeNotifier {
  bool _isPermanentExhibition = false;
  bool _isAutoExhibit = false;
  bool _isAudio = false;

  List _imgList = [
    'https://monthlyart.com/wp-content/uploads/2020/07/Kukje-Gallery-Wook-kyung-Choi-Untitled-c.-1960s-34-x-40-cm.jpg',
    'https://www.lottemuseum.com/attach//Exhabition/2019/01/bg_main_02_exhibition_mobile.jpg',
    'https://i.pinimg.com/originals/2c/14/9a/2c149a9c12290855b200229d311f2bb7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTouyEvqQGwUrD5GtMb5rDfnZz3UARwHHCATA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIY1We4FiCxJfLMb5ju015QPtNZS6kQlsZ7w&usqp=CAU',
  ];

  bool get isPermanentExhibition => _isPermanentExhibition;
  bool get isAutoExhibit => _isAutoExhibit;
  bool get isAudio => _isAudio;

  List get imageList => _imgList;

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
}