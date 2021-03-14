import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  CustomMainButton({
    Key key,
    this.onTap,
    this.imgPath,
    this.title
  }) : super(key: key);

  final onTap;
  final imgPath;
  final title;

  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: mqw * 0.28,
        height: mqh * 0.13,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath, height: mqh * 0.06, fit: BoxFit.fill,),
            SizedBox(height: 10,),
            Text(
              title,
              style: TextStyle(fontSize: mqw * 0.03, color: Color(0xff546573), fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
