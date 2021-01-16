import 'package:exhibition_guide_app/model/qna_list_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';

class QnaListView extends StatefulWidget {
  @override
  _QnaListViewState createState() => _QnaListViewState();
}

class _QnaListViewState extends State<QnaListView> {

  MyPageProvider _mypage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<MyPageProvider>(context, listen: false).setQnaListSel()
    });
  }

  Widget _randerListView() {
      final loading = _mypage.loading;
      final QnaListModel list = _mypage.qnaList;

      // 로딩중이면서 목록이 없을 때
      if (loading && (list.data.length == 0)) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      // 로딩중이 아닌데 목록이 없을 때
      if (!loading && list.data.length == 0) {
        return Center(
            child: Text('목록이 없습니다.')
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.data.length,
        itemBuilder: (BuildContext context, int index) => (
            Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  list.data[index].questionsDate == null
                                      ? ''
                                      : DateFormat('yyyy. MM. dd').format(DateFormat('yyyy-MM-dd').parse(list.data[index].questionsDate)),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              ),
                              Text(list.data[index].questions, style: TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
                          )
                      ),
                      Divider(color: Colors.grey.withOpacity(0.3),),
                    ]
                )
            )
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    _mypage = Provider.of<MyPageProvider>(context);
    return Container(
      child: _randerListView(),
    );
  }
}
