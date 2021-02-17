import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExhivitDirectionsView extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {

    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _locals = AppLocalizations.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.main9)
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: mqh * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: mqd.size.width * 0.07, vertical: mqd.size.width * 0.07),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      addressForm(_locals.map1, '부산광역시 남구 홍곡로 320번길 100', 'assets/images/icon/icon-location-map.png'),
                      SizedBox(height: mqw * 0.05,),
                      addressForm(_locals.bk9, '051-629-8600', 'assets/images/icon/icon-tel.png'),
                    ],
                  )
              ),
              Image.asset(
                  'assets/images/directions.png'
              ),
              Container(
                margin: EdgeInsets.all(mqw * 0.03),
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(mqw * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_locals.map2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/icon/icon-metro.png',
                            width: mqw * 0.06,
                          ),
                          SizedBox(width: mqw * 0.02,),
                          Expanded(child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_locals.map3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: mqh * 0.02,),
                                Text(_locals.map4, style: TextStyle(fontSize: 18),),
                                SizedBox(height: mqh * 0.02,),
                                Text(_locals.map5, style: TextStyle(fontSize: 18),),
                                SizedBox(height: mqh * 0.02,),
                                Text(_locals.map6, style: TextStyle(fontSize: 18),)
                              ],
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/icon/icon-bus.png',
                            width: mqw * 0.06,
                          ),
                          SizedBox(width: mqw * 0.02,),
                          Expanded(child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_locals.map7, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              SizedBox(height: mqh * 0.02,),
                              Text(_locals.map8, style: TextStyle(fontSize: 18),),
                            ],
                          )
                          )
                        ],
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }


  Widget addressForm(String title, String subTitle, String iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconPath,
          width: mqw * 0.06,
        ),
        SizedBox(width: mqw * 0.02,),
        Expanded(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: mqh * 0.01,),
            Text(subTitle, style: TextStyle(fontSize: 18),)
          ],
        )
        )
      ],
    );
  }
}
