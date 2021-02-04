import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitItems extends StatelessWidget {

  var mqd;
  var mqw;
  var mqh;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    final List<String> _exhibitList = ['등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물5', '등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물1', '등록전시물2', '등록전시물3', '등록전시물4', '등록전시물5', '등록전시물1'];
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 18),
      itemCount: _exhibitList.length,
      itemBuilder: (BuildContext context, int index) => (
          Container(
              height: mqh * 0.1,
              padding: EdgeInsets.only(left: mqw * 0.06),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: mqw * 0.12,
                      height: mqh * 0.035,
                      decoration: BoxDecoration(
                          color: Color(0xffA58C60),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(child:
                      Text(
                        // !_loading ? getContentType(_exhibit.exhibitItem['contentsType']) : '',
                          '유물',
                          style: TextStyle(color: Colors.white, fontSize: 16, height: 1)))
                  ),
                  SizedBox(width: 10,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(_exhibitList[index], style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
                  )
                ],
              )
          )
      ),
    );
  }
}
