import 'package:exhibition_guide_app/category/category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(this.title);
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
          CategoryView(),
          transition: Transition.fadeIn
        );
      },
    );
  }
}