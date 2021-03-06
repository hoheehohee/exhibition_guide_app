import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  AppLocalizations _locals;
  final myController = TextEditingController();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_locals.etc29),
          content: SingleChildScrollView(child:new Text(_locals.etc31)),
          actions: <Widget>[
            new FlatButton(
              child: new Text(_locals.etc30),
              onPressed: () {
                Get.off(MyPageView(0));
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
    _locals = AppLocalizations.of(context);

    return  Scaffold(
        backgroundColor: Color(0xffE9E9E9),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(mqd.size.height * 0.07),
            child: CustomDefaultAppbar(title: _locals.customer1)
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
                    child: _inputForm(context) // 입력폼
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
              _locals.qna2,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
          ),
        ],
      ),
    );
  }

  // 입력 폼
  Widget _inputForm(BuildContext context) {
    return Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(_locals.qna3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_locals.qna3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  RaisedButton(
                    color: Color(0xff293F52),
                    child: Text(_locals.etc32, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () async{
                      var status = await _myPageProvider.setQna(myController.text);
                      if(status == "Y") {
                        _showDialog(context);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  maxLines: 30,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: _locals.qna4,
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
          child: Text(_locals.qna5, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
