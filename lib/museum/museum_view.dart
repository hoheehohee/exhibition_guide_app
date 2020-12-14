import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:exhibition_guide_app/provider/museum_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../booking/booking_view.dart';
import '../exhibit/exhibit_category_view.dart';
import '../menu.dart';
import 'category_item.dart';

class MuseumView extends StatefulWidget {
  @override
  _MuseumViewState createState() => _MuseumViewState();
}

class _MuseumViewState extends State<MuseumView> {
  int selectedMenuItemId;
  DrawerScaffoldController controller = DrawerScaffoldController();

  @override
  void initState() {
    selectedMenuItemId = menu.items[0].id;
    super.initState();
  }

  final List<String> _items = ['전시 카테고리1', '전시 카테고리2', '전시 카테고리3', '전시 카테고리4', '전시 카테고리5', '전시 카테고리6', '전시 카테고리7'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MuseumProvider>(context);
    return DefaultTabController(
        length: 3,
        child: DrawerScaffold(
          controller: controller,
          appBar: AppBar(
              title: Text("코쟁이 박물관")
          ),

          builder: (context, id) =>  Column(
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
          drawers: [
            SideDrawer(
              itemBuilder: (BuildContext context, MenuItem menuItem, bool isSelected) {
                return Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark, color: Colors.white),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                            menuItem.title,
                            style: TextStyle(fontSize: 20, color: Colors.white)
                        )
                      )
                    ],
                  )
                );
              },
              percentage: 1,
              menu: menu,
              animation: false,
              alignment: Alignment.topLeft,
              color: Colors.white24,
              selectedItemId: selectedMenuItemId,
              textStyle: TextStyle(color: Colors.white, fontSize: 24.0),
              onMenuItemSelected: (itemId) {
                setState(() {
                  selectedMenuItemId = itemId;
                  switch(itemId){
                    case 0:
                      Get.to(MuseumView());
                      break;
                    case 1:
                      Get.to(ExhibitCategoryView());
                      break;
                    case 6:
                      Get.to(BookingView());
                      break;
                  }
                });
              },
            )
          ],
          bottomNavigationBar: _bottomBar(),  // bottom 버튼
        )
    );
  }

  Widget _mainWidget(BuildContext context) {
    final provider = Provider.of<MuseumProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 검색
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
        // 이미지 슬라이더
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
        // 상설전시 체크박
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
        // 카테고리 리스트
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
