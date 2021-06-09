import 'dart:io';

import 'package:exhibition_guide_app/l10n/l10n.dart';
import 'package:exhibition_guide_app/main/splash_screen.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/locale_provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'provider/setting_provider.dart';
import 'package:flutter/services.dart';

void main() {
  KakaoContext.clientId = "92171a32648f836ef5946da743070f49";
  KakaoContext.javascriptClientId = "c58110022ae2050a821d63d28eda67cc";
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MyPageProvider()),
          ChangeNotifierProvider(create: (context) => SettingProvider()),
          ChangeNotifierProvider(create: (context) => DevicesProvider()),
          ChangeNotifierProvider(create: (context) => SocialProvider()),
          ChangeNotifierProvider(create: (context) => ExhibitProvider()),

        ],
        child: main(context),
      );
    },
  );

  Widget main(BuildContext context) {
    final localeProv = Provider.of<LocaleProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: localeProv.locale,
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
      // home: MainView(),
      home: SplashScreen(),
    );
  }
}
