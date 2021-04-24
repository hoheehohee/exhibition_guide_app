import 'package:cached_network_image/cached_network_image.dart';
import 'package:exhibition_guide_app/commons/custon_slider_appbar.dart';
import 'package:exhibition_guide_app/commons/exhibit_view_bottom.dart';
import 'package:exhibition_guide_app/commons/slider_no_image.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_list_view.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:exhibition_guide_app/model/exhibit_theme_item_model.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:exhibition_guide_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant.dart';

class ExhibitThemeView extends StatefulWidget {
  final appBarTitle;
  final location;

  ExhibitThemeView({
    Key key,
    this.appBarTitle,
    this.location
  }): super(key: key);

  @override
  _ExhibitThemeViewState createState() => _ExhibitThemeViewState();
}

class _ExhibitThemeViewState extends State<ExhibitThemeView> {
  var mqd;
  var mqw;
  var mqh;
  ExhibitProvider _exhibitProv ;
  SettingProvider _settingProv;
  bool show = false;
  AppLocalizations _locals;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getTitle(String title){
    if(title == "전시유물" || title == "Relics" || title == "展示遺物" || title == "展示遺物" || title == "展示文物" ){
      return _locals.menu2;
    } else if(title == "전시물" || title == "Permanent Exhibition" || title == "常設展示" || title == "常设展览" ){
      return _locals.menu3;
    } else if(title == "기획전시" || title == "Featured Exhibition" || title == "企画展示" || title == "策划展览" ){
      return _locals.menu4;
    } else if(title == "전시물" || title == "Exhibits" || title == "展示物" || title == "展品" ){
      return _locals.main5;
    } else if(title == "4F 전시실" || title == "4th Floor" || title == "４Ｆ 展示室" || title == "4F展厅" ){
      return _locals.main6;
    } else if(title == "5F 전시실" || title == "5th Floor" || title == "5Ｆ 展示室" || title == "5F展厅" ){
      return _locals.main7;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitThemeListSel(widget.location)
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _exhibitProv = Provider.of<ExhibitProvider>(context);
    _settingProv = Provider.of<SettingProvider>(context);
    _locals = AppLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.08),
          child: CustomSliderAppbar(
            title: widget.appBarTitle != null ? getTitle(widget.appBarTitle) : '',
            onAction: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          )
      ),
      bottomNavigationBar: ExhibitViewBottom(),
      backgroundColor: backgroundColor,
      endDrawer: Drawer(
          child: Container(
            color: Color(0xff1A1A1B),
            child: SliderDrawers(),
          )
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.all(mqw * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _dataItem(),
            )
        ),
      )
    );
  }

  List<Widget> _dataItem() {
    if (_exhibitProv.exhibitThemeItem.length == 0) return [Container()];
    List<Widget> result = [];

    _exhibitProv.exhibitThemeItem.forEach((ExhibitThemeItemModel item) {
      result.add(
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      item.isOpen = !item.isOpen;
                    });
                  },
                  child: CachedNetworkImage(
                    imageUrl: item.imgPath,
                    errorWidget: (context, url, error) => Container(
                        height: mqh * 0.1,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: mqh * 0.02),
                        decoration: BoxDecoration(
                          color: Color(0xffA0A0A0),
                          borderRadius: (
                              item.isOpen
                                  ? BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
                                  : BorderRadius.circular(8.0)
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: mqw * 0.03,),
                            Text(
                              getTextByLanguage(item, 'title', _settingProv.language),
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: mqw * 0.2),
                            Image.asset("assets/images/icon/icon-frown.png",),
                            SizedBox(width: mqw * 0.02,),
                            Text(
                                "No data",
                                style: TextStyle(fontSize: mqw * 0.05, fontWeight: FontWeight.w600, color: Color(0xff2D4357))
                            )
                          ],
                        )
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                          width: double.infinity,
                          height: mqh * 0.17,
                          decoration: BoxDecoration(
                              borderRadius: (
                                  item.isOpen
                                      ? BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
                                      : BorderRadius.circular(8.0)
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: mqw * 0.03),
                                child: Text(
                                  getTextByLanguage(item, 'title', _settingProv.language),
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: mqw * 0.03),
                                child: Text(
                                  getTextByLanguage(item, 'subTitle', _settingProv.language),
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              )
                            ],
                          )
                      );
                    },
                  )

                ),
                item.isOpen ? (
                    InkWell(
                      onTap: () {
                        Get.to(
                          ExhibitListView(
                            contentType: '',
                            contentIconPath: '',
                            contentTitle: '',
                            appBarTitle: widget.appBarTitle,
                            exhibitionCode: item.exhibitionCode,
                          )
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: mqh * 0.22,
                        padding: EdgeInsets.all(mqw * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            getTextByLanguage(item, 'content', _settingProv.language),
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ),
                    )
                ) : Container()
              ],
            ),
          )
      );
    });
    return result;
  }
}
