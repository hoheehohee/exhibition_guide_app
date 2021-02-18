import 'package:exhibition_guide_app/booking/booking_state_view.dart';
import 'package:exhibition_guide_app/crm/customer_center_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:exhibition_guide_app/model/booking_model.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BookingInfo extends StatefulWidget {
  @override
  _BookingInfoState createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;

  MyPageProvider _mypage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<MyPageProvider>(context, listen: false).setApplyCount(),
      Provider.of<MyPageProvider>(context, listen: false).setApplyCountLatest()
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _mypage = Provider.of<MyPageProvider>(context);
    _locals = AppLocalizations.of(context);

    final List<BookingStateMenu> _menuItems = [
      BookingStateMenu.fromMap({ 'title': _locals.as10, 'widget': BookingStateView(0) }),
      BookingStateMenu.fromMap({ 'title': _locals.as11, 'widget': BookingStateView(1) }),
      BookingStateMenu.fromMap({ 'title': _locals.as12, 'widget': BookingStateView(2) }),
      BookingStateMenu.fromMap({ 'title': _locals.as13, 'widget': BookingStateView(3) }),
      BookingStateMenu.fromMap({ 'title': _locals.as14, 'widget': BookingStateView(4) }),
      BookingStateMenu.fromMap({ 'title': _locals.as15, 'widget': CustomerCenterView() }),
    ];

    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              height: 80,
                              color: Colors.white,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/icon/icon-note.png", width: mqw * 0.05,),
                                    SizedBox(height: 10),
                                    // Text('예약신청 ${applyCount.applyCount}')
                                    Text("${_locals.as3} ${_mypage.applyCount.applyCount}")
                                  ]
                              )
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {},
                            child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        left: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.3)),
                                        right: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.3))
                                    )
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/icon/icon-comment-picture.png", width: mqw * 0.05,),
                                      SizedBox(height: 10),
                                      Text("${_locals.as4} ${_mypage.applyCount.applyNow}")
                                    ]
                                )
                            )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {},
                            child: Container(
                                height: 80,
                                color: Colors.white,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/icon/icon-picture-ok.png", width: mqw * 0.05,),
                                      SizedBox(height: 10),
                                      Text('${_locals.as5} ${_mypage.applyCount.applyEnd}')
                                    ]
                                )
                            )
                        )
                    ),
                  ]
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.3)),
                    )
                ),
                child: Container(
                    height: 120,
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_locals.as6, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text(_locals.as6a1, style: TextStyle(fontSize: 16, color: Colors.grey))
                              ]
                          ),
                          SizedBox(height: mqh * 0.03),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text(_locals.as7, textAlign: TextAlign.center),
                                      Text(_mypage.applyCountLatest.applyCount.toString(), style: TextStyle(color: Color(0xffA48C60)))
                                    ]
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text(_locals.as8, textAlign: TextAlign.center),
                                      Text(_mypage.applyCountLatest.applyCount.toString(), style: TextStyle(color: Color(0xffA48C60)))
                                    ]
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text(_locals.as9, textAlign: TextAlign.center),
                                      Text(_mypage.applyCountLatest.applyEnd.toString(), style: TextStyle(color: Color(0xffA48C60)))
                                    ]
                                ),
                              ]
                          )
                        ]
                    )
                )
            ),
            Container(
                height: 320,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 18),
                    itemCount: _menuItems.length,
                    itemBuilder: (BuildContext context, int index) => (
                        Material(
                            child: InkWell(
                                onTap: () {
                                  Get.to(
                                    _menuItems[index].widget,
                                    transition: Transition.rightToLeft
                                  );
                                },
                                child: Container(
                                    height: 50,
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
                                    ),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(_menuItems[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                          Image.asset("assets/images/icon/icon-arrow.png", height: mqh * 0.03,)
                                        ]
                                    )
                                )
                            )
                        )
                    )
                )
            )
          ],
        )
    );
  }
}
