import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {

  final Color _darkBlue = Color.fromARGB(255, 18, 32, 47);
  SettingProvider _settingProvider;

  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    _locals = AppLocalizations.of(context);
    _settingProvider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: _darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        backgroundColor: backgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding( padding: EdgeInsets.all(10), child: Text(_locals.setting2), ),
              _version(), // 버전정보 컴포넌트
              SizedBox(height: 30),
              Padding( padding: EdgeInsets.all(10), child: Text(_locals.setting4) ),
              _textSizeView(),  // 변경된 글자크 뷰 컴포넌트.
              _textSizeScroll(), // 글자크기 변경 스크롤 컴포넌트.
              SizedBox(height: 20,),
              Padding( padding: EdgeInsets.all(10), child: Text(_locals.setting6) ),
              _isNetwork()  // 네트워크 사용 유무
            ],
        ),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      // elevation: 0.0,
      centerTitle: true,
      title: Text(
        _locals.setting1,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: backgroundColor,
      leading: CustomImageIconBtn(
        px: 15.0,
        iconPath: "assets/images/button/btn-back.png",
        onAction: () {
          Get.back();
        },
      ),
    );
  }

  // 버전정보 컴포넌트
  Widget _version() {
    return Container(
      width: double.infinity,
      height: 70,
      color: Color(0xff365871),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_locals.setting3, style: TextStyle(fontSize: 18),),
          Text('V 0.1', style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }

  // 글자 크기 뷰 컴포넌트
  Widget _textSizeView() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Color(0xff365871),
      child: Center(
        child: Text(
            _locals.setting5,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: double.parse(_settingProvider.fontSize.toStringAsFixed(0)))
        ),
      ),
    );
  }

  // 글자 크기 변경 스크롤 컴포넌트.
  Widget _textSizeScroll() {
    return Container(
        width: double.infinity,
        height: 70,
        color: Color(0xff2D4C62),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('A'),
            Expanded(
              flex: 1,
              child: Slider.adaptive(
                value: _settingProvider.fontSize,
                inactiveColor: Colors.white,
                min: 10,
                max: 30,
                onChanged: (double value) {
                  _settingProvider.setFontSize(value);
                },
              ),
            ),
            Text('A', style: TextStyle(fontSize: 20),)
          ],
        )
    );
  }

  //네트워크 사용 유무 컴포넌트
  Widget _isNetwork() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xff365871),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_locals.setting7),
              IconButton(
                padding: EdgeInsets.all(0),
                icon:
                _settingProvider.isNetwork
                    ? Image.asset("assets/images/button/btn-toogle-on.png")
                    : Image.asset("assets/images/button/btn-toogle-off.png"),
                onPressed: () {
                  _settingProvider.setIsNetwork();
                },
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(_locals.setting8, style: TextStyle(color: Color(0xff5A768E))),
        )
      ],
    );
  }
}
