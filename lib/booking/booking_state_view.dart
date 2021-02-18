import 'package:exhibition_guide_app/booking/booking_detail_view.dart';
import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BookingStateView extends StatefulWidget {
  BookingStateView(this.status);

  final int status;

  @override
  _BookingStateViewState createState() => _BookingStateViewState();
}

class _BookingStateViewState extends State<BookingStateView> {

  MyPageProvider _mypage;
  int status;
  int monthCount = 3;

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
          statusText = "신청";
        }
        break;
      case "C":
        {
          statusText = "취소";
        }
        break;
      case "AC":
        {
          statusText = "관리자취소";
        }
        break;
      case "Y":
        {
          statusText = "승인";
        }
        break;
      case "B":
        {
          statusText = "완료";
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
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: '신청상세정보')
      ),
      body: Container(
        color: Color(0xffE5E6E7),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectForm(),
              _applyItems(),
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
                              {'idx': 3, 'text': '3개월'},
                              {'idx': 6, 'text': '6개월'},
                              {'idx': 9, 'text': '12개월'},
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
                              {'idx': 0, 'text': '전체 신청내역 조회'},
                              {'idx': 1, 'text': '예약신청 내역'},
                              {'idx': 2, 'text': '신청승인 내역'},
                              {'idx': 3, 'text': '이용종료 내역'},
                              {'idx': 4, 'text': '신청취소 내역'},
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
                  Get.to(BookingDetailView());
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
                                                  _showMyDialog("취소되었습니다.");
                                                }else{
                                                  _showMyDialog("취소가 되지 않았습니다.");
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
                                                          child: Text('신청취소', style: TextStyle(color: Color(0xffA58C60))
                                                          )
                                                      )
                                                  )
                                              )
                                          ),
                                          // 신청 상태
                                          Container(
                                              width: 70,
                                              height: 25,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                      getStatusText(_mypage.bookingList.data[index].status),
                                                      style: TextStyle(color: Colors.white)
                                                  )
                                              )
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
                        child: Text(
                          '전체 전시해설, 살성전시실, 전시유물, 기타/기획전',
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
}
