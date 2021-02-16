import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreeDialogView extends StatefulWidget {
  final String snsType;
  final String email;
  AgreeDialogView(this.snsType, this.email);

  @override
  _AgreeDialogViewState createState() => _AgreeDialogViewState();
}

class _AgreeDialogViewState extends State<AgreeDialogView> {
  var mqd;
  var mqw;
  var mqh;

  bool allCheck = false;
  bool collect = false;
  bool use = false;
  bool retention = false;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

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
          )
        ),
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
                _arrgeForm(),
              ],
            )
          ],
        ),
      ),
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
      ],
    );
  }

  Widget _arrgeForm() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/sns-logo.png", height: mqh * 0.13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageIconBtn(
                  px: 25.0,
                  iconPath: (
                    allCheck || (collect && use && retention)
                      ? "assets/images/button/btn-all-check-on.png"
                      : "assets/images/button/btn-all-check-off.png"
                  ),
                  onAction: () {
                    setState(() {
                      collect = !allCheck;
                      use = !allCheck;
                      retention = !allCheck;
                      allCheck = !allCheck;
                    });
                  },
                ),
                Text("전체동의하기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: mqh * 0.02,
                bottom: mqh * 0.02,
                right: mqw * 0.03
              ),
              decoration: BoxDecoration(
                color: Color(0xffE5E6E7),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          collect
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            collect = !collect;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("수집항목", style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- 이메일", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text('[필수]'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          use
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            use = !use;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("수집 및 이용 목적", style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- 예약신청 및 문의 앱의 원할한 사용을 위한 동의", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text('[필수]'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          retention
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            retention = !retention;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("보유 및 이용 기간", style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- 서비스 탈퇴 시 또는 1년 동안 미이용 시", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text('[필수]'),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: mqh * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("회원가입 동의정책", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
            SizedBox(height: mqh * 0.02),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: mqh * 0.005,
                  bottom: mqh * 0.005,
                  right: mqw * 0.03
              ),
              decoration: BoxDecoration(
                  color: Color(0xffE5E6E7),
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageIconBtn(
                    px: 25.0,
                    iconPath: (
                        email
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                    ),
                    onAction: () {
                      setState(() {
                        email = !email;
                      });
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("이메일 제3자 동의", style: TextStyle(fontSize: 16)),
                  ),
                  Text('[필수]'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
