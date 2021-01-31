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
  @override
  Widget build(BuildContext context) {
    final _social = Provider.of<SocialProvider>(context);

    if (_social.isSocialLogin) {
      Get.back();
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
          ),
          _socialButtons(context)
        ],
      ),
    );
  }

  Widget _socialButtons(BuildContext context) {
    final _social = Provider.of<SocialProvider>(context);
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                  onPressed: () {
                    _social.kakaoLogin();
                  },
                  color: kKakaoColor,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/kakao_icon.png"),
                      SizedBox(width: 8),
                      Text('Sign up With KaKao',
                          style: TextStyle(
                            fontSize: 16,
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
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/naver_icon.png"),
                      SizedBox(width: 8),
                      Text('Sign up With Naver',
                          style: TextStyle(fontSize: 16, color: kWhiteColor)),
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                onPressed: () {
                  _social.facebookLogin();
                },
                color: kFacebookColor,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("assets/images/facebook_logo.png"),
                  SizedBox(width: 8),
                  Text(
                    "Sign up with Facebook",
                    style: TextStyle(fontSize: 16, color: kWhiteColor),
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
                      Get.dialog(
                          AgreeDialogView(login['snsType'], login['email']));
                    }
                  },
                  color: kWhiteColor,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google_icon.png"),
                      SizedBox(width: 8),
                      Text('Sign up With Google',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  )),
            ],
          )),
    );
  }
}
