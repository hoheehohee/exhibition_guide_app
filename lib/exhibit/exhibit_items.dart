import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> _exhibitList = ['등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물5', '등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물5', '등록전시물1'];
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 18),
      itemCount: _exhibitList.length,
      itemBuilder: (BuildContext context, int index) => (
          Material(
              child: InkWell(
                  onTap: () {
                    Get.to(
                      ExhibitDetail(),
                      transition: Transition.fadeIn
                    );
                  },
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 60, right: 20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(_exhibitList[index], style: TextStyle(fontSize: 16))
                      )
                  )
              )
          )
      ),
    );
  }
}
