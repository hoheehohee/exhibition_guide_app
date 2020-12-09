import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exhibition_guide_app/provider/museum_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_item.dart';

class MuseumView extends StatelessWidget {
  final List<String> _items = ['전시 카테고리1', '전시 카테고리2', '전시 카테고리3', '전시 카테고리4', '전시 카테고리5', '전시 카테고리6', '전시 카테고리7'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MuseumProvider>(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text("코쟁이 박물관")
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: _mainWidget(context), // 검색, slider image, 성설전시, 카테고리 리스트
                ),
              ),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 1.5, color: Colors.grey))
                  ),
                  child: _guideButton(context) // 안내 버튼
              )
            ],
          ),
          drawer: _drawerWidget(),  // left 햄버거 메뉴
          bottomNavigationBar: _bottomBar(),  // bottom 버튼
        )
    );
  }

  Widget _drawerWidget() => (
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 30),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      )
  );

  Widget _mainWidget(BuildContext context) {
    final provider = Provider.of<MuseumProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "작품명, 작가명을 입력하세요.",
              prefixIcon: Icon(Icons.search, color: Colors.grey,),
            )
        ),
        CarouselSlider(
            options: CarouselOptions(
              height: 150,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              // enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 4000),
              onPageChanged: (index, reson) {},
            ),
            items: _imageItems(provider.imageList)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
//               padding: EdgeInsets.only(right: 10),
              icon: Icon(
                  provider.isPermanentExhibition
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank
              ),
              onPressed: () {
                provider.setIsPermanentExhibition();
              },
            ),
            Text('상설전시', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) => CategoryItem(_items[index])
          ),
        ),
      ],
    );
  }

  List<Widget> _imageItems(imgList) {

    List<Widget> result = [];
    for (var i = 0; i < imgList.length; i++) {
      result.add(Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10),
          // decoration: BoxDecoration(color: Colors.green),
          child: CachedNetworkImage(
            imageUrl: imgList[i],
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
      ));
    }
    return result;
  }

  Widget _guideButton(context) {
    final provider = Provider.of<MuseumProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('자동전시 안내'),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                  provider.isAutoExhibit
                    ? Icons.toggle_on_outlined
                    : Icons.toggle_off_outlined,
                  size: 34,
                  color: Colors.orange
              ),
              onPressed: () {
                provider.setIsAutoExhibi();
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('음성지원 안내'),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                  provider.isAudio
                      ? Icons.toggle_on_outlined
                      : Icons.toggle_off_outlined,
                  size: 34,
                  color: Colors.orange
              ),
              onPressed: () {
                provider.setIsAudio();
              },
            )
          ],
        )
      ],
    );
  }

  Widget _bottomBar() {
    return Container(
        color: Colors.white,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                  icon: Icon(Icons.view_agenda),
                  child: Text('메인', style: TextStyle(fontSize: 10))
              ),
              Tab(
                  icon: Icon(Icons.map),
                  child: Text('전시관 지도', style: TextStyle(fontSize: 10))
              ),
              Tab(
                  icon: Icon(Icons.room),
                  child: Text('오시는길', style: TextStyle(fontSize: 10))
              ),
            ]
        )
    );
  }
}
