import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/model/exhibit_theme_model.dart' as ETM;
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'exhibit_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../util.dart';

class ExhibitAllListView extends StatefulWidget {

  @override
  _ExhibitAllListViewState createState() => _ExhibitAllListViewState();
}

class _ExhibitAllListViewState extends State<ExhibitAllListView> {
  var mqd;
  var mqw;
  var mqh;

  AppLocalizations _locals;
  ExhibitProvider _exhibitProv;
  final List<String> _categoryList = ['전시 카테고리1', '전시 카테고리2', '전시 카테고리3', '전시 카테고리4', '전시 카테고리5'];
  SettingProvider _settingProv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitAllListSel();
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
      appBar: _appBar(),
      body: Container(
        child: DefaultTabController(
          length: _exhibitProv.exhibitAllMenuData.data.length,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: mqh * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.3)))
                  ),
                  child: _exhibitCategoryTabList(context)  // 전시 카테고리 tab list
              ),
              Expanded(
                  flex: 1,
                  child: ExhibitItems() // 전시카테고리 Items
              ),
              // Container(
              //   height: 80,
              //   decoration: BoxDecoration(
              //     border: Border(bottom: BorderSide(color: Colors.grey)),
              //   ),
              //   child: _exhibitCategoryTitle(),  // 전시층, 전시 카테고리 타이
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(_locals.el4, style: TextStyle(color: Colors.white),),
      leading: CustomImageIconBtn(
        px: 15.0,
        iconPath: "assets/images/button/btn-cancel.png",
        onAction: () {
          Get.back();
        },
      ),
    );
  }

  Widget _exhibitCategoryTabList(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorWeight: mqw * 0.01,
      unselectedLabelColor: Colors.black.withOpacity(0.3),
      indicatorColor: Color(0xff956E2C),
      tabs: _tabItems(context, _exhibitProv.exhibitAllMenuData),
      onTap: (index) {
        final code = _exhibitProv.exhibitAllMenuData.data[index].exhibitionCode;
        _exhibitProv.setExhibitAllMenuItemsSel(code);
      }
    );
  }

  List<Widget> _tabItems(BuildContext context, ETM.ExhibitThemeModel _categoryList) {
    List<Widget> items = [];
    for(var i = 0; i < _categoryList.data.length; i++) {
      items.add(
          Center(child: Text(getTextByLanguage(_categoryList.data[i], 'exhibition_name', _settingProv.language), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))
      );
    }
    return items;
  }

  Widget _exhibitCategoryTitle() {
    return Row(
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
        Text('전시 카테고리1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
      ],
    );
  }
}
