import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
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

  var mqd;
  var mqw;
  var mqh;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: '마이페이지')
      ),
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
                            height: mqh * 0.1,
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
  // 프로필, 신청현황
  Widget _tabBar() {
    return TabBar(
        unselectedLabelColor: Colors.black.withOpacity(0.3),
        indicatorColor: Color(0xffB19664),
        indicatorWeight: mqw * 0.01,
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
