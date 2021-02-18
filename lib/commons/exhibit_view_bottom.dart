import 'package:exhibition_guide_app/guide/exhibition_directions_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant.dart';
import 'custom_image_icon_btn.dart';

class ExhibitViewBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context);
    final _locals = AppLocalizations.of(context);
    return Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: double.infinity,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_locals.hr2, style: TextStyle(fontSize: 14, color: Colors.white)),
                        SizedBox(width: 5,),
                        CustomImageIconBtn(
                          px: 50.0,
                          iconPath: "assets/images/toogle-main-on.png",
                          onAction: () {},
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_locals.hr3, style: TextStyle(fontSize: 14, color: Colors.white), overflow: TextOverflow.ellipsis,),
                        SizedBox(width: 5,),
                        CustomImageIconBtn(
                          px: 50.0,
                          iconPath: "assets/images/toogle-main-on.png",
                          onAction: () {},
                        )
                      ],
                    ),
                  ],
                )
            ),
            Container(
                height: 70,
                color: backgroundColor,
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _bottomBtn(
                        title: 'QR코드',
                        iconPath: 'assets/images/icon/icon-qrcode.png',
                        onTapFunc: () {
                          _device.scan();
                        },
                      ),
                      _bottomBtn(
                        title: _locals.hr1,
                        iconPath: 'assets/images/icon/icon-map.png',
                        onTapFunc: () {
                          Get.to(ExhibitionMapView());
                        },
                      ),
                      _bottomBtn(
                        title: _locals.main10,
                        iconPath: 'assets/images/icon/icon-notice.png',
                        onTapFunc: () {},
                      ),
                    ]
                )
            )
          ],
        )
    );
  }

  Widget _bottomBtn({ title, iconPath, onTapFunc }) {
    return Container(
      width: 80,
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (onTapFunc != null) onTapFunc();
            },
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconPath, color: Colors.white, height: 28,),
                Text(title, style: TextStyle(color: Colors.white))
              ],
            ),
          )
      ),
    );
  }
}
