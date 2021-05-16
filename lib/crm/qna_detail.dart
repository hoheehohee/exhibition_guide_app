import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QnaDetailView extends StatefulWidget {
  final int idx;
  QnaDetailView(this.idx);

  @override
  _QnaDetailState createState() => _QnaDetailState();
}

class _QnaDetailState extends State<QnaDetailView> {
  var mqd;
  var mqw;
  var mqh;
  var _qna;
  AppLocalizations _locals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<MyPageProvider>(context, listen: false).getQna(widget.idx)
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _qna = Provider.of<MyPageProvider>(context);
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
                  Text(DateFormat('yyyy. MM. dd').format(DateFormat('yyyy-MM-dd').parse(_qna.getValue("questionsDate"))), style: TextStyle(fontSize: 16), textAlign: TextAlign.right,)
                ],
              ),
            ),

            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(mqw * 0.05),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(_qna.getValue("questions"), style: TextStyle(fontSize: 20)),
                  )
              ),
              flex: 1,
            ),
            _qna.getValue("answers") == null
            ? (
                Container()
            ) : (
              Expanded(
                flex: 2,
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
                              Text(DateFormat('yyyy. MM. dd').format(DateFormat('yyyy-MM-dd').parse(_qna.getValue("answerDate"))), style: TextStyle(fontSize: 16), textAlign: TextAlign.right,)
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey,),
                        Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.all(mqh * 0.03),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(_qna.getValue("answers"), style: TextStyle(fontSize: 20))
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ),

          ],
        ),
      )
    );
  }
}
