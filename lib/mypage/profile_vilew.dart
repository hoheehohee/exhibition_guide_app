import 'package:exhibition_guide_app/mypage/qna_list_view.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_dialog_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var mqd;
  var mqw;
  var mqh;

  SocialProvider _social;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String getSnsIcon(String snsType) {
    print(snsType);
    String icon = "";
    switch (snsType) {
      case "google":
        {
          icon = "assets/images/google_icon.png";
        }
        break;
      case "kakao":
        {
          icon = "assets/images/kakao_icon.png";
        }
        break;
      case "naver":
        {
          icon = "assets/images/naver_icon.png";
        }
        break;
      case "facebook":
        {
          icon = "assets/images/facebook_icon.png";
        }
        break;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _social = Provider.of<SocialProvider>(context);
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            _social.isSocialLogin
            ? _loginView()  // 로그인 시
            : _notLogin(),  // 비로그인 시
            SizedBox(height: 20,),
            _buttonGroup(), // 알림, 예약신청, 문의글 버튼 그룹
            // Divider(color: Colors.grey.withOpacity(0.3),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: _applicationInformation()  // 신청정보
            ),
            Divider(color: Colors.grey.withOpacity(0.3),),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('내 문의글', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Material(
                          color: Colors.white,
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    ),
                  ]
              )
            ),
            _qnaList()
          ],
        ));
  }

  Widget _loginView() {
    _social = Provider.of<SocialProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(left: 30, right: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(getSnsIcon(_social.snsType), fit: BoxFit.fill,)
            )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(_social.email, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                RaisedButton(
                  disabledColor: Colors.red,
                  disabledTextColor: Colors.black,
                  onPressed: () => _social.logout(),
                  child: Text('로그아웃'),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        )
      ],
    );
  }

  Widget _notLogin() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: mqh * 0.03),
      child: InkWell(
        onTap: () {
          print("#### onTap");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(left: mqw * 0.15, right: mqw * 0.05),
              decoration: BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/icon/icon-login-g.png", width: mqw * 0.1, fit: BoxFit.fitWidth,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('로그인 · 가입', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                    Image.asset("assets/images/icon/icon-login-arrow.png", height: mqh * 0.02,)
                  ],
                ),
                SizedBox(height: 10),
                Text('로그인하시면 더 많은 서비스를\n이용하실 수 있습니다.', style: TextStyle(color: Colors.grey)),
                // SizedBox(height: 10),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _buttonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              print("### 예약신청");
            },
            child: Container(
              height: mqh * 0.13,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/icon/icon-alarm-g.png", width: mqw * 0.07,),
                  SizedBox(width: 20,),
                  Text("예약신청", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          )
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              print("### 문의글");
            },
            child: Container(
              height: mqh * 0.13,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)),
                    bottom: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)),
                    left: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/icon/icon-edit.png", width: mqw * 0.07,),
                  SizedBox(width: 20,),
                  Text("문의글", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          )
        )
      ]
    );
  }

  Widget _applicationInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: mqw * 0.02),
          child: Text('신청정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1', style: TextStyle(color: Color(0xffA48C60), fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10,),
                    Text('예약신청', style: TextStyle(fontSize: 16),)
                  ],
                ),
                VerticalDivider(color: Colors.black12, thickness: 3, indent: 10, endIndent: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1', style: TextStyle(color: Color(0xffA48C60), fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10,),
                    Text('이용중', style: TextStyle(fontSize: 16),)
                  ],
                ),
                VerticalDivider(color: Colors.black12, thickness: 3, indent: 10, endIndent: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1', style: TextStyle(color: Color(0xffA48C60), fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10,),
                    Text('이용완료', style: TextStyle(fontSize: 16),)
                  ],
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _qnaList() {
    // 소셜 로그인이 되어 있으면.
    if (_social.isSocialLogin) {
      return QnaListView();
    }

    return Center(
        child: Container(
          margin: EdgeInsets.only(bottom: mqh * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/icon/icon-no-data.png", width: mqw * 0.23,),
              SizedBox(height: 20,),
              Text('로그인된 정보가 없습니다')
            ],
          ),
        )
    );
  }
}
