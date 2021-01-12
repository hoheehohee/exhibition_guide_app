import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideView extends StatefulWidget {
  @override
  _GuideViewState createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> {
  bool _isChecked = false;

  // 다시보지않기 클릭.
  void _checked(type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('isSeeGuide', type);
    Get.off(
        MainView(),
        transition: Transition.fadeIn
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: double.infinity,
        // color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                  "'박물관이용'앱 공지",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)
              ),
              SizedBox(height: 20),
              _guideText('발물관 안에서는 이어폰을 사용해주세요.'),
              _guideText('자동전시안내를 이용하시려면 \n블루투스를 켜주세요.'),
              _guideText('박물관 무료 Wi-Fi 존에서 전시 콘텐츠\n다운로드가 가능합니다.'),
              Expanded(
                flex: 1,
                child: _bottonBtn()
              )
            ],
          ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white24,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                _checked('ignore');
              }
          );
        },
      ),
    );
  }

  Widget _guideText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.check, color: Colors.orange),
          ),
          Expanded(
            flex: 1,
            child: Text(text, style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget _bottonBtn() {
    return Align(
      alignment: Alignment(0, 0.7),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('다시보지 않기', style: TextStyle(fontSize: 18)),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: _isChecked ? Icon(Icons.radio_button_on, color: Colors.orange) : Icon(Icons.radio_button_off),
              onPressed: () {
                setState(() {
                  _isChecked = !_isChecked;
                });
                _checked('agree');
              },
            ),
          )
        ],
      ),
    );
  }
}
