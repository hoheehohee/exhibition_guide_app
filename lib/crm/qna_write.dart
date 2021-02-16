import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class QnaWrite extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;

  MyPageProvider _myPageProvider;
  final myController = TextEditingController();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("알림"),
          content: SingleChildScrollView(child:new Text("문의가 등록되었습니다.")),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Get.to(MyPageView(0));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _myPageProvider = Provider.of<MyPageProvider>(context);
    return  Scaffold(
        backgroundColor: Color(0xffE9E9E9),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(mqd.size.height * 0.07),
            child: CustomDefaultAppbar(title: '고객센터')
        ),
        body: GestureDetector(
          onTap: () {
            // 바깥을 눌렀을 때 keyboard close
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: _title() // 문의글 타이틀
                ),
                Expanded(
                    child: _inputForm() // 입력폼
                )
              ]
          ),
        ),
        bottomNavigationBar: _submitButton(context)  // 문의하기 버튼
    );
  }

  // 문의글 타이틀
  Widget _title() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqw * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/icon/icon-edit.png",
            width: mqw * 0.06,
          ),
          SizedBox(width: mqw * 0.03,),
          Text(
              "문의글 입력",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
          ),
        ],
      ),
    );
  }

  // 입력 폼
  Widget _inputForm() {
    return Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('문의내용', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  maxLines: 30,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "문의하실 내용을 남겨주세요.",
                    border: OutlineInputBorder(),
                  ),
                  controller: myController,
                ),
              )
            ]
        )
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
        width: double.infinity,
        height: mqh * 0.08,
        margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
        // color: Colors.green,
        child: RaisedButton(
          color: Color(0xff293F52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text('문의글 등록', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () async{
            var status = await _myPageProvider.setQna(myController.text);
            if(status == "Y") {
              _showDialog(context);
            }
          },
        )
    );
  }
}
