import 'package:exhibition_guide_app/exhibitInfo/exhibitInfo_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/language/language_view.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:exhibition_guide_app/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:exhibition_guide_app/guide/guide_view.dart';

import '../exhibit/exhibit_detail.dart';
import '../message.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  var _isSeeGuide = 'init';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _init();
    });
  }

  void _init() async {

    // 첫 가이드 화면 노출 여부 체크
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSeeGuide = prefs.getString('isSeeGuide');

    // 가이드 화면 노출 설정
    if(_isSeeGuide.isNull || _isSeeGuide == 'init'){
      Get.off(
        GuideView(),
        transition: Transition.fadeIn
      );
    } else if (_isSeeGuide == 'ignore' ){
      await prefs.setString('isSeeGuide', 'init');
    }

    // default 언어 설정
    final language = prefs.getString('language');
    if (language.isNull) {
     await prefs.setString('language', 'ko');
    }
    // social 로그인 체크
    Future.microtask(() {
      Provider.of<SocialProvider>(context, listen: false).socialLoginCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _museumComponent(),  // 박물관 사진 및 타이틀트 컴포넌트
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: _exhibitionInfoButtons(),  // 전시물 버큰 컴포넌트
          ),
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
            // color: Colors.green,
            child: _mapButton() // 전시물 위치보기 버큰 컴포넌트
          )
        ],
      )
    );
  }

  // 박물관 사진 및 타이틀 컴포넌
  Widget _museumComponent() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/main_image.jpeg"),
                  fit: BoxFit.fill
              )
          ),
        ),
        // Image.asset("assets/images/main_image.jpeg",fit: BoxFit.fill),
        Positioned(
          left: 10,
          top: 30,
          child: FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.settings, color: Colors.white),
            onPressed: () => {
              Get.to(
                SettingView(),
                transition: Transition.leftToRight
              )
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          right: 10,
          top: 30,
          child:  FloatingActionButton(
            heroTag: 2,
            child: Icon(Icons.g_translate, color: Colors.white),
            onPressed: () => {
              Get.to(
                LanguageView(),
                transition: Transition.rightToLeft
              )
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          right: 80,
          top: 150,
          left: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('코쟁이 박물관', style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),),
              Text('재미있는 코쟁이 전시회', style: TextStyle(fontSize: 18, color: Colors.white))
            ],
          ),
        ),
        Positioned(
            right: 10,
            bottom: 0,
            child: FloatingActionButton(
              heroTag: 3,
              child: Icon(Icons.arrow_circle_down, size: 28, color: Colors.white),
              onPressed: () {
                Get.defaultDialog(
                  title: "알림",
                  titleStyle: TextStyle(),
                  middleText: downloadMessage,
                  confirm: FlatButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("다운로드", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                );
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
            )
        )
      ],
    );
  }

  // 전시물 버큰 컴포넌트
  Widget _exhibitionInfoButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 210,
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Get.to(
                      ExhibitInfoView(),
                      transition: Transition.fadeIn
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(imageUrl1, fit: BoxFit.fill,),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('전시 유물', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 210,
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Get.to(
                      ExhibitDetail(2)
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(imageUrl2, fit: BoxFit.fill,),
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('상설전시물', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }

  // 전시물 위치보기 버튼 컴포넌트
  Widget _mapButton() {
    return RaisedButton(
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Text('전시물 위치보기', style: TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: () {
        Get.to(
            ExhibitionMapView(),
            transition: Transition.downToUp
        );
      },
    );
  }

}
