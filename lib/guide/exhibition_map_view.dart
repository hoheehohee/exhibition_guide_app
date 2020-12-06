import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitionMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.2),
          leading: Builder(
            builder: (BuildContext context) => (
              IconButton(
                icon: Icon(Icons.clear, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              )
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            "assets/images/exhibition_map.jpg",
            fit: BoxFit.fill,
          ),
        )
    );
  }
}
