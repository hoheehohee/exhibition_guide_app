import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/crm/qna_detail.dart';
import 'package:exhibition_guide_app/crm/qna_write.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:exhibition_guide_app/mypage/faq_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCenterView extends StatefulWidget {

  @override
  _CustomerCenterViewState createState() => _CustomerCenterViewState();
}

class _CustomerCenterViewState extends State<CustomerCenterView> {
  var mqd;
  var mqw;
  var mqh;

  AppLocalizations _locals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _locals = AppLocalizations.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.customer1)
      ),
      body: Container(
        color: Color(0xffE5E6E7),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          width: mqw * 0.06,
                        ),
                        SizedBox(width: mqw * 0.03,),
                        Text(
                            _locals.customer2,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: mqh * 0.005),
                        //   child: Text("(월요일휴관)", style: TextStyle(fontSize: 13)),
                        // )
                      ],
                    ),
                  )
              ),
              Expanded(
                  child:  SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.white,
                                margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/img-man.png", width: mqh * 0.1,),
                                      SizedBox(height: mqh * 0.04),
                                      Text(
                                          _locals.customer3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                                      ),
                                      SizedBox(height: 20),
                                      RaisedButton(
                                        color: Color(0xffA58C60),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Text(_locals.customer4, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                                        onPressed: () {
                                          Get.to(
                                            // QnaWrite(),
                                            QnaDetail(),
                                            transition: Transition.rightToLeft
                                          );
                                        },
                                      )
                                    ]
                                )
                            ),
                            FaqListView()
                          ]
                      )
                  )
              )
            ]
        )
      ),
    );
  }
}
