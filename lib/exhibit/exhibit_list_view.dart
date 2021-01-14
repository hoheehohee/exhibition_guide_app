import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'exhibit_items.dart';

class ExhibitListView extends StatelessWidget {

  final List<String> _categoryList = ['전시 카테고리1', '전시 카테고리2', '전시 카테고리3', '전시 카테고리4', '전시 카테고리5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          color: Colors.white,
          child: DefaultTabController(
              length: _categoryList.length,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)))
                      ),
                      child: _exhibitCategoryTabList(context)  // 전시 카테고리 tab list
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: _exhibitCategoryTitle(),  // 전시층, 전시 카테고리 타이
                  ),
                  Expanded(
                      flex: 1,
                      child: ExhibitItems() // 전시카테고리 Items
                  ),
                ],
              )
          )
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: Text('전시실 선택', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Builder(
            builder: (BuildContext context) => (
                IconButton(
                    icon: Icon(Icons.close_outlined),
                    onPressed: () {
                      Get.back();
                    }
                )
            )
        )
    );
  }

  // 전시 카테고리 tab 목록
  Widget _exhibitCategoryTabList(BuildContext context) {
    return TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.black.withOpacity(0.3),
        indicatorColor: Colors.orange,
        tabs: _tabItems(context, _categoryList)
    );
  }

  List<Widget> _tabItems(BuildContext context, List<String> _categoryList) {
    List<Widget> items = [];
    for(var i = 0; i < _categoryList.length; i++) {
      items.add(
          Center(child: Text(_categoryList[i], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))
      );
    }
    return items;
  }

  // 전시층, 전시 카테고리 title
  Widget _exhibitCategoryTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Center(child: Text('F4', style: TextStyle(color: Colors.white, fontSize: 18)))
        ),
        Text('전시 카테고리1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
      ],
    );
  }
}
