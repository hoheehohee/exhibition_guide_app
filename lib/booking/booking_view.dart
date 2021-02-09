import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import 'booking_check.dart';

class BookingView extends StatefulWidget {
  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  var mqd;
  var mqw;
  var mqh;
  var timeValue = null;
  final time = ['09', '10', '11', '12', '13', '14', '15', '16'];
  final language = ['한국어', '영어', '중국어', '일본어'];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    TextEditingController dateText
    = TextEditingController()..text = DateFormat('yyyy-MM-dd').format(selectedDate);


    return Scaffold(
      appBar: _appBar(),
      // bottomNavigationBar: _bottomBtn(),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mqh * 0.1,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xff858687))),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mqw * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/icon/icon-pen.png",
                        width: mqw * 0.07,
                      ),
                      SizedBox(width: mqw * 0.03,),
                      Text(
                          "예약정보 입력",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)
                      )
                    ],
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.all(mqw * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('이용날짜 선택', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                            cursorColor: Colors.grey,
                            controller: dateText,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "이용할 날짜를 선택하세요",
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: mqh * 0.02,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('이용날짜 선택', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: mqw * 0.03)
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: timeValue,
                              hint: Text('이용시간을 선택하세요.'),
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 20,
                              isExpanded: true,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  timeValue = newValue;
                                });
                              },
                              items: time.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('신청자명', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "신청자명을 입력하세요.",
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('연락처', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "연락처를 입력하세요.",
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('단체명', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "단체명을 입력하세요.",
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('참여인원', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  print(value);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "참여인원을 입력하세요.",
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('외국인구분', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                            color: Colors.white,
                                            child: IconButton(
                                              splashRadius: 20,
                                              icon: Image.asset(
                                                "assets/images/button/btn-radio-on.png"
                                              ),
                                              onPressed: () {},
                                            )
                                        ),
                                        Text('내국인'),
                                      ]
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Material(
                                                color: Colors.white,
                                                child: IconButton(
                                                  splashRadius: 20,
                                                  icon: Image.asset(
                                                      "assets/images/button/btn-radio-off.png"
                                                  ),
                                                  onPressed: () {},
                                                )
                                            ),
                                            Text('외국인'),
                                            Expanded(
                                                flex: 1,
                                                child: DropdownButton<String>(
                                                  hint: Center(child: Text('안내언어')),
                                                  icon: Icon(Icons.keyboard_arrow_down),
                                                  iconSize: 24,
                                                  isExpanded: true,
                                                  onChanged: (newValue) {
                                                    print('$newValue');
                                                  },
                                                  items: language.map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Center(child: Text(value)),
                                                    );
                                                  }).toList(),
                                                )
                                            )
                                          ]
                                      )
                                  )
                                ]
                            ),
                          ],
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('장애여부 구분', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              DropdownButton<String>(
                                hint: Text('장애여부 선택'),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 20,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  print('$newValue');
                                },
                                items: language.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ]
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('신청 대상', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _checkBox(title: "유아", value: 'N'),
                                  _checkBox(title: "초등저학교(1-3)", value: 'N'),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _checkBox(title: "초등저학교(4-6)", value: 'N'),
                                  _checkBox(title: "중학생", value: 'N'),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _checkBox(title: "고등학생", value: 'N'),
                                  _checkBox(title: "성인", value: 'N'),
                                ]
                            )
                          ]
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text('개인정보수지이용 동의', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: EdgeInsets.all(mqw * 0.03),
                              decoration: BoxDecoration(
                                color: Color(0xffE5E6E7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("- 수집항목: [필수] 신청자명, 연락처"),
                                  Text("- 수집 및 이용 목적: 예약신청 연락 정보 확인"),
                                  Text("- 보유 및 이용기간: 예약신청을 위해 이용일후 해당정보를 자동으로 파기합니다.")
                                ],
                              ),
                            )
                          ]
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  splashRadius: 20,
                                  icon: Icon(Icons.check_box_outline_blank),
                                  onPressed: () {
                                    print("### check box value: ");
                                  }
                              ),
                              Text("동의합니다.")
                            ]
                          )
                        ),
                        SizedBox(height: mqh * 0.02,),
                        _bottomBtn(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text("이용예약신청", style: TextStyle(color: Colors.white),),
      leading: CustomImageIconBtn(
        px: 15.0,
        iconPath: "assets/images/button/btn-back.png",
        onAction: () {
          Get.back();
        },
      ),
    );
  }

  Widget _checkBox({title, value}) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.white,
            child: IconButton(
              splashRadius: 20,
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () {
                print("### check box value: $value");
              }
            )
          ),
          Text(title)
        ]
      )
    );
  }

  Widget _bottomBtn() {
    return Container(
      width: double.infinity,
      height: mqh * 0.08,
      // margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
      child: RaisedButton(
        color: Color(0xff293F52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text('이용신청 완료', style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: () {
          Get.to(
              BookingCheck()
          );
        },
      )
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      helpText: '',
      initialDate: selectedDate,
      locale: const Locale('ko', 'KR'),
      cancelText: '취소',
      confirmText: '확인',
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
