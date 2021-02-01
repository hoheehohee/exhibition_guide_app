import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:exhibition_guide_app/booking/booking_view.dart';
import 'package:exhibition_guide_app/crm/customer_center_view.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_highlight_view.dart';
import 'package:exhibition_guide_app/exhibit/permanent_exhibit_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/language/language_view.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../menu.dart';

class SliderDrawers {
  int selectedMenuItemId = 0;
  DrawerScaffoldController controller = DrawerScaffoldController();

  @override
  Widget build(BuildContext context) {
    return _sideDrawer();
  }

  Widget _sideDrawer() {
    return SideDrawer(
      headerView: Container(
          alignment: Alignment(-0.6, 0.0),
          child: IconButton(
            icon: ImageIcon(
                AssetImage("assets/images/button/btn-back.png"),
                color: Colors.white
            ),
            onPressed: () {
              controller.closeDrawer(Direction.right);
            },
          )
      ),
      itemBuilder: (BuildContext context, MenuItem menuItem, bool isSelected) {
        if (menuItem.id == 0) return Container();
        return Container(
            height: 60,
            key: GlobalKey(),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.grey)
                )
            ),
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
                        menuItem.title,
                        style: TextStyle(fontSize: 20, color: Colors.white)
                    )
                ),
              ],
            )
        );
      },
      percentage: 1,
      menu: menu,
      animation: false,
      direction: Direction.right,
      alignment: Alignment.topRight,
      color: Color(0xff1C1C1C),
      selectedItemId: selectedMenuItemId,
      textStyle: TextStyle(color: Colors.white, fontSize: 24.0),
      onMenuItemSelected: (itemId) {
        // setState(() {
        //   selectedMenuItemId = itemId;
          switch(itemId){
          // case 0: Get.to(ExhibitInfoView()); break;
            case 1: Get.off(ExhibitHighlightView()); break;
            case 2: Get.to(PermanentExhibitView()); break;
            case 3: Get.to(ExhibitionMapView()); break;
            case 4: Get.to(CustomerCenterView()); break;
            case 5: Get.to(LanguageView()); break;
            case 6: Get.to(BookingView()); break;
            case 7: Get.to(MyPageView(0)); break;
          }
        // });
      },
    );
  }
}
