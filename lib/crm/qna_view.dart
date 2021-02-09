import 'dart:async';

import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../main/main_view.dart';

class QnaDetail extends StatefulWidget {
  final int idx;
  QnaDetail(this.idx);

  @override
  _QnaDetailState createState() => _QnaDetailState();
}

class _QnaDetailState extends State<QnaDetail> with WidgetsBindingObserver {
  var _qna;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
      Provider.of<MyPageProvider>(context, listen: false).getQna(widget.idx)
    });
  }


  @override
  Widget build(BuildContext context) {
    _qna = Provider.of<MyPageProvider>(context);
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
              Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: _question() // 문의글 타이틀
              ),
              _qna.getValue("answers") == null ? Container():_answer()
            ]
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: Text("문의글 상세보기"),
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
          Expanded(
              flex: 1,
              child: Text('나의 문의글 내용', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal))
          ),
          Expanded(
              flex: 1,
              child: Text(DateFormat('yyyy. MM. dd').format(DateFormat('yyyy-MM-dd').parse(_qna.getValue("questionsDate"))), style: TextStyle(fontSize: 16), textAlign: TextAlign.right,)
          )
        ]
    );
  }

  // 문의글 타이틀
  Widget _question() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Text(_qna.getValue("questions"), style: TextStyle(fontSize: 20))
          )
        ]
    );
  }

  // 문의글 타이틀
  Widget _answer() {
    return Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white)),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(_qna.getValue("answers"), style: TextStyle(fontSize: 20))
                ),
                Expanded(
                    flex: 1,
                    child: Text(DateFormat('yyyy. MM. dd').format(DateFormat('yyyy-MM-dd').parse(_qna.getValue("answerDate"))), style: TextStyle(fontSize: 16), textAlign: TextAlign.right,)
                )
              ]
          )// 문의글 타이틀
      );
  }

}
