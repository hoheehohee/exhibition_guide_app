import 'package:exhibition_guide_app/mypage/qna_list_view.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'login_dialog_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  SocialProvider _social;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Divider(color: Colors.grey.withOpacity(0.3),),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(left: 30, right: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/images/profile_sample.jpeg", fit: BoxFit.fill,)
            )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('아이유', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset("assets/images/kakao_icon.png")
                )
              ],
            ),
            SizedBox(height: 10),
            Text('iu@gmail.com', style: TextStyle(color: Colors.grey)),
            Text('010-1234-5678', style: TextStyle(color: Colors.grey))
          ],
        )
      ],
    );
  }

  Widget _notLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(left: 30, right: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
            ),

            // child: ClipRRect(
            //     borderRadius: BorderRadius.circular(50),
            //     child: Image.asset("assets/images/profile_sample.jpeg", fit: BoxFit.fill,)
            // )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('로그인 / 가입', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      color: Colors.white,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          Get.dialog(
                            LoginDialogView(),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                      ),
                    )
                )
              ],
            ),
            // SizedBox(height: 5),
            Text('로그인하시면 더 많은 서비스를\n이용하실 수 있습니다.', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget _buttonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
            color: Colors.white,
            child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Icon(Icons.notifications_none, size: 40,),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(child: Text('1', style: TextStyle(color: Colors.white)))
                              )
                          )
                        ],
                      ),
                      Center(child: Text('알림', textAlign: TextAlign.center,))
                    ],
                  ),
                )
            )
        ),
        Material(
            color: Colors.white,
            child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Icon(Icons.notifications_none, size: 40,),
                      Center(child: Text('예약신청 1', textAlign: TextAlign.center,))
                    ],
                  ),
                )
            )
        ),
        Material(
            color: Colors.white,
            child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Icon(Icons.comment_outlined, size: 40,),
                      Center(child: Text('문의글 5', textAlign: TextAlign.center,))
                    ],
                  ),
                )
            )
        ),
      ],
    );
  }

  Widget _applicationInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('신청정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Material(
                color: Colors.white,
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                )
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text('예약신청')
                ],
              ),
              VerticalDivider(color: Colors.black12),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('0', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text('이용중')
                ],
              ),
              VerticalDivider(color: Colors.black12),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1,035', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  Text('이용완료')
                ],
              ),
            ],
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
            Text('로그인된 정보가 없습니다', style: TextStyle(color: Colors.grey.withOpacity(0.3)),)
          ],
        )
    );
  }
}
