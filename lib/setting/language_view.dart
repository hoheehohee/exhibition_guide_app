import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatelessWidget {
  SettingProvider _language;
  @override
  Widget build(BuildContext context) {
    final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
    _language = Provider.of<SettingProvider>(context);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xff365871),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                  _languageItem('한국어', 'ko')
              ),
              SizedBox(height: 1),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xff365871),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _languageItem('ENGLISH', 'en')
              ),
              SizedBox(height: 1),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xff365871),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _languageItem('中文', 'cn')
              ),
              SizedBox(height: 1),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xff365871),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _languageItem('日本語', 'ja')
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '언어 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        leading: Builder(
            builder: (BuildContext context) => (
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                )
            )
        )
    );
  }
  // 언어 Item 컴포넌트
  Widget _languageItem(String title, String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 18),),
        IconButton(
          icon: (
            _language.language == language
              ? Image.asset("assets/images/button/btn-check-on.png")
              : Image.asset("assets/images/button/btn-check-off.png")
          ),
          onPressed: () {
            _language.setLanguage(language);
          },
        )
      ],
    );
  }
}
