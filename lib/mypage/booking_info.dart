import 'package:exhibition_guide_app/booking/booking_state_view.dart';
import 'package:exhibition_guide_app/crm/customer_center_view.dart';
import 'package:exhibition_guide_app/model/applyCount_model.dart';
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

  final List<BookingStateMenu> _menuItems = [
    BookingStateMenu.fromMap({ 'title': '전체 신청내역 조회', 'widget': BookingStateView(0) }),
    BookingStateMenu.fromMap({ 'title': '예약신청 내역', 'widget': BookingStateView(1) }),
    BookingStateMenu.fromMap({ 'title': '신청승인 내역', 'widget': BookingStateView(2) }),
    BookingStateMenu.fromMap({ 'title': '이용종료 내역', 'widget': BookingStateView(3) }),
    BookingStateMenu.fromMap({ 'title': '신청취소 내역', 'widget': BookingStateView(4) }),
    BookingStateMenu.fromMap({ 'title': '고객센터', 'widget': CustomerCenterView() }),
  ];

  MyPageProvider _mypage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {Provider.of<MyPageProvider>(context, listen: false).setApplyCount()});
    // Future.microtask(() => {Provider.of<MyPageProvider>(context, listen: false).setApplyCountLatest()});
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _mypage = Provider.of<MyPageProvider>(context);
    // final ApplyCountModel applyCount = _mypage.applyCount;
    // final ApplyCountModel applyCountLatest = _mypage.applyCountLatest;
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
                                    Text('예약신청 0')
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
                                      // Text('예약중 ${applyCount.applyNow}')
                                      Text('예약중 0')
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
                                      // Text('이용종료 ${applyCount.applyEnd}')
                                      Text('이용종료 0')
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
                    height: 100,
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('진행중인 내역', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text('(최근 3개월)', style: TextStyle(fontSize: 16, color: Colors.grey))
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
                                      Text('도슨트\n신청', textAlign: TextAlign.center),
                                      // Text(applyCountLatest.applyCount.toString(), style: TextStyle(color: Colors.orange))
                                      Text('0', style: TextStyle(color: Color(0xffA48C60)))
                                    ]
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text('이용\n예정', textAlign: TextAlign.center),
                                      // Text(applyCountLatest.applyCount.toString(), style: TextStyle(color: Colors.orange))
                                      Text('0', style: TextStyle(color: Color(0xffA48C60)))
                                    ]
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text('이용\n종료', textAlign: TextAlign.center),
                                      // Text(applyCountLatest.applyEnd.toString(), style: TextStyle(color: Colors.orange))
                                      Text('0', style: TextStyle(color: Color(0xffA48C60)))
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
