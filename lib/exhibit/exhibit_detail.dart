import 'dart:async';

import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main/main_view.dart';

class ExhibitDetail extends StatefulWidget {
  @override
  _ExhibitDetailState createState() => _ExhibitDetailState();
}

class _ExhibitDetailState extends State<ExhibitDetail> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    Provider.of<DevicesProvider>(context, listen: false).init();
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<DevicesProvider>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("전시 카테고리1"),
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
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.offAll(MainView());
              },
            )
          ]
      ),
      body: _mainView(context),
      bottomNavigationBar: _bottomButtons(),
    );
  }

  Widget _mainView(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context);
    final _imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0g6e6r-vJ7ov7qryFzHHedU2Jd4s6ueRhDw&usqp=CAU";
    final _text = "고흐는 막 화가일을 시작했을 당시부터 친하게 지내던 폴 고갱과 프랑스의 아를에서 잠시 공동 생활을 한 적이 있었는데, 이 기간 중에 둘의 사이는 점점 멀어지기 시작하며 나중에는 고갱이 고흐에게 돈도 못버는 화가라고 욕을 하고, 고흐는 고갱을 보고 돈만 아는 화가라고 욕할 지경에 다다랐다. 그러던 와중 아를의 카페 주인(마담 지누)을 고흐와 고갱이 전혀 다르게 묘사하자 고갱은 '술집여자일 뿐이다', 고흐는 '그래도 창녀처럼 그리는 것은 아니다'라는 주제로 다투던 와중 자신의 귀를 잘랐는데[1] 그 후 마을에서 정신병자 취급을 받자 생 레미 요양원에서 요양하며 느꼈던 정신적 고통을 소용돌이로 묘사했다고 한다.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 80,
                      height: 30,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 18)))
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('등록 전시물 3', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: (
                        Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    icon: Icon(Icons.filter_center_focus, color: Colors.blue),
                                    onPressed: () {
                                      _device.scan();
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 30,
                                    icon:
                                      _device.isRunning
                                      ? Icon(Icons.bluetooth, color: Colors.blue)
                                      : Icon(Icons.bluetooth_disabled),
                                    onPressed: () {
                                      _device.becaonScan(!_device.isRunning);
                                    },
                                  )
                                ]
                            )
                        )
                    ),
                  )
                ],
              )
          ),
        ),
        Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(_imageUrl, fit: BoxFit.fill)
        ),
        Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.2, color: Colors.grey))
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                          children: [
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.headset_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.thumbs_up_down_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.map_outlined),
                              onPressed: () {},
                            ),
                          ]
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.share),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.language),
                                  onPressed: () {},
                                )
                              ]
                          )
                      )
                  )

                ]
            )
        ),
        Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(_text, textScaleFactor: 1.2,),
                )
            )
        )
      ],
    );
  }

  Widget _bottomButtons() {
    return Container(
        height: 140,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  color: Colors.black
              ),
              Container(
                  height: 80,
                  color: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                    onPressed: () {},
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 60,
                                                height: 25,
                                                margin: EdgeInsets.only(bottom: 2),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(width: 1, color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 15)))
                                            ),
                                            Text('등록 전시물2', style: TextStyle(color: Colors.white))
                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                                textDirection: TextDirection.ltr,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            width: 60,
                                            height: 25,
                                            margin: EdgeInsets.only(bottom: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(width: 1, color: Colors.white),
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 15)))
                                        ),
                                        Text('등록 전시물', style: TextStyle(color: Colors.white))
                                      ]
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                    onPressed: () {},
                                  ),
                                ]
                            )
                        )
                      ]
                  )
              )
            ]
        )
    );
  }
}
