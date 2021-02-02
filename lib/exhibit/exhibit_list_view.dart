import 'package:carousel_slider/carousel_slider.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/model/exhibit_content_data_model.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'exhibit_items.dart';

class ExhibitListView extends StatelessWidget {

  ExhibitListView({
    Key key,
    this.appBarTitle
  }) : super(key: key);

  var mqd;
  var mqw;
  var mqh;
  var _exhibitProv;

  final String appBarTitle;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> imgList1 = [
    'http://image.dongascience.com/Photo/2016/12/14830593296726.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRin2FtYAFZIK4Yv-fCVboJylGVZSS9u-lM3w&usqp=CAU',
    'https://pds.joins.com//news/component/htmlphoto_mmdata/201712/02/7ff3ada7-1393-4da8-833d-ee5f877913d8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _exhibitProv = Provider.of<ExhibitProvider>(context);

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
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2.0,
                          // enlargeCenterPage: true,
                        ),
                        items: _imageSliders(imgList1),
                      ),
                      Container(
                        padding: EdgeInsets.all(mqw * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _contentItem(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        )
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(appBarTitle != null ? appBarTitle : '', style: TextStyle(color: Colors.white),),
      actions:[
        IconButton(
          icon: new Icon(Icons.menu, size: mqw * 0.08, color: Colors.white,),
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ],
      leading: new Container(),
    );
  }

  Widget _textInput() {
    return Padding(
        padding: EdgeInsets.all(mqw * 0.03),
        child: Container(
          child: TextField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1),
              filled: true,
              fillColor: Color(0xffC3C3C3),
              border: OutlineInputBorder(),
              hintText: "전시품명을 검색하세요",
              hintStyle: TextStyle(color: Color(0xff5B5B5B), fontSize: 18),
              prefixIcon: Icon(Icons.search, size: mqw * 0.07,),
            ),
          ),
        )
    );
  }

  List<Widget> _imageSliders(List<String> imageList) {
    return imageList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(mqw * 0.01),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  onTap: () {
                    // Get.offAll(ExhibitDetail(2));
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
                          Color.fromARGB(100, 0, 0, 0),
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

  Widget _exhibitTitle(title, iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageIcon(
          AssetImage(iconPath),
          color: Colors.white,
          size: mqw * 0.06,
        ),
        SizedBox(width: mqw * 0.02,),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ],
    );
  }

  List<Widget> _contentItem() {
    List<Widget> result = [
      _exhibitTitle(
          "전시유물",
          "assets/images/icon/icon-main-relics.png"
      ),
      SizedBox(height: mqh * 0.02),
    ];

    _exhibitProv.exhibitContentData.data.forEach((item) => {
      result.add(Container(
          height: mqh * 0.1,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: mqw * 0.02),
          decoration: BoxDecoration(
            // color: Colors.green,
              borderRadius: BorderRadius.circular((mqw * 0.03)),
              image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
                // image: new NetworkImage(
                //   'http://www.allwhitebackground.com/images/2/2582-190x190.jpg',
                // ),
                image: AssetImage("assets/images/content_layer.png"),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mqw * 0.08),
                child: Text(item.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              )
            ],
          )
      ))
    });
    return result;
  }
}
