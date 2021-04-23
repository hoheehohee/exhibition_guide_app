import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../util.dart';
import 'booking_modify.dart';

class BookingStateView extends StatefulWidget {
  BookingStateView(this.status);

  final int status;

  @override
  _BookingStateViewState createState() => _BookingStateViewState();
}

class _BookingStateViewState extends State<BookingStateView> {

  MyPageProvider _mypage;
  ExhibitProvider _exhibit;
  int status;
  int monthCount = 3;
  AppLocalizations _locals;

  var mqd;
  var mqw;
  var mqh;

  @override
  void initState() {
    super.initState();
    status = widget.status;
    Future.microtask(() => {
      Provider.of<MyPageProvider>(context, listen: false).setBookingStatListSel(status, monthCount)
    });
  }

  String getStatusText(String status) {
    String statusText = "";
    switch (status) {
      case "N":
        {
          statusText = "assets/images/status/badge-hold.png";
        }
        break;
      case "C":
        {
          statusText = "assets/images/status/badge-cancel.png";
        }
        break;
      case "AC":
        {
          statusText = "assets/images/status/badge-cancel.png";
        }
        break;
      case "Y":
        {
          statusText = "assets/images/status/badge-ok.png";
        }
        break;
      case "B":
        {
          statusText = "assets/images/status/badge-ok2.png";
        }
        break;
    }
    return statusText;
  }

  String getDday(String date) {
      var result = date.split('-');
      final birthday = DateTime(
          int.parse(result[0]), int.parse(result[1]), int.parse(result[2]));
      final now = DateTime.now();
      final difference = now
          .difference(birthday)
          .inDays;
      return "D${difference > 0 ? "+${difference}" : difference}";
  }

  String getType(var date) {
    String types = "";
    types += date.type1 == 'Y' ? _locals.bk28 : "";
    types += date.type2 == 'Y' ? ","+_locals.bk29 : "";
    types += date.type3 == 'Y' ? ","+_locals.bk30 : "";
    types += date.type4 == 'Y' ? ","+_locals.bk31 : "";
    types += date.type5 == 'Y' ? ","+_locals.bk32 : "";
    types += date.type6 == 'Y' ? ","+_locals.bk33 : "";

    if(types == ""){
      types = _locals.etc15;
    }
    return types.substring(0,1) == "," ? types.substring(1,types.length) : types;
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // void reloadData(newStatus) {
  //   setState(() {
  //     Future.microtask(() => {
  //       Provider.of<MyPageProvider>(context, listen: false)
  //           .setBookingStatListSel(newStatus, 0)
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _mypage = Provider.of<MyPageProvider>(context);
    _exhibit = Provider.of<ExhibitProvider>(context);
    _locals = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.etc3)
      ),
      body: Container(
        color: Color(0xffE5E6E7),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectForm(),
              _mypage.bookingList.dataCount == 0 ? _notLogin() : _applyItems(),
        ])
      ),
    );
  }

  Widget _selectForm() {
    return Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: monthCount,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            onChanged: (newValue) {
                              monthCount = newValue;
                              setState(() {
                                monthCount;
                              });
                              Future.microtask(() => {
                                Provider.of<MyPageProvider>(context, listen: false).setBookingStatListSel(status, newValue)
                              });
                            },
                            items: <Map>[
                              {'idx': 3, 'text': _locals.etc4},
                              {'idx': 6, 'text': _locals.etc5},
                              {'idx': 9, 'text': _locals.etc6},
                            ].map((Map value) {
                              return DropdownMenuItem<int>(
                                value: value['idx'],
                                child: Padding(
                                  padding: EdgeInsets.only(left: mqw * 0.02),
                                  child: Text(value['text']),
                                ),
                              );
                            }).toList(),
                          )
                      )
                  )
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: status,
                            // hint: Center(child: Text('국적 선택')),
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            onChanged: (newValue) {
                              status = newValue;
                              setState(() {
                                status;
                                Future.microtask(() => {
                                  Provider.of<MyPageProvider>(context, listen: false).setBookingStatListSel(status, monthCount)
                                });
                              });
                            },
                            items: <Map>[
                              {'idx': 0, 'text': _locals.etc7},
                              {'idx': 1, 'text': _locals.etc8},
                              {'idx': 2, 'text': _locals.etc9},
                              {'idx': 3, 'text': _locals.etc10},
                              {'idx': 4, 'text': _locals.etc11},
                            ].map((Map value) {
                              return DropdownMenuItem<int>(
                                value: value['idx'],
                                child: Center(child: Text(value['text'])),
                              );
                            }).toList(),
                          )
                      )
                  )
              )
            ]
        )
    );
  }

  Widget _applyItems() {
    return Expanded(
        child: ListView.builder(
          itemCount: _mypage != null ? _mypage.bookingList.dataCount : 0,
          itemBuilder: (BuildContext context, int index) => (Container(
              height: 150,
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  if(_mypage.bookingList.data[index].status == "N") {
                    Get.to(BookingModify(_mypage.bookingList.data[index].applyID));
                  } else {
                    Future.microtask(() => {
                      Provider.of<MyPageProvider>(context, listen: false).setBookingStatListSel(status, monthCount)
                    });
                    _exhibit.setBookingDetSelCall(_mypage.bookingList.data[index].applyID);
                  }
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 예약번호
                                Text(
                                    _mypage.bookingList.data[index].applyNumber,
                                    style: TextStyle( color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600)
                                ),
                                Container(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // d-day 날짜
                                          Visibility(
                                              visible: _mypage.bookingList.data[index].status == 'N',
                                              child: Text(
                                                  getDday(_mypage.bookingList.data[index].applyDate),
                                                  style: TextStyle( color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600)
                                              )
                                          ),
                                          GestureDetector(
                                              onTap: () async{
                                                var state = await _mypage.setApplyCancel(_mypage.bookingList.data[index].applyID);
                                                if(state == "Y"){
                                                  g_showMyDialog(_locals.etc12, context);
                                                  Future.microtask(() => {
                                                    Provider.of<MyPageProvider>(context, listen: false).setBookingStatListSel(status, monthCount)
                                                  });
                                                }else{
                                                  g_showMyDialog(_locals.etc13, context);
                                                }
                                              },
                                              // 신청 취소
                                              child: Visibility(
                                                  visible: _mypage.bookingList.data[index].status == 'N',
                                                  child: Container(
                                                      width: 70,
                                                      height: 25,
                                                      margin: EdgeInsets.only(left: 5),
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Color(0xffA58C60), width: 2),
                                                      ),
                                                      child: Center(
                                                          child: Text(_locals.etc17, style: TextStyle(color: Color(0xffA58C60))
                                                          )
                                                      )
                                                  )
                                              )
                                          ),
                                          // 신청 상태
                                          Container(
                                              width: 70,
                                              height: 25,
                                              // margin: EdgeInsets.all(10),
                                              // padding: EdgeInsets.all(3),
                                              // decoration: BoxDecoration(
                                              //   color: Colors.grey,
                                              // ),
                                              child:
                                              Row(
                                              children: [
                                                  Visibility(
                                                    visible: _mypage.bookingList.data[index].status == 'B',
                                                    child: Container(
                                                    width: 70,
                                                    height: 32,
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: Color(0x8A000000),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        _locals.etc20,
                                                        style: TextStyle(color: Colors.white, fontSize: 12, height: 1),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                ),
                                                Visibility(
                                                    visible: _mypage.bookingList.data[index].status == 'C' || _mypage.bookingList.data[index].status == 'AC',
                                                    child: Container(
                                                      width: 70,
                                                      height: 32,
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xffA58C60),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          _locals.etc17,
                                                          style: TextStyle(color: Colors.white, fontSize: 12, height: 1),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Visibility(
                                                    visible: _mypage.bookingList.data[index].status == 'N',
                                                    child: Container(
                                                      width: 70,
                                                      height: 32,
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1F000000),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          _locals.etc18,
                                                          style: TextStyle(color: Colors.black, fontSize: 12, height: 1),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Visibility(
                                                    visible: _mypage.bookingList.data[index].status == 'AC-1',
                                                    child: Container(
                                                      width: 70,
                                                      height: 32,
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          _locals.etc17,
                                                          style: TextStyle(color: Colors.white, fontSize: 12, height: 1),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Visibility(
                                                    visible: _mypage.bookingList.data[index].status == 'Y',
                                                    child: Container(
                                                      width: 70,
                                                      height: 32,
                                                      padding: EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.indigo,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          _locals.etc19,
                                                          style: TextStyle(color: Colors.white, fontSize: 12, height: 1),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ])
                                          )
                                        ]
                                    )
                                )
                              ]
                          )
                      ),
                      // 신청 날짜와 시간
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    _mypage.bookingList.data[index].applyDate,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                                ),
                                SizedBox(width: 10),
                                Image.asset("assets/images/icon/icon-time.png", width: mqw * 0.04,),
                                SizedBox(width: 5),
                                Text(
                                    '${_mypage.bookingList.data[index].applyTime}시',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                                ),
                                SizedBox(width: 5),
                              ]
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(getType(_mypage.bookingList.data[index]),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                      )
                    ]
                ),
              )
            )
          ),
        )
    );
  }

  Widget _notLogin() {
    return Center(
        child: Container(
          height: 150,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Text('조회된 정보가 없습니다.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
            ],
          ),
        )
    );
  }
}
