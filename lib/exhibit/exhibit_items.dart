import 'dart:convert';

import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExhibitItems extends StatelessWidget {

  var mqd;
  var mqw;
  var mqh;

  ExhibitProvider _exhibitProv;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _exhibitProv = Provider.of<ExhibitProvider>(context);

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 18),
      itemCount: _exhibitProv.exhibitAllMenuItems.data.length,
      itemBuilder: (BuildContext context, int index) {
        final data = _exhibitProv.exhibitAllMenuItems.data;
        Map<String, dynamic> type = getExhibitType(data[index].exhibitionType);

        return InkWell(
          onTap: () {
            print("##### click: ${data[index].exhibitionCode}");
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
                  Container(
                      width: mqw * 0.13,
                      height: mqh * 0.04,
                      decoration: BoxDecoration(
                          color: Color(type["color"]),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(
                          child: Text(type["title"], style: TextStyle(color: Colors.white, fontSize: mqh * 0.025)))
                  ),
                  SizedBox(width: 10,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(data[index].exhibitionName, style: TextStyle(fontSize: mqh * 0.029, fontWeight: FontWeight.w500))
                  )
                ],
              )
          ),
        );
      }
    );
  }
}
