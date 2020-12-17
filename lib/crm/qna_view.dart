import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QnaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
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
        ),
        body: Column(
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
                  child: Row(
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
                  )
              ),
              Expanded(
                  child: Container(
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
                                textInputAction: TextInputAction.done,
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
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '문의 제목을 입력해주세요.'
                              ),
                            ),
                          ]
                      )
                  )
              )
            ]
        ),
        bottomNavigationBar: Container(
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
        )
    );
  }
}
