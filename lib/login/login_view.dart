import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart' ;
import 'package:get/get.dart' hide Response;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

void googleLogin() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount acc = await _googleSignIn.signIn();
  GoogleSignInAuthentication auth = await acc.authentication;
  Map data = {"authType": "g", "accessToken": auth.accessToken};
  checkServer(data);
}

void naverLogin() async {
  final NaverLoginResult result = await FlutterNaverLogin.logIn();
  NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
  Map data = {"authType": "n", "accessToken": res.accessToken};
  checkServer(data);
}

void kakaoLogin() async {
  FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
  await kakaoSignIn.logIn();
  KakaoToken token = await (kakaoSignIn.currentToken);
  print(token.accessToken);
  Map data = {"authType": "k", "accessToken": token.accessToken};
  checkServer(data);
}

void facebookLogin() async {
  final fb = FacebookLogin();

// Log in
  final res = await fb.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email,
  ]);

  if (res.status == FacebookLoginStatus.Success) {
    final FacebookAccessToken accessToken = res.accessToken;
    print('Access token: ${accessToken.token}');
    Map data = {"authType": "f", "accessToken": accessToken.token};
    checkServer(data);
  }
}

void checkServer(data) async {
  // Dio dio = new Dio();
  //
  // Response response = await dio.post(
  //   "http://172.16.11.225:8080/v1/login/sns",
  //   data: data,
  //   options: Options(
  //     headers: {
  //       Headers.contentTypeHeader: "application/json",
  //     },
  //   ),
  // );
  //
  // print(response.data["token"]);
  Get.to(MainView());
}

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlueColor,
        body: Stack(
          children: [
            _mainBackGround(),
            _socialButtons(context)
          ],
        ));
  }

  Widget _mainBackGround() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/main_image.jpeg'),
              fit: BoxFit.cover
          )
      ),
    );
  }



  Widget _socialButtons(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                  onPressed: () {
                    kakaoLogin();
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
                  onPressed: () {
                    naverLogin();
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
                          style: TextStyle(
                              fontSize: 16, color: kWhiteColor)),
                    ],
                  )),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                onPressed: () {
                  facebookLogin();
                },
                color: kFacebookColor,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/facebook_logo.png"),
                      SizedBox(width: 8),
                      Text(
                        "Sign up with Facebook",
                        style:
                        TextStyle(fontSize: 16, color: kWhiteColor),
                      )
                    ]),
              ),
              SizedBox(
                height: 12,
              ),
              MaterialButton(
                  onPressed:() {
                    googleLogin();
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
