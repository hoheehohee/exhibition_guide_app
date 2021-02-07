import 'package:exhibition_guide_app/main/main_view.dart';
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

  @override
  void initState() {
    super.initState();
    status = widget.status;
    Future.microtask(() => {
          Provider.of<MyPageProvider>(context, listen: false)
              .setBookingStatListSel(status)
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
    final difference = now.difference(birthday).inDays;
    return "D${difference > 0 ? "+${difference}" : difference}";
  }

  @override
  Widget build(BuildContext context) {
    _mypage = Provider.of<MyPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("신청상세정보"),
          leading: Builder(
              builder: (BuildContext context) => (IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  }))),
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.offAll(MainView(), transition: Transition.fadeIn);
              },
            )
          ]),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
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
                                  child: DropdownButton<String>(
                                value: '3개월',
                                // hint: Center(child: Text('국적 선택')),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                onChanged: (newValue) {
                                  print('$newValue');
                                },
                                items: <String>[
                                  '3개월',
                                  '6개월',
                                  '1년'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: Text(value)),
                                  );
                                }).toList(),
                              )))),
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
                                value: status,
                                // hint: Center(child: Text('국적 선택')),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    status = newValue;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookingStateView(newValue)),
                                    );
                                  });
                                },
                                items: <Map>[
                                  {'idx':0, 'text':'전체 신청내역 조회'},
                                  {'idx':1, 'text':'예약신청 내역'},
                                  {'idx':2, 'text':'신청승인 내역'},
                                  {'idx':3, 'text':'이용종료 내역'},
                                  {'idx':4, 'text':'신청취소 내역'},
                                ].map((Map value) {
                                  return DropdownMenuItem<int>(
                                    value: value['idx'],
                                    child: Center(child: Text(value['text'])),
                                  );
                                }).toList(),
                              ))))
                    ])),
            Expanded(
                child: ListView.builder(
              itemCount: _mypage.bookingList.bookingCount,
              itemBuilder: (BuildContext context, int index) => (Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.3)))),
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(_mypage.bookingList.data[index].applyNumber,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        Visibility(
                                            visible: _mypage.bookingList.data[index].status == 'N',
                                            child: Text(
                                                getDday(_mypage.bookingList
                                                    .data[index].applyDate),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Visibility(
                                            visible: _mypage.bookingList
                                                    .data[index].status ==
                                                'N',
                                            child: Container(
                                                width: 60,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.orange),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30))),
                                                child: Center(
                                                    child: Text('신청취소',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .orange))))),
                                        Container(
                                            width: 70,
                                            margin: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Center(
                                                child: Text(getStatusText(_mypage.bookingList.data[index].status),
                                                    style: TextStyle(
                                                        color: Colors.white))))
                                      ]))
                                ])),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      _mypage.bookingList.data[index].applyDate,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  Icon(Icons.access_time),
                                  SizedBox(width: 5),
                                  Text(
                                      '${_mypage.bookingList.data[index].applyTime}시',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 5),
                                ])),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '전체 전시해설, 살성전시실, 전시유물, 기타/기획전',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        )
                      ]))),
            ))
          ])),
    );
  }
}
