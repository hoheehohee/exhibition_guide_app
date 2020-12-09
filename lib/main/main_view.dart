import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/language/language_view.dart';
import 'package:exhibition_guide_app/museum/museum_view.dart';
import 'package:exhibition_guide_app/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:exhibition_guide_app/guide/guide_view.dart';

import '../message.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  var _isSeeGuide = 'init';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _init();
    });
  }

  void _init() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSeeGuide = prefs.getString('isSeeGuide');

    if(_isSeeGuide.isNull || _isSeeGuide == 'init')
      Get.off(
          GuideView(),
          transition: Transition.fadeIn
      );
    else if (_isSeeGuide == 'ignore' )
      await prefs.setString('isSeeGuide', 'init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _museumComponent(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: _exhibitionInfoButtons(),
          ),
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
            // color: Colors.green,
            child: RaisedButton(
              color: Colors.black54,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
              ),
              child: Text('전시물 위치보기', style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () {
                Get.to(
                    ExhibitionMapView(),
                    transition: Transition.downToUp
                );
              },
            ),
          )
        ],
      )
    );
  }

  // 박물관 컴포넌트
  Widget _museumComponent() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/main_image.jpeg"),
                  fit: BoxFit.fill
              )
          ),
        ),
        // Image.asset("assets/images/main_image.jpeg",fit: BoxFit.fill),
        Positioned(
          left: 10,
          top: 30,
          child: FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.settings, color: Colors.white),
            onPressed: () => {
              Get.to(
                SettingView(),
                transition: Transition.leftToRight
              )
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          right: 10,
          top: 30,
          child:  FloatingActionButton(
            heroTag: 2,
            child: Icon(Icons.g_translate, color: Colors.white),
            onPressed: () => {
              Get.to(
                LanguageView(),
                transition: Transition.rightToLeft
              )
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          right: 80,
          top: 150,
          left: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('코쟁이 박물관', style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),),
              Text('재미있는 코쟁이 전시회', style: TextStyle(fontSize: 18, color: Colors.white))
            ],
          ),
        ),
        Positioned(
            right: 10,
            bottom: 0,
            child: FloatingActionButton(
              heroTag: 3,
              child: Icon(Icons.arrow_circle_down, size: 28, color: Colors.white),
              onPressed: () {
                Get.defaultDialog(
                  title: "알림",
                  titleStyle: TextStyle(),
                  middleText: downloadMessage,
                  confirm: FlatButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("다운로드", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                );
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
            )
        )
      ],
    );
  }

  Widget _exhibitionInfoButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 210,
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Get.to(
                      MuseumView(),
                      transition: Transition.fadeIn
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(imageUrl1, fit: BoxFit.fill,),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('전시 유물', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 210,
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(imageUrl2, fit: BoxFit.fill,),
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('상설전시물', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }

}
