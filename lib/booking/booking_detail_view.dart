import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';

class BookingDetailView extends StatefulWidget {
  @override
  _BookingDetailViewState createState() => _BookingDetailViewState();
}

class _BookingDetailViewState extends State<BookingDetailView> {
  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: '이용예역 신청')
      ),
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
                          "2020-12-04 17:00",
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
                              _bookingInfoItem(title: "예약번호", value: "?????"),
                              _bookingInfoItem(
                                title: "이용일시",
                                // value: "${getValue(bd.applyDate)} ${getValue(bd.applyTime)}시"
                                value: '-',
                              ),
                              _bookingInfoItem(
                                title: "신청자명",
                                // value: getValue(bd.name, nullString: "-")
                                value: '-',
                              ),
                              _bookingInfoItem(
                                title: "연락처",
                                // value: getValue(bd.tel, nullString: "-")
                                value: '-',
                              ),
                              _bookingInfoItem(
                                title: '단체명',
                                // value: getValue(bd.groupName,  nullString: "-"),
                                value: '-',
                              ),
                              _bookingInfoItem(
                                title: '참여인원',
                                // value: getValue(bd.groupName, nullString: '0명')
                                value: '-',
                              ),
                              _bookingInfoItem(
                                title: '외국인 구분',
                                // value: bd.langType == "B" ? "외국인" : "내국인",
                                value: '-',
                                imgIcon: "assets/images/icon/icon-foreigner.png"
                              ),
                              _bookingInfoItem(
                                title: "장애여부 구분",
                                // value: obstacleStatus(bd.obstacle),
                                value: '-',
                                imgIcon: "assets/images/icon/icon-obstacle.png"
                              ),
                              Text("신청대상", style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700)),
                              // Text(applyType(bd), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                              Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                            ]
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookingInfoItem({ title, value, imgIcon }) {
    return Padding(
      padding: EdgeInsets.only(bottom: mqh * 0.03),
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
}
