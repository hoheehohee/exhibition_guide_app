import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_ink_well/image_ink_well.dart';

class PermanentExhibitItem extends StatelessWidget {

  PermanentExhibitItem(this.title, this.idx, this.imageUrl);
  final String title;
  final int idx;
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
                onPressed: () {
                  Get.to(
                      ExhibitDetail(this.idx),
                      transition: Transition.fadeIn
                  );
                }
            ),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
          ],
        )
    );
  }
}
