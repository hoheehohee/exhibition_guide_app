import 'package:exhibition_guide_app/crm/qna_write.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/model/crm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCenterView extends StatefulWidget {

  @override
  _CustomerCenterViewState createState() => _CustomerCenterViewState();
}

class _CustomerCenterViewState extends State<CustomerCenterView> {
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
          title: Text("1:1 문의하기"),
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
                                margin: EdgeInsets.only(top: 13, bottom: 10, left: 10, right: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.account_balance_outlined, color: Colors.grey, size: 80),
                                      Text('M U S E U M'),
                                      SizedBox(height: 12),
                                      Text(
                                          '코로나19로 인해 고객센터를 잠정적으로\n축소하여 운영 중이오니, 너른 양해부탁드립니다.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16)
                                      ),
                                      SizedBox(height: 20),
                                      RaisedButton(
                                        color: Colors.orange,
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Text('1:1문의하기', style: TextStyle(fontSize: 18, color: Colors.white)),
                                        onPressed: () {
                                          Get.to(
                                            QnaWrite(),
                                            transition: Transition.rightToLeft
                                          );
                                        },
                                      )
                                    ]
                                )
                            ),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: ExpansionPanelList(
                                  expansionCallback: (int index, bool isExpanded) {
                                    setState(() {
                                      _data[index].isExpanded = !isExpanded;
                                    });
                                  },
                                  children: _data.map<ExpansionPanel>((QnA item) {
                                    return ExpansionPanel(
                                      headerBuilder: (BuildContext context, bool isExpanded) {
                                        return ListTile(
                                          title: Text(item.headerValue),
                                        );
                                      },
                                      body: ListTile(
                                          title: Text(item.expandedValue),
                                          subtitle: Text('To delete this panel, tap the trash can icon'),
                                          trailing: Icon(Icons.delete),
                                          onTap: () {
                                            setState(() {
                                              _data.removeWhere((currentItem) => item == currentItem);
                                            });
                                          }),
                                      isExpanded: item.isExpanded,
                                    );
                                  }).toList(),
                                )
                            )
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
