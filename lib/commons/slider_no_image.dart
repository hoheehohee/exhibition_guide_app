import 'package:flutter/material.dart';

class SliderNoImage extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {

    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    return Center(
      child: Container(
          width: mqw * 0.79,
          height: mqh * 0.29,
          decoration: BoxDecoration(
            color: Color(0xffA0A0A0),
            // borderRadius: BorderRadius.circular((mqw * 0.03)),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icon/icon-noimage.png",
                    fit: BoxFit.fill,
                    width: mqw * 0.2,
                  ),
                  SizedBox(height: mqh * 0.02,),
                  Text(
                      "No data",
                      style: TextStyle(fontSize: mqw * 0.05, fontWeight: FontWeight.w600, color: Color(0xff2D4357))
                  )
                ],
              )
          )
      ),
    );
  }
}
