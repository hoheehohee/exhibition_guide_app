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


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath, width: 47, height: 47, fit: BoxFit.fill,),
            SizedBox(height: 10,),
            Text(
                title,
                style: TextStyle(fontSize: 18, color: Color(0xff546573), fontWeight: FontWeight.w500)
            )
          ],
        ),
      ),
    );
  }
}
