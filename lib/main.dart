import 'dart:async';

import 'package:exhibition_guide_app/provider/device_provider.dart';
import 'package:exhibition_guide_app/provider/language_provider.dart';
import 'package:exhibition_guide_app/provider/museum_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'package:exhibition_guide_app/main/main_view.dart';
import 'provider/setting_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  BleManager bleManager = BleManager();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => MuseumProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider(bleManager))
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )
          ),
          appBarTheme: AppBarTheme(
              color: Colors.white,
//           elevation: 0.0,
              centerTitle: true
          ),
        ),
        home: MainView(),
      ),
    );
  }
}
