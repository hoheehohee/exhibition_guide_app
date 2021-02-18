import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuideView extends StatefulWidget {
  @override
  _GuideViewState createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> {
  bool _isChecked = false;
  AppLocalizations _locals;

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
    _locals = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0xff304456),
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
                  _locals.guide1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 20),
              _guideText(_locals.guide2),
              _guideText(_locals.guide3),
              _guideText(_locals.guide4),
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
      backgroundColor: Color(0xff304456),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
              icon: Image.asset("assets/images/button/btn-cancel.png", width: 20,),
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
      padding: const EdgeInsets.only(left: 20, top: 30),
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
            child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
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
          Text(_locals.guide5, style: TextStyle(fontSize: 18, color: Colors.white)),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconButton(
              color: Colors.white,
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
