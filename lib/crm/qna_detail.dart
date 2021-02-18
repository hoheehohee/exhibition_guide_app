import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QnaDetail extends StatefulWidget {
  @override
  _QnaDetailState createState() => _QnaDetailState();
}

class _QnaDetailState extends State<QnaDetail> {
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _locals = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0xffEAEBEC),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.qna6)
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mqh * 0.1,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: mqw * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_locals.qna7, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text("2020-12-04")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(mqw * 0.05),
              child: Text("이용예약을 12월 18일 신청하였는데 승인이 안되어서 물어봅니다.\n언제뜸 승인나는지요"),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  height: mqh * 0.55,
                  margin: EdgeInsets.symmetric(horizontal: mqw * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(mqw * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/reply-logo.png", width: mqw * 0.2,),
                            SizedBox(width: mqw * 0.03,),
                            Expanded(
                              child: Text(_locals.qna8, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                            ),
                            Text("2020-12-04")
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      Padding(
                        padding: EdgeInsets.all(mqh * 0.03),
                        child: Text("가나다라마바사 아차카타파하"),
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
