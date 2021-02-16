import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/crm/notice_detail_view.dart';
import 'package:exhibition_guide_app/crm/qna_write.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/model/crm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeListView extends StatefulWidget {

  @override
  _NoticeListViewState createState() => _NoticeListViewState();
}

class _NoticeListViewState extends State<NoticeListView> {

  var mqd;
  var mqw;
  var mqh;

  List<QnA> _data;
  List<QnA> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return QnA(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index',
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = generateItems(8);
  }

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
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: mqh * 0.12,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("### tap");
                      Get.to(NoticeDetailView(1), transition: Transition.fadeIn);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2020-12-04', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff7E7F80))),
                                  SizedBox(height: mqh * 0.01,),
                                  Text(
                                    '[휴관안내] 국립일제강제동원역사관(12,10(목요일) 휴관합니다)',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Image.asset("assets/images/icon/icon-arrow-notice.png", height: mqh * 0.03,)
                          ),
                        ]
                    ),
                  )
              )
            ]
        )
      ),
    );
  }
}
