import 'package:carousel_slider/carousel_slider.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:exhibition_guide_app/booking/booking_view.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/crm/customer_center_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/language/language_view.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/mypage/mypage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../menu.dart';
import 'exhibit_detail.dart';
import 'permanent_exhibit_view.dart';

class ExhibitHighlightView extends StatefulWidget {
  @override
  _ExhibitHighlightViewState createState() => _ExhibitHighlightViewState();
}

class _ExhibitHighlightViewState extends State<ExhibitHighlightView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  int _selectedMenuItemId;
  DrawerScaffoldController _controller = DrawerScaffoldController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedMenuItemId = 333;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      key: _scaffoldKey,
      endDrawer: Drawer(
          child: Container(
            color: Color(0xff1A1A1B),
            child: SliderDrawers(),
          )
      ),
      body: Container(
        color: backgroundColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _textInput(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _exhibitList(
                        title: "전시유물",
                        iconPath: "assets/images/icon/icon-main-relics.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        title: '상설전시',
                        iconPath: "assets/images/icon/icon-main-sangsul.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        title: '기획전시',
                        iconPath: "assets/images/icon/icon-main-plan.png"
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text('하이라이트', style: TextStyle(color: Colors.white),),
      actions:[
        IconButton(
          icon: new Icon(Icons.menu, size: 30, color: Colors.white,),
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ],
      leading: new Container(),
    );
  }

  Widget _bottomButtons() {
    return Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("자동전시", style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 5,),
                      //"assets/images/toogle-main-on.png"
                      InkWell(
                        child: Image.asset("assets/images/toogle-main-on.png", width: 50,),
                        onTap: () {},
                      )
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("음성지원 안내", style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 5,),
                      //"assets/images/toogle-main-on.png"
                      InkWell(
                        child: Image.asset("assets/images/toogle-main-on.png", width: 50,),
                        onTap: () {},
                      )
                    ],
                  ),
                ],
              )
            ),
            Container(
              height: 70,
              color: backgroundColor,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bottomBtn(
                      title: '오시는길',
                      iconPath: 'assets/images/icon/icon-location.png',
                      onTapFunc: () {},
                    ),
                    _bottomBtn(
                      title: '전시관 지도',
                      iconPath: 'assets/images/icon/icon-map.png',
                      onTapFunc: () {},
                    ),
                    _bottomBtn(
                      title: '공지사항',
                      iconPath: 'assets/images/icon/icon-notice.png',
                      onTapFunc: () {},
                    ),
                  ]
              )
            )
          ],
        )
    );
  }

  Widget _bottomBtn({ title, iconPath, onTapFunc }) {
    return Container(
      width: 80,
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (onTapFunc != null) onTapFunc();
            },
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconPath, color: Colors.white, height: 28,),
                Text(title, style: TextStyle(color: Colors.white))
              ],
            ),
          )
      ),
    );
  }

  Widget _textInput() {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          height: 55,
          child: TextField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1),
              filled: true,
              fillColor: Color(0xffC3C3C3),
              border: OutlineInputBorder(),
              hintText: "전시품명을 검색하세요",
              hintStyle: TextStyle(color: Color(0xff5B5B5B), fontSize: 18),
              prefixIcon: Icon(Icons.search, size: 30,),
            ),
          ),
        )
    );
  }

  Widget _exhibitList({title, iconPath}) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageIcon(
                    AssetImage(iconPath),
                    color: Colors.white,
                  ),
                  SizedBox(width: 10,),
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 22),),
                ],
              ),
            ),
            SizedBox(height: 5,),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                // enlargeCenterPage: true,
              ),
              items: _imageSliders(imgList),
            ),
          ],
        )
    );
  }

  List<Widget> _imageSliders(imageList) {
    return imgList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  onTap: () {
                    Get.offAll(ExhibitDetail(2));
                  },
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. ${imgList.indexOf(item)} image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )).toList();
  }
}
