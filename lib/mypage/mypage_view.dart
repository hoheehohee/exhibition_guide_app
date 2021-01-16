import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/mypage/profile_vilew.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'booking_info.dart';

class MyPageView extends StatefulWidget {
  MyPageView(this.tabIndex);
  final int tabIndex;
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int tabIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
          child: Container(
              color: Colors.white,
              child: DefaultTabController(
                  length: 2,
                  initialIndex: tabIndex,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.5,
                                        color: Colors.grey.withOpacity(0.3)))),
                            child: _tabBar()  // 프로필, 신청현황
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: tabIndex == 0
                                    ? ProfileView() // 프로필
                                    : BookingInfo() // 신청현황
                            ))
                      ])))),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: Text("마이페이지"),
        leading: Builder(
            builder: (BuildContext context) => (IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: () {
              Get.back();
            }))),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
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

  // 프로필, 신청현황
  Widget _tabBar() {
    return TabBar(
        unselectedLabelColor:
        Colors.black.withOpacity(0.3),
        indicatorColor: Colors.orange,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        tabs: [
          Center(
              child: Text("프로필",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700))),
          Center(
              child: Text("신청현황",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700))),
        ]
    );
  }
}
