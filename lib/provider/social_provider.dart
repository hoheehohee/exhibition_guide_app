import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/mypage/agree_dialog_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _BASE_URL = 'http://220.95.107.101/';

class SocialProvider with ChangeNotifier {
  String _error;
  bool _isSocialLogin = false;
  String _email;
  String _snsType;

  String get error => _error;
  bool get isSocialLogin => _isSocialLogin;
  String get email => _email;
  String get snsType => _snsType;

  // 카카오 로그인
  Future<Map> kakaoLogin() async {
    print("##### kakaoLogin");
    try {
      String authCode = await AuthCodeClient.instance.request(); // via browser
      AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      User user = await UserApi.instance.me();
      Map data = {"snsType": "kakao", "email": user.kakaoAccount.email};
      if(data["email"] == null){
        data["check"] = "C";
      } else {
        data["check"] = await checkServer(data);
      }
      return data;
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### kakaoLogin error: $e");
      _isSocialLogin = false;
      // _isSocialLogin = false;
      notifyListeners();
    }

    /*final FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
    final result = await kakaoSignIn.getUserMe();
    final KakaoAccountResult account = result.account;
    if (account != null) {
      final KakaoAccountResult account = result.account;
      final userID = account.userID;
      final userEmail = account.userEmail;
      final userPhoneNumber = account.userPhoneNumber;
      final userDisplayID = account.userDisplayID;
      final userNickname = account.userNickname;
      final userGender = account.userGender;
      final userAgeRange = account.userAgeRange;
      final userBirthday = account.userBirthday;
      final userProfileImagePath = account.userProfileImagePath;
      final userThumbnailImagePath = account.userThumbnailImagePath;
    }*/
    /*try{
      FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
      final result = await kakaoSignIn.logIn();
      final KakaoAccountResult account = result.account;
      Map data = {"snsType": "kakao", "email": account.userEmail};
      if(data["email"] == null){
        data["check"] = "C";
      } else {
        data["check"] = await checkServer(data);
      }
      return data;
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### kakaoLogin error: $e");
      _isSocialLogin = false;
      // _isSocialLogin = false;
      notifyListeners();
    }*/
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
      if(data["email"] == null){
        data["check"] = "C";
      } else {
        data["check"] = await checkServer(data);
      }
      return data;

    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### googleLogin error: $e");
      _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 네이버 로그인
  Future<Map> naverLogin() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
      Map data = {"snsType": "naver", "email": result.account.email};
      if(data["email"] == null){
        data["check"] = "C";
      } else {
        data["check"] = await checkServer(data);
      }
      return data;
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### naverLogin error: $e");
      // _isSocialLogin = true;
      _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 페이스북 로그인
  Future<Map> facebookLogin() async {
    try {
      Dio dio = new Dio();
      final fb = FacebookLogin();
      // Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      if (res.status == FacebookLoginStatus.success) {
        final FacebookAccessToken accessToken = res.accessToken;
        final resp = await dio.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
        var info = Map<String, dynamic>.from(json.decode(resp.toString()));
        Map data = {"snsType": "facebook", "email": info['email']};
        //토큰 디바이스 로컬에 저장
        if(data["email"] == null){
          data["check"] = "C";
        } else {
          data["check"] = await checkServer(data);
        }
        return data;
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
    String snsType = prefs.getString('snsType');

    if (loginId == null || loginId.isEmpty) {
      _isSocialLogin = false;
    } else {
      _isSocialLogin = true;
      _email = email;
      _snsType = snsType;
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
        await prefs.setString('snsType', data["snsType"]);
        _email = data["email"];
        _snsType = data["snsType"];
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
      resp = await dio.get("${_BASE_URL}userCheckData.do?snsType=${data['snsType']}&email=${data['email']}");
      var map = Map<String, dynamic>.from(json.decode(resp.toString()));

      if(map["status"] == "Y"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loginId', map["loginID"]);
        await prefs.setString('email', data['email']);
        _email = data["email"];
        _isSocialLogin = true;
      } else {
        resp = await dio.get("${_BASE_URL}userJoinData.do?snsType=${data['snsType']}&email=${data['email']}");
        if(map["status"] == "Y"){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginId', map["loginID"]);
          await prefs.setString('email', data["email"]);
          _email = data["email"];
          _snsType = data["snsType"];
          _isSocialLogin = true;
        }
      }
      return "Y";
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


