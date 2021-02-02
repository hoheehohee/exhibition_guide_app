import 'package:exhibition_guide_app/exhibit/exhibit_list_view.dart';
import 'package:exhibition_guide_app/exhibit/permanent_exhibit_item.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exhibition_guide_app/main/main_view.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PermanentExhibitView extends StatefulWidget {
  @override
  _PermanentExhibitViewState createState() => _PermanentExhibitViewState();
}

class _PermanentExhibitViewState extends State<PermanentExhibitView> {
  var _exhibit;
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() => {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitSel()
    });
  }

  @override
  Widget build(BuildContext context) {
    _exhibit = Provider.of<ExhibitProvider>(context);
    _loading = _exhibit.loading;

    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                child: _exhibitMainImages(),  // 전시관 메인 이미지 슬라이드.
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  color: Colors.white,
                  child: _exhibitContext()  // 전시물 title 및 상세내용
              ),
              Expanded(
                flex: 1,
                child: _randerListView(), // 등록전시물 목록
              ),
              SizedBox(height: 18)
            ]
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _exhibit.exhibitItem[0].exhibitionName
            Text(!_loading ? _exhibit.getTextByLanguage(0, 'exhibition_name') : 'OOOO'),
            IconButton(
                padding: EdgeInsets.only(bottom: 0, top: 5),
                icon: Icon(Icons.expand_more, size: 34),
                onPressed: () {
                  Get.to(
                      ExhibitListView(),
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
                      Get.offAll(MainView());
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
    );
  }

  // 전시관 메인 이미지 슬라이드.
  Widget _exhibitMainImages() {
    return CachedNetworkImage(
      imageUrl: permanentImage,
      fit: BoxFit.fill,
      placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  // 전시물 title 및 상세내용.
  Widget _exhibitContext() {
    return Column(
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
                !_loading ? _exhibit.getTextByLanguage(0, 'sub_name') : 'OOOO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            )
          ],
        ),
        Divider(color: Colors.black45, height: 10),
        Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(permanentDetText1)
            )
        ),
      ],
    );
  }

  // 등록전시물 목록
  Widget _randerListView() {
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
          return PermanentExhibitItem(
            _exhibit.getTextByLanguage(index, "title"), list[index].idx, permanentImage,
          );
        }
    );
  }

}
