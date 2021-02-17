import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExhibitionMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    AppLocalizations _locals = AppLocalizations.of(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaQueryData.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.map9)
        ),
        body: Container(
          width: double.infinity,
          color: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            "assets/images/map.png",
            fit: BoxFit.fitHeight,
          ),
        )
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text('전시물 위치', style: TextStyle(color: Colors.white),),
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
