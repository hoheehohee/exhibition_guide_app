import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {

  final Color _darkBlue = Color.fromARGB(255, 18, 32, 47);
  var _settingProvider;

  @override
  Widget build(BuildContext context) {
    _settingProvider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: _darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding( padding: EdgeInsets.all(10), child: Text('앱 정보'), ),
              _version(), // 버전정보 컴포넌트
              SizedBox(height: 30),
              Padding( padding: EdgeInsets.all(10), child: Text('글자 크기') ),
              _textSizeView(),  // 변경된 글자크 뷰 컴포넌트.
              _textSizeScroll(), // 글자크기 변경 스크롤 컴포넌트.
              SizedBox(height: 20,),
              Padding( padding: EdgeInsets.all(10), child: Text('네트워크 사용') ),
              _isNetwork()  // 네트워크 사용 유무
            ],
        ),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        '설정',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.black26,
      leading: Builder(
        builder: (BuildContext context) => (
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            )
        ),
      ),
    );
  }

  // 버전정보 컴포넌트
  Widget _version() {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.black26,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('버전정보', style: TextStyle(fontSize: 18),),
          Text('0.1', style: TextStyle(color: Colors.orange, fontSize: 18),)
        ],
      ),
    );
  }

  // 글자 크기 뷰 컴포넌트
  Widget _textSizeView() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black12,
      child: Center(
        child: Text(
            '전시안내 설명은 아내의 선택한 글자 크기로\n변경되어 보여집니다.',
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
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('A'),
            Expanded(
              flex: 1,
              child: Slider(
                value: _settingProvider.fontSize,
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
    return Container(
      width: double.infinity,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('데이터 네트워크 (3G/LTE) 사용'),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              _settingProvider.isNetwork
                  ? Icons.toggle_on_outlined
                  : Icons.toggle_off_outlined,
              size: 50,
            ),
            onPressed: () {
              _settingProvider.setIsNetwork();
            },
          )
        ],
      ),
    );
  }
}
