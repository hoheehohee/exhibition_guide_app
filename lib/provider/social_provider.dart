import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/mypage/agree_dialog_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _BASE_URL = 'http://115.144.53.222:8081/ilje/';

class SocialProvider with ChangeNotifier {
  String _error;
  bool _isSocialLogin = false;
  String _email;

  String get error => _error;
  bool get isSocialLogin => _isSocialLogin;
  String get email => _email;

  // 카카오 로그인
  void kakaoLogin() async {
    print("##### kakaoLogin");
    try{
      FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
      final result = await kakaoSignIn.logIn();
      KakaoToken token = await (kakaoSignIn.currentToken);
      Map data = {"authType": "k", "accessToken": token.accessToken};

      _log("kakaoLogin", token.accessToken, result, data);
      //토큰 디바이스 로컬에 저장
      socialTokeSave(token.accessToken);
      // checkServer(data);
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### kakaoLogin error: $e");
      _isSocialLogin = true;
      // _isSocialLogin = false;
      notifyListeners();

    }
  }

  // 구글 로그인
  Future<Map> googleLogin() async {
    try{

      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      GoogleSignInAccount acc = await _googleSignIn.signIn();
      GoogleSignInAuthentication auth = await acc.authentication;
      Map data = {"snsType": "google", "email": acc.email};
      _log("googleLogin", auth.accessToken, data, auth);
      data["check"] = checkServer(data);
      return data;

    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### googleLogin error: $e");
      _isSocialLogin = true;
      // _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 네이버 로그인
  Future<Map> naverLogin() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
      Map data = {"snsType": "naver", "email": result.account.email};
      _log("naverLogin", res.accessToken, data, result);
      data["check"] = checkServer(data);
      return data;
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### naverLogin error: $e");
      _isSocialLogin = true;
      // _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 페이스북 로그인
  void facebookLogin() async {
    try {
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

        _log("facebookLogin", accessToken.token, data, res);
        //토큰 디바이스 로컬에 저장
        socialTokeSave(accessToken.token);
        // checkServer(data);
      }
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### naverLogin error: $e");
      _isSocialLogin = true;
      // _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 디바이스 로컬 스토어에 저장 social token 저장
  void socialTokeSave(String token) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('social_token', token);

    _isSocialLogin = true;
    notifyListeners();
  }

  // 초기 진입 social 로그인 확인
  void socialLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginId = prefs.getString('loginId');
    String email = prefs.getString('email');

    if (loginId == null || loginId.isEmpty) {
      _isSocialLogin = false;
    } else {
      _isSocialLogin = true;
      _email = email;
    }
    notifyListeners();
  }

  // token 서버로 전송
  Future<String> checkServer(data) async {
    Dio dio = new Dio();
    print("##### checkServer ");
    Response resp;

    try {
      resp = await dio.get("${_BASE_URL}userCheckData.do?snsType=${data['snsType']}&email=${data['email']}");
      var map = Map<String, dynamic>.from(json.decode(resp.toString()));
      if(map["status"] == "N"){
        Get.off(AgreeDialogView(data['snsType'], data['email']));
      } else if(map["status"] == "Y"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loginId', map["loginID"]);
        await prefs.setString('email', data["email"]);
        _email = data["email"];
        _isSocialLogin = true;
        notifyListeners();
      } else if(map["status"] == "B"){

      }

      return map["status"];
    }catch(error){
      print('##### getExhibitSel: $error');
    }
  }

  Future<String> joinServer(data) async {
    Dio dio = new Dio();
    print("##### joinServer ");
    Response resp;

    try {
      print("${_BASE_URL}userCheckData.do?snsType=naver&email=harbris@naver.com");
      resp = await dio.get("${_BASE_URL}userCheckData.do?snsType=naver&email=harbris@naver.com");
      var map = Map<String, dynamic>.from(json.decode(resp.toString()));

      if(map["status"] == "Y"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loginId', map["loginID"]);
        await prefs.setString('email', data['email']);
        _email = data["email"];
        _isSocialLogin = true;
      } else {

      }

      // return map["status"];
      return "J";
    }catch(error){
      print('##### joinServer: $error');
    }
  }

  void _log(social, token, result, data) {
    print("##### $social");
    print("##### social login success token: $token");
    print("##### social data: $data");
    print("##### social result: $result");
  }

  // 디바이스 로컬 스토어에 저장 social token 저장
  void logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    _isSocialLogin = false;
    notifyListeners();
  }

}


