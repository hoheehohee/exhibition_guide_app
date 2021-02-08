import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

import '../constant.dart';
import 'mypage_view.dart';

class AgreeDialogView extends StatefulWidget {
  final String snsType;
  final String email;
  AgreeDialogView(this.snsType, this.email);

  @override
  _AgreeDialogViewState createState() => _AgreeDialogViewState();
}

class _AgreeDialogViewState extends State<AgreeDialogView>{
  SocialProvider _social;
  var _checkbox_all = false;
  var _checkbox_email = false;
  var _checkbox_coll = false;
  var _checkbox_use = false;
  var _checkbox_third = false;

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _social = Provider.of<SocialProvider>(context, listen: false);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top:40),
        child: Column(
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
            Row(
              children: [
                Checkbox(
                  value: _checkbox_all,
                  onChanged: (value) {
                    setState(() {
                      _checkbox_email = !_checkbox_all;
                      _checkbox_coll = !_checkbox_all;
                      _checkbox_use = !_checkbox_all;
                      _checkbox_third = !_checkbox_all;
                      _checkbox_all = !_checkbox_all;
                    });
                  },
                ),
                Text('전체동의하기'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _checkbox_email,
                  onChanged: (value) {
                    setState(() {
                      _checkbox_email = !_checkbox_email;
                    });
                  },
                ),
                Text('수집항목'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _checkbox_coll,
                  onChanged: (value) {
                    setState(() {
                      _checkbox_coll = !_checkbox_coll;
                    });
                  },
                ),
                Text('수집 및 이용 목적'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _checkbox_use,
                  onChanged: (value) {
                    setState(() {
                      _checkbox_use = !_checkbox_use;
                    });
                  },
                ),
                Text('보유 및 이용 기간'),
              ],
            ),
            Row(
              children: [
                Text('회원가입 동의정책'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _checkbox_third,
                  onChanged: (value) {
                    setState(() {
                      _checkbox_third = !_checkbox_third;
                    });
                  },
                ),
                Text('이메일 제3자 동의'),
              ],
            ),
            MaterialButton(
                onPressed: () async {
                  if(!_checkbox_email){
                    _showMyDialog("이메일 동의해주세요.");
                  } else if(!_checkbox_coll){
                    _showMyDialog("수집항목 동의해주세요.");
                  } else if(!_checkbox_use){
                    _showMyDialog("이용목 동의해주세요.");
                  } else if(!_checkbox_third){
                    _showMyDialog("이용기간 동의해주세요.");
                  } else {
                    Map data = {"snsType": widget.snsType, "email": widget.email};
                    var join = await _social.joinServer(data);
                    if(join == "Y"){
                      await _showMyDialog("회원가입이 완료되었습니다");
                      Get.to(MyPageView(0));
                    }
                  }
                },
                color: kKakaoColor,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Text('동의후 계속',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

