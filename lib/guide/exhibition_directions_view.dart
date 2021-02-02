import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';

class ExhivitDirectionsView extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;
  @override
  Widget build(BuildContext context) {

    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: '오시는 길')
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
                      addressForm('주소', '부산광역시 남구 홍곡로 320번길 100', 'assets/images/icon/icon-location-map.png'),
                      SizedBox(height: mqw * 0.05,),
                      addressForm('연락처', '051-629-8600', 'assets/images/icon/icon-tel.png'),
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
                      Text("교통안내", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
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
                                Text('지하철 이용 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: mqh * 0.02,),
                                Text('부산역 방면 :  부산역(1호선)→서면역(2호선으로 환승)→못골역(2호선, 1번출구)→남구9(마을버스 환승)', style: TextStyle(fontSize: 18),),
                                SizedBox(height: mqh * 0.02,),
                                Text('고속터미널 방면 :  노포동역(1호선)→서면역(2호선 환승)→못골역(2호선, 1번출구)→남구9(마을버스 환승)', style: TextStyle(fontSize: 18),),
                                SizedBox(height: mqh * 0.02,),
                                Text('서부시외버스 터미널 방면 :  사상역(2호선)→못골역(2호선, 1번출구)→남구9(마을버스 환승)', style: TextStyle(fontSize: 18),)
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
                              Text('버스 이용 시 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              SizedBox(height: mqh * 0.02,),
                              Text('부산역 방면 :  부산역(134번)→석포초등학교 정류장 하차(도보 약10분) 부산역(27, 40, 41번)→남구청', style: TextStyle(fontSize: 18),),
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
