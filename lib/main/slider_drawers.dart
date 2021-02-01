import 'package:exhibition_guide_app/booking/booking_view.dart';
import 'package:exhibition_guide_app/crm/customer_center_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_highlight_view.dart';
import 'package:exhibition_guide_app/exhibit/permanent_exhibit_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/language/language_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_view.dart';

class SliderDrawers extends StatelessWidget {

  final List<Map<String, dynamic>> drawersItemList = [
   { 'title': '하이라이트', 'idx': 0 },
    { 'title': '전시유물', 'idx': 1 },
    { 'title': '성설전시', 'idx': 2 },
    { 'title': '기획전', 'idx': 3 },
    { 'title': '공지사항', 'idx': 4 },
    { 'title': '이용설정', 'idx': 5 },
    { 'title': '이용예약신청', 'idx': 6 },
    { 'title': '마이페이지', 'idx': 7 },
  ];

  @override
  Widget build(BuildContext context) {
    print("MediaQuery.of(context).padding: ${MediaQuery.of(context).padding.top}");

    return ListView(
      padding: EdgeInsets.zero,
      children: drawerItems(context)
    );
  }

  List<Widget> drawerItems(BuildContext context) {
    List<Widget> result = [
      Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
          alignment: Alignment(-1.0, 0.0),
          child: IconButton(
            icon: ImageIcon(
                AssetImage("assets/images/button/btn-back.png"),
                color: Colors.white
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
      )
    ];

    for (var i = 0; i < drawersItemList.length; i++) {
      result.add(
          Container(
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.grey)
                  )
              ),
              child: InkWell(
                onTap: () {
                  switch(drawersItemList[i]["idx"]){
                    case 0: Get.to(ExhibitHighlightView()); break;
                    case 1: Get.to(PermanentExhibitView()); break;
                    case 2: Get.to(ExhibitionMapView()); break;
                    case 3: Get.to(MainView()); break;
                    case 4: Get.to(CustomerCenterView()); break;
                    case 5: Get.to(LanguageView()); break;
                    case 6: Get.to(BookingView()); break;
                    case 7: Get.to(MyPageView(0)); break;
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage("assets/images/menu-dot.png"),
                      color: Color(0xff363636),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                            drawersItemList[i]["title"],
                            style: TextStyle(fontSize: 20, color: Colors.white)
                        )
                    ),
                  ],
                ),
              )
          )
      );
    };
    return result;
  }
}
