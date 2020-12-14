import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main/main_view.dart';

class BookingCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("이용예약 신청"),
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
                Get.offAll(MainView());
              },
            )
          ]
      ),
      body: _mainView(),
      bottomNavigationBar: _bottomButtons(),
    );
  }

  Widget _mainView() {
    return Column(
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
                        child: Icon(Icons.notifications_outlined, color: Colors.orange)
                    ),
                    Expanded(
                        flex: 1,
                        child: Text('신청정보 확인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    )
                  ]
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text('신청이 완료되었습니다.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('2020.12.24 17:40:13'),
                        SizedBox(height: 30),
                        Icon(Icons.account_balance_outlined, size: 100, color: Colors.black54),
                        Text('M U S E U M'),
                        SizedBox(height: 10),
                        Divider(color: Colors.black45, height: 5),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('예약번호', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                                        Text('20201224-174013', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                      ]
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('이용일시', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                                        Text('2020.13.31 17시', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                      ]
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('신청메모', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.language_outlined, color: Colors.blue),
                                            Padding(
                                                padding: EdgeInsets.only(left: 5, right: 10, bottom: 2),
                                                child: Text('외국인', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                            ),
                                            Icon(Icons.accessible_forward_outlined, color: Colors.orange),
                                            Padding(
                                                padding: EdgeInsets.only(left: 5,bottom: 2),
                                                child: Text('시청각장애인', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                            ),
                                          ],
                                        )
                                      ]
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    child: Text('전시정보', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    child: Text('전체 전시해설, 상설전시실, 전시유물, 기타/기획전시', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                  ),

                                ]
                            )
                        )
                      ]
                  )
              )
          )
        ]
    );
  }

  Widget _bottomButtons() {
    return Container(
        margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(right: 5),
                    child: RaisedButton(
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text('이용신청 완료', style: TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: () {},
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 5),
                    child: RaisedButton(
                      color: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text('신청현황 확인', style: TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: () {},
                    )
                ),
              )
            ]
        )
    );
  }
}
