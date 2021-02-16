import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';

class NoticeDetailView extends StatefulWidget {
  final int noticeIdx;

  NoticeDetailView(this.noticeIdx);

  @override
  _NoticeDetailViewState createState() => _NoticeDetailViewState();
}

class _NoticeDetailViewState extends State<NoticeDetailView> {
  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: '공지사항')
      ),
      body: Container(
        color: Color(0xffE7E8E9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              // height: mqh * 0.15,
              padding: EdgeInsets.all(mqw * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2020-12-04', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff7E7F80))),
                  SizedBox(height: mqh * 0.01,),
                  Text(
                    '[휴관안내] 국립일제강제동원역사관(12,10(목요일) 휴관합니다)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(mqw * 0.05),
                child: Text(
                  '[휴관안내] 국립일제강제동원역사관(12,10(목요일) 휴관합니다)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff7E7F80)),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
