import 'package:exhibition_guide_app/crm/notice_list_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant.dart';
import 'custom_image_icon_btn.dart';

class ExhibitViewBottom extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    final DevicesProvider _deviceProv = Provider.of<DevicesProvider>(context);
    final AppLocalizations _locals = AppLocalizations.of(context);

    return Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: double.infinity,
                color: Colors.black,
                padding: EdgeInsets.only(left: mqw * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_locals.hr2, style: TextStyle(fontSize: 14, color: Colors.white)),
                        SizedBox(width: 5,),
                        CustomImageIconBtn(
                          px: 50.0,
                          iconPath: (
                            _deviceProv.isRunning
                              ? 'assets/images/toogle-main-on.png'
                              : 'assets/images/toogle-main-off.png'
                          ),
                          onAction: () {
                            _deviceProv.becaonScan(!_deviceProv.isRunning);
                            _deviceProv.setAutoPlayAudio(!_deviceProv.autoPlayAudio);
                          },
                        )
                      ],
                    ),
                    // SizedBox(width: 20,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(_locals.hr3, style: TextStyle(fontSize: 14, color: Colors.white), overflow: TextOverflow.ellipsis,),
                    //     SizedBox(width: 5,),
                    //     CustomImageIconBtn(
                    //       px: 50.0,
                    //       iconPath: (
                    //         _deviceProv.autoPlayAudio
                    //           ? 'assets/images/toogle-main-on.png'
                    //           : 'assets/images/toogle-main-off.png'
                    //       ),
                    //       onAction: () {
                    //         _deviceProv.setAutoPlayAudio(!_deviceProv.autoPlayAudio);
                    //       },
                    //     )
                    //   ],
                    // ),
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
                          _deviceProv.scan();
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
                        onTapFunc: () {
                          Get.to(NoticeListView());
                        },
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
                SizedBox(height: 1,),
                Text(title, style: TextStyle(color: Colors.white))
              ],
            ),
          )
      ),
    );
  }
}
