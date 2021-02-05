import 'package:exhibition_guide_app/commons/exhibit_view_bottom.dart';
import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:exhibition_guide_app/model/exhibit_theme_item_model.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:exhibition_guide_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
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

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(widget.appBarTitle != null ? widget.appBarTitle : '', style: TextStyle(color: Colors.white),),
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
                  child: Container(
                    width: double.infinity,
                    height: item.isOpen ? mqh * 0.22 : mqh * 0.17,
                    decoration: BoxDecoration(
                        borderRadius: (
                            item.isOpen
                                ? BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
                                : BorderRadius.circular(8.0)
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            item.imgPath,
                          ),
                          onError: (dynamic error, StackTrace stackTrace) {
                            setState(() {
                              item.imgPath = IMAGE_ERROR;
                            });
                          }
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
                  ),
                ),
                item.isOpen ? (
                    Container(
                      width: double.infinity,
                      height: mqh * 0.22,
                      padding: EdgeInsets.all(mqw * 0.03),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                      ),
                      child: Text(
                        getTextByLanguage(item, 'content', _settingProv.language),
                        style: TextStyle(fontSize: 18),
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
