import 'package:exhibition_guide_app/exhibit/permanent_exhibit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitInfoItem extends StatelessWidget {
  ExhibitInfoItem(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 3),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
          ),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title)
          )
      ),
      onTap: () {
        Get.to(
            PermanentExhibitView(),
            transition: Transition.fadeIn
        );
      },
    );
  }
}
