import 'dart:async';

import 'package:exhibition_guide_app/exhibit/exhibit_video_view.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
        () => Get.offAll(MainView())
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffDFE2E9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Image.asset(
                      "assets/images/splash_logo.png",
                      fit: BoxFit.fill
                  ),
                )
              ],
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/splash_bottom_logo.png",
                fit: BoxFit.fill,
              ),
            ],
          )
        ],
      )
    );
  }
}
