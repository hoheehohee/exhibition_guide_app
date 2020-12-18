import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingStateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("신청상세정보"),
          leading: Builder(
              builder: (BuildContext context) => (IconButton(
                  icon: Icon(Icons.arrow_back_ios), onPressed: () {
                    Get.back();
              }))),
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.offAll(
                  MainView(),
                  transition: Transition.fadeIn
                );
              },
            )
          ]),
      body: Container(
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3))),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: '3개월',
                                // hint: Center(child: Text('국적 선택')),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                onChanged: (newValue) {
                                  print('$newValue');
                                },
                                items: <String>[
                                  '3개월',
                                  '6개월',
                                  '1년'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: Text(value)),
                                  );
                                }).toList(),
                              )))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3))),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: '전체 신청내역 조회',
                                // hint: Center(child: Text('국적 선택')),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                onChanged: (newValue) {
                                  print('$newValue');
                                },
                                items: <String>[
                                  '전체 신청내역 조회',
                                  '예약신청 내역',
                                  '신청승인 내역',
                                  '이용종료 내역',
                                  '신청취소 내역'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: Text(value)),
                                  );
                                }).toList(),
                              ))))
                    ])),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) => (Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('20201224-174013',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        Text('D-20',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        Container(
                                            width: 60,
                                            margin: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.orange),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Center(
                                                child: Text('OOOO',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.orange)))),
                                        Container(
                                            width: 60,
                                            margin: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Center(
                                                child: Text('OOOO',
                                                    style: TextStyle(
                                                        color: Colors.white))))
                                      ]))
                                ])),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('2020.12.31',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  Icon(Icons.access_time),
                                  SizedBox(width: 5),
                                  Text('17시',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 5),
                                  Icon(Icons.account_circle)
                                ])),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '전체 전시해설, 살성전시실, 전시유물, 기타/기획전',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        )
                      ]))),
            ))
          ])),
    );
  }
}
