import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/crm/notice_detail_view.dart';
import 'package:exhibition_guide_app/model/notice_list_model.dart' as NLM;
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NoticeListView extends StatefulWidget {

  @override
  _NoticeListViewState createState() => _NoticeListViewState();
}

class _NoticeListViewState extends State<NoticeListView> {

  var mqd;
  var mqw;
  var mqh;

  AppLocalizations _locals;
  MyPageProvider _mypageProv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      Provider.of<MyPageProvider>(context, listen: false).setNoticeListSel();
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _locals = AppLocalizations.of(context);
    _mypageProv = Provider.of<MyPageProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mqd.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.main10)
      ),
      body: (
        _mypageProv.loading
          ? Center( child: CircularProgressIndicator(),)
          : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _noticeItems()
          ),
        )
      )
    );
  }

  List<Widget> _noticeItems() {
    List<Widget> result = [];
    _mypageProv.noticeList.data.forEach((NLM.Data item) {
      result.add(
          Container(
              height: mqh * 0.12,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(NoticeDetailView(item.boardIdx), transition: Transition.fadeIn);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.writeDate, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff7E7F80))),
                              SizedBox(height: mqh * 0.01,),
                              Text(
                                item.title,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Image.asset("assets/images/icon/icon-arrow-notice.png", height: mqh * 0.03,)
                      ),
                    ]
                ),
              )
          )
      );
    });

    return result;
  }
}
