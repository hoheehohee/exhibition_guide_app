import 'package:carousel_slider/carousel_slider.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'exhibit_detail.dart';

class ExhibitHighlightView extends StatefulWidget {
  @override
  _ExhibitHighlightViewState createState() => _ExhibitHighlightViewState();
}

class _ExhibitHighlightViewState extends State<ExhibitHighlightView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> imgList1 = [
    'http://image.dongascience.com/Photo/2016/12/14830593296726.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRin2FtYAFZIK4Yv-fCVboJylGVZSS9u-lM3w&usqp=CAU',
    'https://pds.joins.com//news/component/htmlphoto_mmdata/201712/02/7ff3ada7-1393-4da8-833d-ee5f877913d8.jpg',
  ];
  final List<String> imgList2 = [
    'https://pds.joins.com//news/component/htmlphoto_mmdata/201712/02/7ff3ada7-1393-4da8-833d-ee5f877913d8.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRin2FtYAFZIK4Yv-fCVboJylGVZSS9u-lM3w&usqp=CAU'
    'http://image.dongascience.com/Photo/2016/12/14830593296726.jpg',
  ];
  final List<String> imgList3 = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRin2FtYAFZIK4Yv-fCVboJylGVZSS9u-lM3w&usqp=CAU'
    'http://image.dongascience.com/Photo/2016/12/14830593296726.jpg',
    'https://pds.joins.com//news/component/htmlphoto_mmdata/201712/02/7ff3ada7-1393-4da8-833d-ee5f877913d8.jpg',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        images: imgList1,
                        title: "전시유물",
                        iconPath: "assets/images/icon/icon-main-relics.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        images: imgList2,
                        title: '상설전시',
                        iconPath: "assets/images/icon/icon-main-sangsul.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        images: imgList3,
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

  Widget _exhibitList({title, iconPath , images}) {
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
              items: _imageSliders(images),
            ),
          ],
        )
    );
  }

  List<Widget> _imageSliders(List<String> imageList) {
    return imageList.map((item) => Container(
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
                      'No. ${imageList.indexOf(item)} image',
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
