import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialProvider extends ChangeNotifier {
  String _error;
  bool _isSocialLogin = false;

  String get error => _error;
  bool get isSocialLogin => _isSocialLogin;

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
  void googleLogin() async {
    try{
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      GoogleSignInAccount acc = await _googleSignIn.signIn();
      GoogleSignInAuthentication auth = await acc.authentication;
      Map data = {"authType": "g", "accessToken": auth.accessToken};

      _log("googleLogin", auth.accessToken, data, auth);
      //토큰 디바이스 로컬에 저장
      socialTokeSave(auth.accessToken);
      // checkServer(data);
    } catch(e) {
      // 화면 전환을 위해 임시로 로그인을 성공으로 함
      print("##### googleLogin error: $e");
      _isSocialLogin = true;
      // _isSocialLogin = false;
      notifyListeners();
    }
  }

  // 네이버 로그인
  void naverLogin() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
      Map data = {"authType": "n", "accessToken": res.accessToken};

      _log("naverLogin", res.accessToken, data, result);
      //토큰 디바이스 로컬에 저장
      socialTokeSave(res.accessToken);
      // checkServer(data);
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
    String token = prefs.getString('social_token');

    if (token == null || token.isEmpty) {
      _isSocialLogin = false;
    } else {
      _isSocialLogin = true;
    }
    notifyListeners();
  }

  // token 서버로 전송
  void checkServer(data) async {
    Dio dio = new Dio();

    Response response = await dio.post(
      "http://172.16.11.225:8080/v1/login/sns",
      data: data,
      options: Options(
        headers: {
          Headers.contentTypeHeader: "application/json",
        },
      ),
    );
    print(response.data["token"]);
  }

  void _log(social, token, result, data) {
    print("##### $social");
    print("##### social login success token: $token");
    print("##### social data: $data");
    print("##### social result: $result");
  }
}