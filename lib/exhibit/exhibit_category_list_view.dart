import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'exhibit_items.dart';

class ExhibitCategoryListView extends StatelessWidget {
  final List<String> _categoryList = ['전시 카테고리1', '전시 카테고리2', '전시 카테고리3', '전시 카테고리4', '전시 카테고리5'];

  List<Widget> _tabItems(BuildContext context, List<String> _categoryList) {
    List<Widget> items = [];
    for(var i = 0; i < _categoryList.length; i++) {
      items.add(
          Center(child: Text(_categoryList[i], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
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
                    child: TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        indicatorColor: Colors.orange,
                        tabs: _tabItems(context, _categoryList)
                    )
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
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
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ExhibitItems()
                ),
              ],
            )
        )
      ),
    );
  }
}
