import 'package:flutter/material.dart';
import 'package:image_ink_well/image_ink_well.dart';

class ExhibitCategoryItem extends StatelessWidget {
  ExhibitCategoryItem(this.title, this.imageUrl);
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 3, left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ImageInkWell(
              width: double.infinity,
              height: 50,
              image: NetworkImage(imageUrl),
              onPressed: () {}
          ),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}


// Container(
// height: 50,
// margin: EdgeInsets.only(bottom: 3, left: 10, right: 10),
// padding: EdgeInsets.symmetric(horizontal: 5),
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(imageUrl),
// fit: BoxFit.cover
// ),
// ),
// child:
// ),