import 'package:cached_network_image/cached_network_image.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_category_list_view.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'exhibit_category_item.dart';

class ExhibitCategoryView extends StatefulWidget {
  @override
  _ExhibitCategoryViewState createState() => _ExhibitCategoryViewState();
}

class _ExhibitCategoryViewState extends State<ExhibitCategoryView> {
  final _imageUrl = "https://monthlyart.com/wp-content/uploads/2020/07/Kukje-Gallery-Wook-kyung-Choi-Untitled-c.-1960s-34-x-40-cm.jpg";
  final _text = "국제갤러리는 K1 건물의 재개관을 기념하여 최욱경(1940-1985)의 개인전 《Wook-kyung Choi》를 개최한다. 2005년, 2016년에 이어 국제갤러리에서 세 번째로 열리는 개인전으로, 1960년대부터 1975년경 사이 제작된 흑백 잉크 드로잉과 추상회화외 콜라주로 구성된 컬러 작업을 40점 선보인다.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitSel()
    });
  }

  _randerListView() {
    final _exhibit = Provider.of<ExhibitProvider>(context);
    final list = _exhibit.exhibitList;
    final loading = _exhibit.loading;

    // 로딩중이면서 목록이 없을 때
    if (loading && list.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 로딩중이 아닌데 목록이 없을 때
    if (!loading && list.length == 0) {
      return Center(
        child: Text('목록이 없습니다.')
      );
    }

    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ExhibitCategoryItem(
              _exhibit.getTextByLanguage(index, "title"), list[index].idx, _imageUrl,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final _exhibit = Provider.of<ExhibitProvider>(context);
    final loading = _exhibit.loading;

    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _exhibit.exhibitItem[0].exhibitionName
              Text(!loading ? _exhibit.getTextByLanguage(0, 'exhibition_name') : 'OOOO'),
              IconButton(
                  padding: EdgeInsets.only(bottom: 0, top: 5),
                  icon: Icon(Icons.expand_more, size: 34),
                  onPressed: () {
                    Get.to(
                      ExhibitCategoryListView(),
                      transition: Transition.fadeIn
                    );
                  }
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
                Get.offAll(
                  MainView(),
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
                  child: CachedNetworkImage(
                    imageUrl: _imageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
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
                          Text(
                              !loading ? _exhibit.getTextByLanguage(0, 'sub_name') : 'OOOO',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                          )
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
                child: _randerListView(),
              ),
              SizedBox(height: 18)
            ]
        ),
      ),
    );
  }
}
