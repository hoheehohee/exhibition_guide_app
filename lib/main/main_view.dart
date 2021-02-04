import 'dart:async';
import 'package:exhibition_guide_app/commons/custom_main_button.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_highlight_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_list_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_theme_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_video_view.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exhibition_guide_app/guide/guide_view.dart';

import '../message.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      return;
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
      Provider.of<DevicesProvider>(context, listen: false).init();
    });
  }

  Future<void> _showMyDialog() async {
    final _deviceProv = Provider.of<DevicesProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("UUID: ${_deviceProv.beaconData != null ? _deviceProv.beaconData.uuid : ''}"),
                SizedBox(height: 5,),
                Text("major: ${_deviceProv.beaconData != null ? _deviceProv.beaconData.major : ''}"),
                Text("minor: ${_deviceProv.beaconData != null ? _deviceProv.beaconData.minor : ''}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _exhibitProv = Provider.of<ExhibitProvider>(context, listen: false);
    final _deviceProv = Provider.of<DevicesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Container(
          color: Color(0xff1A1A1B),
          child: SliderDrawers(),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 120,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/logo.png',
                        width: 116,
                        // height: 63.5,
                        fit: BoxFit.fitWidth
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/images/icon/icon-login.png",
                              width: 22,
                            ),
                            Text(
                              "로그인",
                              style: TextStyle(fontSize: 18, height: 1.5),
                            ),
                          ],
                        ),
                        onTap: () {
                          _showMyDialog();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Image.asset(
                            _deviceProv.isBeaconConnect
                                ? 'assets/images/icon/icon-bluetooth-on.png'
                                : 'assets/images/icon/icon-bluetooth-off.png',
                            width: 45,
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            _showMyDialog();
                          },
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/button/btn-hamburger.png',
                            width: 45,
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            _scaffoldKey.currentState.openEndDrawer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ),
          Expanded(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/main-back.jpg"),
                        fit: BoxFit.fitWidth
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '오늘은 어떻게 관람하고',
                                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(
                                '싶으신가요?',
                                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomMainButton(
                              onTap: () async {
                                Get.offAll(ExhibitListView(
                                  appBarTitle: '전시유물',
                                  contentType: 'B',
                                  contentTitle: "전시유물",
                                  contentIconPath: "assets/images/icon/icon-main-relics.png",
                                ));
                              },
                              title: "전시유물",
                              imgPath: 'assets/images/icon/icon-main-relics.png',
                            ),
                            CustomMainButton(
                              onTap: () {
                                Get.to(ExhibitHighlightView());
                              },
                              title: "하이라이트",
                              imgPath: 'assets/images/icon/icon-main-highlight.png',
                            ),
                            CustomMainButton(
                              onTap: () async {
                                Get.offAll(ExhibitListView(
                                  appBarTitle: '상설전시',
                                  contentType: 'A',
                                  contentTitle: "상설전시",
                                  contentIconPath: "assets/images/icon/icon-main-sangsul.png",
                                ));
                              },
                              title: "상설전시",
                              imgPath: 'assets/images/icon/icon-main-sangsul.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomMainButton(
                              onTap: () {
                                Get.offAll(
                                  ExhibitThemeView(
                                    appBarTitle: '4F 전시실',
                                    location: 'A',
                                  )
                                );
                              },
                              title: "4F 전시",
                              imgPath: 'assets/images/icon/icon-main-4f.png',
                            ),
                            CustomMainButton(
                              onTap: () {},
                              title: "5F 전시실",
                              imgPath: 'assets/images/icon/icon-main-5f.png',
                            ),
                            CustomMainButton(
                              onTap: () {},
                              title: "기획전시",
                              imgPath: 'assets/images/icon/icon-main-plan.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomMainButton(
                              onTap: () {},
                              title: "오시는",
                              imgPath: 'assets/images/icon/icon-main-location.png',
                            ),
                            CustomMainButton(
                              onTap: () {},
                              title: "공지사항",
                              imgPath: 'assets/images/icon/icon-main-notice.png',
                            ),
                            CustomMainButton(
                              onTap: () {},
                              title: "도슨트예약",
                              imgPath: 'assets/images/icon/icon-main-docent.png',
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 87,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Image.asset(
                                  Provider.of<DevicesProvider>(context).isRunning
                                    ? 'assets/images/toogle-main-on.png'
                                    : 'assets/images/toogle-main-off.png',
                                  width: 200,
                                  fit: BoxFit.fill,
                                ),
                                onPressed: () {
                                  // _device.becaonScan(!_device.isRunning);
                                },
                              ),
                            )
                        ),
                        Text(
                            "자동 전시안내",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                        ),
                        SizedBox(height: 17),
                        Container(
                          padding: EdgeInsets.only(top: 21, bottom: 20, left: 10, right: 10),
                          color: Color(0xff253242).withOpacity(0.7),
                          child: (
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('개인정보처리방침', style: TextStyle(fontSize: 15, color: Colors.white)),
                                  SizedBox(height: 8),
                                  Text(
                                    FOOTER_ADDRESS,
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    FOOTER_COPY,
                                    style: TextStyle(fontSize: 10, color: Color(0xff5A6B7B)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
          )
        ],
      ),
    );
  }
}
