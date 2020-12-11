import 'package:flutter/material.dart';

class BookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("이용예약 신청"),
          leading: Builder(
              builder: (BuildContext context) => (
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {}
                  )
              )
          ),
          actions:[
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {},
            )
          ]
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _mainView(),
      ),
      bottomNavigationBar: _bottomButtoms(),
    );
  }

  Widget _mainView() {
    return Column(
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
                        child: Icon(Icons.event_note, color: Colors.orange)
                    ),
                    Expanded(
                        flex: 1,
                        child: Text('예약정보 입력', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    )
                  ]
              )
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('이용날짜 선택', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "이용할 날짜를 선택하세요",
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text('이용할 시간', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "이용할 시간를 선택하세요",
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text('외국인 구분', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                      color: Colors.white,
                                      child: IconButton(
                                        splashRadius: 20,
                                        icon: Icon(Icons.radio_button_on, color: Colors.orange),
                                        onPressed: () {},
                                      )
                                  ),
                                  Text('내국인'),
                                ]
                            )
                        ),
                        Expanded(
                            flex: 2,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                      color: Colors.white,
                                      child: IconButton(
                                        splashRadius: 20,
                                        icon: Icon(Icons.radio_button_off, color: Colors.grey),
                                        onPressed: () {},
                                      )
                                  ),
                                  Text('외국인'),
                                  Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
//                             value: '국적 선택',
                                        hint: Center(child: Text('국적 선택')),
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 24,
                                        isExpanded: true,
                                        onChanged: (newValue) {
                                          print('$newValue');
                                        },
                                        items: <String>['미국', '중국', '일본', '프랑스']
                                            .map<DropdownMenuItem<String>>((String value) {
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
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text('장애구분', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                      color: Colors.white,
                                      child: IconButton(
                                        splashRadius: 20,
                                        icon: Icon(Icons.radio_button_on, color: Colors.orange),
                                        onPressed: () {},
                                      )
                                  ),
                                  Text('일반인'),
                                ]
                            )
                        ),
                        Expanded(
                            flex: 2,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                      color: Colors.white,
                                      child: IconButton(
                                        splashRadius: 20,
                                        icon: Icon(Icons.radio_button_off, color: Colors.grey),
                                        onPressed: () {},
                                      )
                                  ),
                                  Text('장애인'),
                                  Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
//                             value: '국적 선택',
                                        hint: Center(child: Text('장애항목 선택')),
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 24,
                                        isExpanded: true,
                                        onChanged: (newValue) {
                                          print('$newValue');
                                        },
                                        items: <String>['1', '2', '3', '4']
                                            .map<DropdownMenuItem<String>>((String value) {
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
                  )
                ]
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('전시정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                        color: Colors.white,
                                        child: IconButton(
                                            splashRadius: 20,
                                            icon: Icon(Icons.check_box_outline_blank),
                                            onPressed: () {}
                                        )
                                    ),
                                    Text('전제 전시해설')
                                  ]
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                        color: Colors.white,
                                        child: IconButton(
                                            splashRadius: 20,
                                            icon: Icon(Icons.check_box_outline_blank),
                                            onPressed: () {}
                                        )
                                    ),
                                    Text('상설 전시실')
                                  ]
                              )
                          )
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                        color: Colors.white,
                                        child: IconButton(
                                            splashRadius: 20,
                                            icon: Icon(Icons.check_box_outline_blank),
                                            onPressed: () {}
                                        )
                                    ),
                                    Text('전시유물')
                                  ]
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                        color: Colors.white,
                                        child: IconButton(
                                            splashRadius: 20,
                                            icon: Icon(Icons.check_box_outline_blank),
                                            onPressed: () {}
                                        )
                                    ),
                                    Text('기타/기획전시')
                                  ]
                              )
                          )
                        ]
                    )
                  ]
              )
          )
        ]
    );
  }

  Widget _bottomButtoms() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
        // color: Colors.green,
        child: RaisedButton(
          color: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text('이용신청 완료', style: TextStyle(fontSize: 18, color: Colors.white)),
          onPressed: () {},
        )
    );
  }
}
