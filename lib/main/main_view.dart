import 'dart:async';
import 'package:exhibition_guide_app/booking/booking_view.dart';
import 'package:exhibition_guide_app/commons/custom_main_button.dart';
import 'package:exhibition_guide_app/crm/notice_list_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_highlight_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_list_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_theme_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_directions_view.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/mypage/login_dialog_view.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exhibition_guide_app/guide/guide_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../message.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isSeeGuide = 'init';
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;
  DevicesProvider _deviceProv;
  ExhibitProvider _exhibitProv;
  SocialProvider _social;

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
    if(_isSeeGuide == null || _isSeeGuide == 'init'){
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
    _locals = AppLocalizations.of(context);
    _deviceProv = Provider.of<DevicesProvider>(context);
    _exhibitProv = Provider.of<ExhibitProvider>(context);

    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _social = Provider.of<SocialProvider>(context);

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
              height: mqh * 0.17,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(left: mqw * 0.06, right: mqw * 0.05),
                margin: EdgeInsets.only(top: mqh * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/logo.png',
                        width: mqw * 0.3,
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
                              width: mqw * 0.06,
                            ),
                            Text(
                              _social.isSocialLogin ? _locals.main15:_locals.main2,
                              style: TextStyle(fontSize: 18, height: 1.5),
                            ),
                          ],
                        ),
                        onTap: () {
                          if(_social.isSocialLogin){
                            _social.logout();
                          } else {
                            Get.dialog(
                              LoginDialogView(),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: mqw * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Image.asset(
                            _deviceProv.isBeaconConnect
                                ? 'assets/images/icon/icon-bluetooth-on.png'
                                : 'assets/images/icon/icon-bluetooth-off.png',
                            width: mqw * 0.11,
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            _showMyDialog();
                          },
                        ),
                        SizedBox(width: mqw * 0.01,),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/button/btn-hamburger.png',
                            width: mqw * 0.11,
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
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
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
                      SizedBox(height: mqh * 0.04,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  AppLocalizations.of(context).text1,
                                  style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold)),
                              // Text(
                              //     '싶으신가요?',
                              //     style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: mqh * 0.05),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomMainButton(
                                onTap: () async {
                                  Get.offAll(ExhibitListView(
                                    appBarTitle: _locals.main3,
                                    contentType: 'B',
                                    contentTitle: _locals.main3,
                                    exhibitionType: 'A',
                                    contentIconPath: "assets/images/icon/icon-main-relics.png",
                                  ));
                                },
                                title: _locals.main3,
                                imgPath: 'assets/images/icon/icon-main-relics.png',
                              ),
                              CustomMainButton(
                                onTap: () {
                                  Get.to(ExhibitHighlightView());
                                },
                                title: _locals.main4,
                                imgPath: 'assets/images/icon/icon-main-highlight.png',
                              ),
                              CustomMainButton(
                                onTap: () async {
                                  Get.offAll(ExhibitListView(
                                    appBarTitle: _locals.main5,
                                    contentType: 'A',
                                    contentTitle: _locals.main5,
                                    exhibitionType: 'A',
                                    contentIconPath: "assets/images/icon/icon-main-sangsul.png",
                                  ));
                                },
                                title: _locals.main5,
                                imgPath: 'assets/images/icon/icon-main-sangsul.png',
                              ),
                            ],
                          ),
                          SizedBox(height: mqh * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomMainButton(
                                onTap: () {
                                  _exhibitProv.setMenyType("F4");
                                  Get.offAll(
                                    ExhibitThemeView(
                                      appBarTitle: _locals.main6,
                                      location: 'A',
                                    )
                                  );
                                },
                                title: _locals.main6,
                                imgPath: 'assets/images/icon/icon-main-4f.png',
                              ),
                              CustomMainButton(
                                onTap: () {
                                  _exhibitProv.setMenyType("F5");
                                  Get.offAll(
                                      ExhibitThemeView(
                                        appBarTitle: _locals.main7,
                                        location: 'B',
                                      )
                                  );
                                },
                                title: _locals.main7,
                                imgPath: 'assets/images/icon/icon-main-5f.png',
                              ),
                              CustomMainButton(
                                onTap: () {
                                  _exhibitProv.setMenyType("plan");
                                  Get.offAll(ExhibitListView(
                                    appBarTitle: _locals.main8,
                                    contentType: "",
                                    contentTitle: "",
                                    exhibitionType: 'B',
                                    contentIconPath: "",
                                  ));
                                },
                                title: _locals.main8,
                                imgPath: 'assets/images/icon/icon-main-plan.png',
                              ),
                            ],
                          ),
                          SizedBox(height: mqh * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomMainButton(
                                onTap: () {
                                  Get.to(ExhivitDirectionsView());
                                },
                                title: _locals.main9,
                                imgPath: 'assets/images/icon/icon-main-location.png',
                              ),
                              CustomMainButton(
                                onTap: () {
                                  Get.to(NoticeListView());
                                },
                                title: _locals.main10,
                                imgPath: 'assets/images/icon/icon-main-notice.png',
                              ),
                              CustomMainButton(
                                onTap: () {
                                  Get.to(BookingView());
                                },
                                title: _locals.main11,
                                imgPath: 'assets/images/icon/icon-main-docent.png',
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: mqh  * 0.02),
                              child: SizedBox(
                                width: 87,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Image.asset(
                                    _deviceProv.isRunning
                                      ? 'assets/images/toogle-main-on.png'
                                      : 'assets/images/toogle-main-off.png',
                                    width: mqw * 0.25,
                                    fit: BoxFit.fill,
                                  ),
                                  onPressed: () {
                                    _deviceProv.becaonScan(!_deviceProv.isRunning);
                                  },
                                ),
                              )
                          ),
                          Text(
                              _locals.main13,
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
                                    Text(_locals.main14, style: TextStyle(fontSize: 15, color: Colors.white)),
                                    SizedBox(height: mqh * 0.008),
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
