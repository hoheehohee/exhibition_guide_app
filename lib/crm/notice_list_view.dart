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
    return Scaffold(
      appBar: AppBar(
          title: Text("공지사항"),
          leading: Builder(
              builder: (BuildContext context) => (
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back();
                      }
                  )
              )
          ),
          actions:[
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.offAll(
                  MainView(),
                  transition: Transition.fadeIn
                );
              },
            )
          ]
      ),
      body: Center(
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
                        Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.notifications_none_outlined, color: Colors.orange)
                        ),
                        Expanded(
                            flex: 1,
                            child: Text('운영시간: 평일 09:00 ~ 18:00 (월요일 제외)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                        )
                      ]
                  )
              )
            ]
        )
      ),
    );
  }
}
