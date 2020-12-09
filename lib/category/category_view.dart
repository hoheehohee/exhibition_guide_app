import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_exhibit_item.dart';

class CategoryView extends StatelessWidget {
  final _imageUrl = "https://monthlyart.com/wp-content/uploads/2020/07/Kukje-Gallery-Wook-kyung-Choi-Untitled-c.-1960s-34-x-40-cm.jpg";
  final _text = "국제갤러리는 K1 건물의 재개관을 기념하여 최욱경(1940-1985)의 개인전 《Wook-kyung Choi》를 개최한다. 2005년, 2016년에 이어 국제갤러리에서 세 번째로 열리는 개인전으로, 1960년대부터 1975년경 사이 제작된 흑백 잉크 드로잉과 추상회화외 콜라주로 구성된 컬러 작업을 40점 선보인다.";
  final List<String> _items = ['등록 전시물1', '등록 전시물2', '등록 전시물3', '등록 전시물4', '등록 전시물5', '등록 전시물6', '등록 전시물7'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("전시 카테고리1"),
              IconButton(
                  padding: EdgeInsets.only(bottom: 0, top: 5),
                  icon: Icon(Icons.expand_more, size: 34),
                  onPressed: () {}
              ),
            ],
          ),
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
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.off(
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
                  height: 170,
                  width: double.infinity,
                  child: Image.network(_imageUrl, fit: BoxFit.fill)
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      Divider(color: Colors.black45, height: 10),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(_text)
                          )
                      ),
                    ],
                  )
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) => CategoryExhibitItem(_items[index], _imageUrl)
                ),
              ),
              SizedBox(height: 18)
            ]
        ),
      ),
    );
  }
}
