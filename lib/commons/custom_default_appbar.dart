import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'custom_image_icon_btn.dart';

class CustomDefaultAppbar extends StatelessWidget {
  final String title;

  CustomDefaultAppbar({
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
          Get.back();
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
