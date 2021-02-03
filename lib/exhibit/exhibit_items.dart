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
                      ExhibitDetail(2), // 전시 카테고리 상세
                      transition: Transition.fadeIn
                    );
                  },
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 60, right: 20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 50,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Color(0xffA58C60),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Center(child:
                              Text(
                                // !_loading ? getContentType(_exhibit.exhibitItem['contentsType']) : '',
                                  '유물',
                                  style: TextStyle(color: Colors.white, fontSize: 18, height: 1)))
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_exhibitList[index], style: TextStyle(fontSize: 16))
                          )
                        ],
                      )
                  )
              )
          )
      ),
    );
  }
}
