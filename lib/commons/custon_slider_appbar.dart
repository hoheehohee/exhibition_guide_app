import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSliderAppbar extends StatelessWidget {
  final title;
  final onAction;

  CustomSliderAppbar({
    Key key,
    this.title,
    this.onAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: TextStyle(color: Colors.white),),
      actions:[
        IconButton(
          icon: new Icon(Icons.menu, size: 30, color: Colors.white,),
          onPressed: () {
            onAction();
          },
        ),
      ],
      leading: CustomImageIconBtn(
        px: 15.0,
        iconPath: "assets/images/button/btn-back.png",
        onAction: () {
          if(title == "4F 전시실" || title == "4th Floor" || title == "４Ｆ 展示室" || title == "4F展厅" ){
            Get.back();
          } else if(title == "5F 전시실" || title == "5th Floor" || title == "5Ｆ 展示室" || title == "5F展厅" ){
            Get.back();
          } else {
            Get.offAll(MainView());
          }

        },
      ),
    );
  }
}
