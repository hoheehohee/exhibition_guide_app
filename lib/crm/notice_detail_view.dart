import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NoticeDetailView extends StatefulWidget {
  final int noticeIdx;

  NoticeDetailView(this.noticeIdx);

  @override
  _NoticeDetailViewState createState() => _NoticeDetailViewState();
}

class _NoticeDetailViewState extends State<NoticeDetailView> {
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;
  MyPageProvider _mypageProv;

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      Provider.of<MyPageProvider>(context, listen: false).setNoticeDetailSel(widget.noticeIdx);
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
          ? Center(child: CircularProgressIndicator(),)
          : Container(
          color: Color(0xffE7E8E9),
          child: (
            _mypageProv.noticeDetail == null
              ? Container()
              : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  // height: mqh * 0.15,
                  width: double.infinity,
                  padding: EdgeInsets.all(mqw * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_mypageProv.noticeDetail.writeDate, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff7E7F80))),
                      SizedBox(height: mqh * 0.01,),
                      Text(
                        _mypageProv.noticeDetail.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(mqw * 0.05),
                      child: Text(
                        _mypageProv.noticeDetail.content,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff7E7F80)),
                      ),
                    )
                )
              ],
            )
          )
        )
      )
    );
  }
}
