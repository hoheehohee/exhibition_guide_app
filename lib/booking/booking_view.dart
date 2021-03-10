import 'dart:convert';

import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

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
  AppLocalizations _locals;

  final time = ['09', '10', '11', '12', '13', '14', '15', '16'];

  ExhibitProvider _exhibitProd;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      Provider.of<ExhibitProvider>(context, listen: false).setHolidaySel();
    });
  }

  @override
  void dispose() {
    _exhibitProd.setBookingDataInitial();
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _exhibitProd = Provider.of<ExhibitProvider>(context);
    _locals = AppLocalizations.of(context);

    return Scaffold(
      appBar: _appBar(),
      // bottomNavigationBar: _bottomBtn(),
      body: renderVidew(),
    );
  }

  Widget renderVidew() {
    List<Map<String, String>> language = [
      {'title': _locals.bk19, 'value': 'kor'},
      {'title': _locals.bk20, 'value': 'eng'},
      {'title': _locals.bk21, 'value': 'chn'},
      {'title': _locals.bk22, 'value': 'jpn'},
    ];

    List<Map<String, String>> obstacle = [
      {'title': '없음', 'value': '1'},
      {'title': '시각장애', 'value': '2'},
      {'title': '청각장애', 'value': '3'},
      {'title': '지체장애', 'value': '4'},
      {'title': '기타', 'value': '5'},
    ];

    final bookingData = _exhibitProd.bookingRegData;

    TextEditingController dateText
    = TextEditingController()..text = bookingData.applyDate;

    if (_exhibitProd.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<Map<String, dynamic>> _items = [
      {
        'value': '09',
        'label': '09',
      },
      {
        'value': '10',
        'label': '10',
      },
      {
        'value': '11',
        'label': '11',
      },
      {
        'value': '12',
        'label': '12',
      },
      {
        'value': '13',
        'label': '13',
      },
      {
        'value': '14',
        'label': '14',
      },
      {
        'value': '15',
        'label': '15',
      },
      {
        'value': '16',
        'label': '16',
      }
    ];

    return Container(
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
                            _locals.bk2,
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
                          child: Text(_locals.bk3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                              hintText: _locals.bk4,
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
                          child: Text(_locals.bk5, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: mqw * 0.03)
                            ),
                            // child: DropdownButtonHideUnderline(
                            //   child: DropdownButton<String>(
                            //     value: bookingData.applyTime,
                            //     hint: Text(_locals.bk6),
                            //     icon: Icon(Icons.keyboard_arrow_down),
                            //     iconSize: 20,
                            //     isExpanded: true,
                            //     isDense: true,
                            //     onChanged: (newValue) {
                            //       _exhibitProd.setBookingData('applyTime', newValue);
                            //     },
                            //     items: time.map<DropdownMenuItem<String>>((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // )
                            child: SelectFormField(
                              type: SelectFormFieldType.dropdown, // or can be dialog
                              // initialValue: 'circle',
                              icon: Icon(Icons.access_time),
                              labelText: _locals.bk6,
                              items: _items,
                              onChanged: (val) => {
                                _exhibitProd.setBookingData('applyTime', val)
                              },
                            )
                        ),
                        SizedBox(height: mqh * 0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(_locals.bk7, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  _exhibitProd.setBookingData('name', value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: _locals.bk8,
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
                              child: Text(_locals.bk9, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  _exhibitProd.setBookingData('tel', value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: _locals.bk10,
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
                              child: Text(_locals.bk11, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  _exhibitProd.setBookingData('groupName', value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: _locals.bk12,
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
                              child: Text(_locals.bk13, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            TextField(
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  _exhibitProd.setBookingData('groupPersonnel', value);
                                },
                                // keyboardType: TextInputType.number,
                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: _locals.bk14,
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
                              child: Text(_locals.bk15, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                                bookingData.langType == 'A'
                                                    ? "assets/images/button/btn-radio-on.png"
                                                    : "assets/images/button/btn-radio-off.png",
                                              ),
                                              onPressed: () {
                                                _exhibitProd.setBookingData('langType', 'A');
                                              },
                                            )
                                        ),
                                        Text(_locals.bk16),
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
                                                    bookingData.langType == 'B'
                                                        ? "assets/images/button/btn-radio-on.png"
                                                        : "assets/images/button/btn-radio-off.png",
                                                  ),
                                                  onPressed: () {
                                                    _exhibitProd.setBookingData('langType', 'B');
                                                  },
                                                )
                                            ),
                                            Text(_locals.bk17),
                                            Expanded(
                                                flex: 1,
                                                child: DropdownButton<String>(
                                                  value: bookingData.lang,
                                                  hint: Center(child: Text(_locals.bk18)),
                                                  icon: Icon(Icons.keyboard_arrow_down),
                                                  iconSize: 24,
                                                  isExpanded: true,
                                                  onChanged: (newValue) {
                                                    _exhibitProd.setBookingData('lang', newValue);
                                                  },
                                                  items: language.map((item) {
                                                    return DropdownMenuItem(
                                                      value: item["value"],
                                                      child: Center(child: Text(item["title"])),
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
                                child: Text(_locals.bk23, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              DropdownButton<String>(
                                value: bookingData.obstacle,
                                hint: Text(_locals.bk24),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 20,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  _exhibitProd.setBookingData('obstacle', newValue);
                                },
                                items: obstacle.map((item) {
                                  return DropdownMenuItem(
                                    value: item["value"],
                                    child: Text(item["title"]),
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
                                child: Text(_locals.bk27, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _checkBox(title: _locals.bk28, value: "type1"),
                                    _checkBox(title: _locals.bk29, value: "type2"),
                                  ]
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _checkBox(title: _locals.bk30, value: "type3"),
                                    _checkBox(title: _locals.bk31, value: "type4"),
                                  ]
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _checkBox(title: _locals.bk32, value: "type5"),
                                    _checkBox(title: _locals.bk33, value: "type6"),
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
                                child: Text(_locals.bk34, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                    Text("- ${_locals.bk35}"),
                                    Text("- ${_locals.bk36}"),
                                    Text("- ${_locals.bk37}")
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
                                      icon: _exhibitProd.isConsent
                                          ? Icon(Icons.check_box, color: Color(0xffAD8C59))
                                          : Icon(Icons.check_box_outline_blank,),
                                      onPressed: () {
                                        _exhibitProd.setBookingData('isConsent', !_exhibitProd.isConsent);
                                      }
                                  ),
                                  Text(_locals.bk38)
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
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(_locals.bk1, style: TextStyle(color: Colors.white),),
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
    final temp = _exhibitProd.bookingRegData.toJson()[value];
    final v = temp == null || temp == 'N' ? 'Y' : 'N';

    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.white,
            child: IconButton(
              splashRadius: 20,
              icon: temp == 'Y'
                ? Icon(Icons.check_box, color: Color(0xffAD8C59))
                : Icon(Icons.check_box_outline_blank,),
              onPressed: () {
                _exhibitProd.setBookingData(value, v);
              }
            )
          ),
          Expanded(child: Text(title, overflow: TextOverflow.ellipsis,))
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
        child: Text(_locals.bk39, style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: () {
          final result = bookingCheck(_exhibitProd.bookingRegData);
          if (result != "") {
            _customDialog(result);
          } else if (!_exhibitProd.isConsent) {
            _customDialog("개인정보수집이용에 동의해주세요");
          } else {
            _exhibitProd.setBookingRegCall();
          }
        },
      )
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      helpText: '',
      locale: const Locale('ko', 'KR'),
      cancelText: '취소',
      confirmText: '확인',
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      selectableDayPredicate: (DateTime val) {
        // return val.day != 19 ? false : true;
        List<dynamic> temp = [];
        _exhibitProd.holiday.forEach((element) {
          String yyyyMM = DateFormat('yyyyMM').format(val);
          element.forEach((k, v) {
            if (k == yyyyMM) temp = v;
          });
        });

        return temp.contains(val.day);
      },
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },

    );

    if (picked != null && picked != selectedDate) {
      String nowD = DateFormat('yyyyMMdd').format(DateTime.now());
      String selDay = DateFormat('yyyyMMdd').format(picked);
      if (nowD == selDay) {
        _customDialog("오늘날짜 선택은 불가능합니다.");
      } else {
        _exhibitProd.setBookingData('applyDate', DateFormat('yyyy-MM-dd').format(picked));
      }
    }
  }

  void _customDialog(String result) {
    Get.defaultDialog(
      title: "알림",
      titleStyle: TextStyle(),
      middleText: result,
      confirm: FlatButton(
          minWidth: double.infinity,
          onPressed: () {
            Get.back();
          },
          child: RaisedButton(
            color: Color(0xff293F52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text("확인", style: TextStyle(fontSize: 18, color: Colors.white)),
          )
      ),
    );
  }
}
