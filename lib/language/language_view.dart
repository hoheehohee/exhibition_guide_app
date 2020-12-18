import 'package:exhibition_guide_app/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
    final _language = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              '언어 설정',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black26,
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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('中文'),
                      IconButton(
                        icon:
                          _language.language == 'cn'
                            ? Icon(Icons.check_circle_outline, color: Colors.orange)
                            : Icon(Icons.radio_button_off),
                        onPressed: () {
                          _language.setLanguage('cn');
                        },
                      )
                    ],
                  )
              ),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black26,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ENGLISH'),
                      IconButton(
                        icon:
                          _language.language == 'en'
                            ? Icon(Icons.check_circle_outline, color: Colors.orange)
                            : Icon(Icons.radio_button_off),
                        onPressed: () {
                          _language.setLanguage('en');
                        },
                      )
                    ],
                  )
              ),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('日本語'),
                      IconButton(
                        icon:
                          _language.language == 'ja'
                            ? Icon(Icons.check_circle_outline, color: Colors.orange)
                            : Icon(Icons.radio_button_off),
                        onPressed: () {
                          _language.setLanguage('ja');
                        },
                      )
                    ],
                  )
              ),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black26,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('한국어'),
                      IconButton(
                        icon:
                          _language.language == 'ko'
                          ? Icon(Icons.check_circle_outline, color: Colors.orange)
                          : Icon(Icons.radio_button_off),
                        onPressed: () {
                          _language.setLanguage('ko');
                        },
                      )
                    ],
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}
