import 'package:exhibition_guide_app/booking/booking_view.dart';
import 'package:exhibition_guide_app/crm/notice_list_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_highlight_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_list_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_theme_view.dart';
import 'package:exhibition_guide_app/setting/language_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:exhibition_guide_app/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../util.dart';
import 'main_view.dart';

class SliderDrawers extends StatelessWidget {
  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    _locals = AppLocalizations.of(context);

    return ListView(
      padding: EdgeInsets.zero,
      children: drawerItems(context)
    );
  }

  List<Widget> drawerItems(BuildContext context) {

    final List<Map<String, dynamic>> drawersItemList = [
      { 'title': _locals.menu1, 'idx': 0 },
      { 'title': _locals.menu2, 'idx': 1 },
      { 'title': _locals.menu3, 'idx': 2 },
      { 'title': _locals.menu4, 'idx': 3 },
      { 'title': _locals.main6, 'idx': 4 },
      { 'title': _locals.main7, 'idx': 5 },
      { 'title': _locals.menu5, 'idx': 6 },
      { 'title': _locals.menu6, 'idx': 7 },
      { 'title': _locals.etc1, 'idx': 8 },
      { 'title': _locals.menu7, 'idx': 9 },
      { 'title': _locals.menu8, 'idx': 10 },
    ];

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
                onTap: () async{
                  switch(drawersItemList[i]["idx"]){
                    case 0: Get.to(ExhibitHighlightView()); break;
                    case 1:
                      Get.offAll(ExhibitListView(
                        appBarTitle: "전시유물",
                        contentType: 'B',
                        contentTitle: "전시유물",
                        exhibitionType: 'A',
                        contentIconPath: "assets/images/icon/icon-main-relics.png",
                      ));
                      break;
                    case 2:
                      Get.offAll(ExhibitListView(
                        appBarTitle: "상설전시",
                        contentType: 'A',
                        contentTitle: "상설전시",
                        exhibitionType: 'A',
                        contentIconPath: "assets/images/icon/icon-main-sangsul.png",
                      ));
                      break;
                    case 3:
                      Get.offAll(ExhibitListView(
                        appBarTitle: "기획전시",
                        contentType: "",
                        contentTitle: "",
                        exhibitionType: 'B',
                        contentIconPath: "",
                      ));
                      break;
                    case 4:
                      Get.offAll(
                          ExhibitThemeView(
                            appBarTitle: "4F 전시실",
                            location: 'A',
                          )
                      );
                      break;
                    case 5:
                      Get.to(
                          ExhibitThemeView(
                            appBarTitle: _locals.main7,
                            location: 'B',
                          )
                      );
                      break;
                    case 6: Get.to(NoticeListView()); break;
                    case 7: Get.to(SettingView()); break;
                    case 8: Get.to(LanguageView()); break;
                    case 9:
                      if(!await isLogin()){
                          g_showMyDialog(_locals.alert1, context);
                      } else {
                          Get.to(BookingView());
                      }
                      break;
                    case 10: Get.to(MyPageView(0)); break;
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
