import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class QnaView extends StatelessWidget {
  MyPageProvider _myPageProvider;
  @override
  Widget build(BuildContext context) {
    _myPageProvider = Provider.of<MyPageProvider>(context);
    return  Scaffold(
        appBar: _appBar(),
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
        bottomNavigationBar: _submitButton()  // 문의하기 버튼
    );
  }

  Widget _appBar() {
    return AppBar(
        title: Text("1:1 문의하기"),
        leading: Builder(
            builder: (BuildContext context) => (
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    }
                )
            )
        ),
        actions:[
          IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () {
              Get.offAll(
                  MainView(),
                  transition: Transition.fadeIn
              );
            },
          )
        ]
    );
  }

  // 문의글 타이틀
  Widget _title() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.comment, color: Colors.orange)
          ),
          Expanded(
              flex: 1,
              child: Text('문의글 입력', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          )
        ]
    );
  }

  // 입력 폼
  Widget _inputForm() {
    TextEditingController myController
      = TextEditingController()..text = _myPageProvider.imageName;

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
                ),
              ),
              SizedBox(height: 15),
              Text('첨부파일', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                controller: myController,
                readOnly: true,
                onTap: () {
                  _myPageProvider.getImage();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '사진만 업로드 가능합니다.'
                ),
              ),
            ]
        )
    );
  }

  Widget _submitButton() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
        // color: Colors.green,
        child: RaisedButton(
          color: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text('문의하기', style: TextStyle(fontSize: 18, color: Colors.white)),
          onPressed: () {},
        )
    );
  }
}
