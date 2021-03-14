import 'dart:convert';

import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:exhibition_guide_app/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ExhibitItems extends StatelessWidget {

  var mqd;
  var mqw;
  var mqh;

  ExhibitProvider _exhibitProv;
  SettingProvider _settingProv;
  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _exhibitProv = Provider.of<ExhibitProvider>(context);
    _settingProv = Provider.of<SettingProvider>(context);
    _locals = AppLocalizations.of(context);

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 18),
      itemCount: _exhibitProv.exhibitAllMenuItems.data.length,
      itemBuilder: (BuildContext context, int index) {
        final data = _exhibitProv.exhibitAllMenuItems.data;
        Map<String, dynamic> type = getExhibitType(data[index].exhibitionType);

        return InkWell(
          onTap: () {
            Get.to(
              ExhibitDetail(data[index].idx, appbarTitle: '전시물 선택',),
            );
          },
          child: Container(
              height: mqh * 0.1,
              padding: EdgeInsets.only(left: mqw * 0.06),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                      visible: data[index].contentsType == 'A',
                      child: Container(
                          width: mqw * 0.13,
                          height: mqh * 0.038,
                          decoration: BoxDecoration(
                              color: Color(0xffAB8B57),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(
                            child: Text(_locals.el5, style: TextStyle(color: Colors.white, fontSize: mqh * 0.02))
                          )
                      ),
                  ),
                  Visibility(
                    visible: data[index].contentsType == 'B',
                    child: Container(
                        width: mqw * 0.13,
                        height: mqh * 0.038,
                        decoration: BoxDecoration(
                            color: Color(0xff13687C),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Center(
                            child: Text(_locals.el3, style: TextStyle(color: Colors.white, fontSize: mqh * 0.02))
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(getTextByLanguage(data[index], 'title', _settingProv.language), style: TextStyle(fontSize: mqh * 0.025, fontWeight: FontWeight.w500))
                  )
                ],
              )
          ),
        );
      }
    );
  }
}
