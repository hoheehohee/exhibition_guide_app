import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

import '../constant.dart';
import 'agree_dialog_view.dart';

class LoginDialogView extends StatefulWidget {
  @override
  _LoginDialogViewState createState() => _LoginDialogViewState();
}

class _LoginDialogViewState extends State<LoginDialogView> {

  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    final _social = Provider.of<SocialProvider>(context);

    if (_social.isSocialLogin) {
      Get.back();
    }

    return Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/img-back.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomLeft,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _appBar(),
                  _socialButtons(context)
                ],
              ),
            ],
          )
        )
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.white,
          child: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.clear),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment(-0.2, 1),
            child: Text('로그인',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none)),
          ),
        )
      ],
    );
  }

  Widget _socialButtons(BuildContext context) {
    final _social = Provider.of<SocialProvider>(context);
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: mqh * 0.05),
              Image.asset("assets/images/sns-logo.png", height: mqh * 0.13,),
              SizedBox(height: mqh * 0.04),
              Container(
                height: mqh * 0.07,
                width: mqw * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icon/icon-thunder.png", height: mqh * 0.04,),
                    SizedBox(width: mqw * 0.02,),
                    Text("3초만에 빠른 회원가입", style: TextStyle(fontSize: 14, color: Colors.black),)
                  ],
                ),
              ),
              SizedBox(height: mqh * 0.02),
              MaterialButton(
                  onPressed: () async {
                    // var login = await _social.kakaoLogin();
                    // if (login == null && login["check"] == "N") {
                    //   Get.dialog(AgreeDialogView(login['snsType'], login['email']));
                    // }
                    Get.back();
                    Get.dialog(
                      AgreeDialogView('kakao', 'test@naver.com')
                    );
                  },
                  color: kKakaoColor,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: mqh * 0.02),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icon/icon-kakao.png", width: mqw * 0.07, fit: BoxFit.fill,),
                      SizedBox(width: 8),
                      Text(
                        '카카오톡으로 계속하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                  onPressed: () async {
                    var login = await _social.naverLogin();
                    if (login["check"] == "N") {
                      Get.dialog(AgreeDialogView(login['snsType'], login['email']));
                    }
                  },
                  color: kNaverColor,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: mqh * 0.02),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icon/icon-naver.png",width: mqw * 0.06, fit: BoxFit.fill,),
                      SizedBox(width: 8),
                      Text(
                        '네이버로 계속하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                onPressed: () async {
                  var login = await _social.facebookLogin();
                  if (login["check"] == "N") {
                    Get.dialog(AgreeDialogView(login['snsType'], login['email']));
                  }
                },
                color: kFacebookColor,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: mqh * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset("assets/images/icon/icon-facebook.png", width: mqw * 0.035, fit: BoxFit.fill,),
                    SizedBox(width: 8),
                    Text(
                      "페이스북으로 계속하기",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    )
                ]),
              ),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                  onPressed: () async {
                    var login = await _social.googleLogin();
                    if (login["check"] == "N") {
                      Get.dialog(AgreeDialogView(login['snsType'], login['email']));
                    }
                  },
                  color: Color(0xffE5E6E7),
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: mqh * 0.02),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icon/icon-google.png", width: mqw * 0.06, fit: BoxFit.fill,),
                      SizedBox(width: 8),
                      Text(
                        'Google로 계속하기',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
