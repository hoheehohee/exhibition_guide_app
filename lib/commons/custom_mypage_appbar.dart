import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'custom_image_icon_btn.dart';

class CustomMypageAppbar extends StatelessWidget {
  final String title;

  CustomMypageAppbar({
    Key key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: TextStyle(color: Colors.white),),
      leading: CustomImageIconBtn(
        px: 15.0,
        iconPath: "assets/images/button/btn-back.png",
        onAction: () {
          Get.to(MainView());
        },
      ),
      actions:[
        CustomImageIconBtn(
          px: 25.0,
          iconPath: "assets/images/button/btn-home.png",
          onAction: () {
            Get.offAll(MainView());
          },
        ),
      ],
    );
  }
}
