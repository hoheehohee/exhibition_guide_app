import 'package:carousel_slider/carousel_slider.dart';
import 'package:exhibition_guide_app/commons/custon_slider_appbar.dart';
import 'package:exhibition_guide_app/commons/exhibit_view_bottom.dart';
import 'package:exhibition_guide_app/commons/slider_no_image.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/model/exhibit_content_data_model.dart' as ECDM;
import 'package:exhibition_guide_app/model/exhibit_content_data_model.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../util.dart';
import 'exhibit_detail.dart';

class ExhibitHighlightView extends StatefulWidget {
  @override
  _ExhibitHighlightViewState createState() => _ExhibitHighlightViewState();
}

class _ExhibitHighlightViewState extends State<ExhibitHighlightView> {
  var mqd;
  var mqw;
  var mqh;

  AppLocalizations _locals;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ExhibitProvider _exhibitProv;
  SettingProvider _settingProv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() => {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitHighlightListSel()
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _locals = AppLocalizations.of(context);
    _exhibitProv = Provider.of<ExhibitProvider>(context);
    _settingProv = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.08),
          child: CustomSliderAppbar(
            title: _locals.menu1,
            onAction: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          )
      ),
      bottomNavigationBar: ExhibitViewBottom(),
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
                        _exhibitProv.exhibitHighlightDataOne,
                        title: _locals.menu2,
                        iconPath: "assets/images/icon/icon-main-relics.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        _exhibitProv.exhibitHighlightDataTwo,
                        title: _locals.menu3,
                        iconPath: "assets/images/icon/icon-main-sangsul.png"
                    ),
                    SizedBox(height: 15,),
                    _exhibitList(
                        _exhibitProv.exhibitHighlightDataThree,
                        title: _locals.menu4,
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

  Widget _textInput() {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          height: 55,
          child: TextField(
            style: TextStyle(fontSize: 18),
            onSubmitted: (value) {
              Provider.of<ExhibitProvider>(context, listen: false).setExhibitHighlightListSel(search: value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1),
              filled: true,
              fillColor: Color(0xffC3C3C3),
              border: OutlineInputBorder(),
              hintText: _locals.hr4,
              hintStyle: TextStyle(color: Color(0xff5B5B5B), fontSize: 18),
              prefixIcon: Icon(Icons.search, size: 30,),
            ),
          ),
        )
    );
  }

  Widget _exhibitList(ExhibitContentsDataModel list, {title, iconPath }) {
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
            list.data.length == 0
            ? SliderNoImage()
            : (
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enableInfiniteScroll: false,
                    // enlargeCenterPage: true,
                  ),
                  items: _imageSliders(list.data, title),
                )
            )
          ],
        )
    );
  }

  List<Widget> _imageSliders(List<ECDM.Data> imageList, String title) {
    return imageList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(mqw * 0.01),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: Image.network(item.contentsImgFile, fit: BoxFit.cover, width: 1000.0),
                  onTap: () {
                    Get.to(
                      ExhibitDetail(
                        item.idx,
                        appbarTitle: title,
                      )
                    );
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
                      getTextByLanguage(item, 'title', _settingProv.language),
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
