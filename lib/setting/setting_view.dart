import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final Color _darkBlue = Color.fromARGB(255, 18, 32, 47);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: _darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            '설정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black.withOpacity(0.2),
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
        ),
        body: Center(
          child: Container(),
        ),
      ),
    );
  }
}
