import 'package:exhibition_guide_app/model/faq_list_model.dart';
import 'package:exhibition_guide_app/model/faq_list_model.dart' as FLM;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqListView extends StatefulWidget {
  @override
  _FaqListViewState createState() => _FaqListViewState();
}

class _FaqListViewState extends State<FaqListView> {
  var mqd;
  var mqw;
  var mqh;

  MyPageProvider _mypage;
  AppLocalizations _locals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        {Provider.of<MyPageProvider>(context, listen: false).getFaqListSel()});
  }

  Widget _randerListView() {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    final loading = _mypage.loading;
    final FaqListModel list = _mypage.faqList;
    _locals = AppLocalizations.of(context);

    // 로딩중이면서 목록이 없을 때
    if (loading && (list.data.length == 0)) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // 로딩중이 아닌데 목록이 없을 때
    if (!loading && list.data.length == 0) {
      return Center(child: Text('목록이 없습니다.'));
    }

    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _dataItem(list),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    _mypage = Provider.of<MyPageProvider>(context);
    return Container(
      child: _randerListView(),
    );
  }

  List<Widget> _dataItem(FaqListModel list) {
    List<Widget> result = [
      Container(
        height: mqh * 0.08,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: mqw * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(_locals.customer5, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        )
      )
    ];

    if (list.data.length > 0) {
      list.data.forEach((FLM.Data item) {
        result.add(
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: mqw * 0.05, vertical: mqw * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      item.isExpanded = !item.isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: new Text(item.title)),
                      Image.asset(
                        item.isExpanded
                          ? "assets/images/icon/icon-arrow-up.png"
                          : "assets/images/icon/icon-arrow-down.png",
                        width: mqw * 0.03,
                      )
                    ],
                  ),
                ),
                item.isExpanded
                ? Container(
                  color: Color(0xffEAEBEC),
                  width: double.infinity,
                  margin: EdgeInsets.only(top: mqh * 0.03),
                  padding: EdgeInsets.all(mqw * 0.03),
                  child: Text(item.answer),
                )
                : Container()
              ],
            )
          )
        );
      });
    }

    return result;
  }
}
