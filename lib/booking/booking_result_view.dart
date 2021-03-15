import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/model/booking_reg_model.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../util.dart';
import 'booking_state_view.dart';

class BookingResultView extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;
  ExhibitProvider _exhibitProv;
  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _exhibitProv = Provider.of<ExhibitProvider>(context);
    _locals = AppLocalizations.of(context);
    BookingRegModel bd = _exhibitProv.bookingRegData;

    return Scaffold(
      backgroundColor: Color(0xffE1E2E3),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.menu7)
      ),
      bottomNavigationBar: _bottomBtn(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: mqh * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xff858687))),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mqw * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icon/icon-alarm.png",
                          width: mqw * 0.07,
                        ),
                        SizedBox(width: mqw * 0.03,),
                        Text(
                            _locals.apply1,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)
                        )
                      ],
                    ),
                  )
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.all(mqw * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: mqh * 0.04,),
                        Text(_locals.apply2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: mqh * 0.01,),
                        Text(
                          DateFormat('yyyy.MM.dd HH:mm:ss').format(DateTime.now())
                        ),
                        SizedBox(height: mqh * 0.03,),
                        Image.asset(
                          "assets/images/ok-logo.png",
                          width: mqw * 0.4,
                        ),
                        SizedBox(height: mqh * 0.03,),
                        Divider(color: Color(0xff858687),),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            "assets/images/img-back.png",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(mqw * 0.03),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                _bookingInfoItem(title: _locals.apply3, value: bd.applyNumber),
                                _bookingInfoItem(
                                    title: _locals.apply4,
                                    value: "${getValue(bd.applyDate)} ${getValue(bd.applyTime)}시"
                                ),
                                _bookingInfoItem(
                                    title: _locals.apply5,
                                    value: getValue(bd.name, nullString: "-")
                                ),
                                _bookingInfoItem(
                                    title: _locals.bk9,
                                    value: getValue(bd.tel, nullString: "-")
                                ),
                                _bookingInfoItem(
                                  title: _locals.apply6,
                                  value: getValue(bd.groupName,  nullString: "-"),
                                ),
                                _bookingInfoItem(
                                    title: _locals.apply7,
                                    value: getValue(bd.groupPersonnel, nullString: '0명')
                                ),
                                _bookingInfoItem(
                                  title: _locals.apply8,
                                  value: bd.langType == "B" ? _locals.bk17 : _locals.bk16,
                                  imgIcon: "assets/images/icon/icon-foreigner.png"
                                ),
                                _bookingInfoItem(
                                  title: _locals.apply9,
                                  value: obstacleStatus(bd.obstacle),
                                  imgIcon: "assets/images/icon/icon-obstacle.png"
                                ),
                                Text(_locals.apply10, style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                                Text(applyType(bd), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                              ]
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]
          )
        )
    );
  }

  Widget _bookingInfoItem({ title, value, imgIcon }) {
    return Padding(
      padding: EdgeInsets.only(bottom: mqh * 0.02),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
            imgIcon == null
              ? Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
              : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imgIcon != null ? Image.asset(imgIcon, width: mqw * 0.04,) : Container(),
                  Padding(
                    padding: EdgeInsets.only(left: mqw * 0.005, top: mqw * 0.005),
                    child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  )
                ],
              )
          ]
      ),
    );
  }

  Widget _bottomBtn() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: mqh * 0.08,
              margin: EdgeInsets.symmetric(horizontal: mqw * 0.02, vertical: mqh * 0.02),
              child: RaisedButton(
                color: Color(0xff293F52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(_locals.apply11, style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  Get.offAll(MainView());
                },
              ),
            )
          ),
          Expanded(
              child: Container(
                height: mqh * 0.08,
                margin: EdgeInsets.symmetric(horizontal: mqw * 0.02, vertical: mqh * 0.02),
                child: RaisedButton(
                  color: Color(0xff595A5B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(_locals.apply12, style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    Get.to(BookingStateView(0));
                  },
                ),
              )
          ),
        ],
      );
  }
}
