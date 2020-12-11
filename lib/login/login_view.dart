import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

void login(BuildContext context) async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount acc = await _googleSignIn.signIn();
  GoogleSignInAuthentication auth = await acc.authentication;
  Dio dio = new Dio();

  Response response = await dio.post(
                            "http://127.0.0.1:8080/v1/login/sns",
                            data: {"authType": "g", "accessToken": auth.accessToken},
                            options: Options(
                              headers: {
                                Headers.contentTypeHeader: "application/json",
                              },
                            ),
                          );
  print(response);
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
                    Navigator.pushReplacementNamed(context, '/exhibitionMain');
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
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => FlutterBeacon())
                    // );
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
                onPressed: () {},
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
                    login(context);
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