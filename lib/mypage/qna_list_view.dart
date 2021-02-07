import 'package:exhibition_guide_app/crm/qna_view.dart';
import 'package:exhibition_guide_app/model/qna_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Future.microtask(() =>
        {Provider.of<MyPageProvider>(context, listen: false).setQnaListSel()});
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
      return Center(child: Text('목록이 없습니다.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.data.length,
      itemBuilder: (BuildContext context, int index) => (InkWell(
        child: Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  // child: Row(
                  //     mainAxisAlignment:
                  //     MainAxisAlignment.start,
                  //     crossAxisAlignment:
                  //     CrossAxisAlignment.center,
                  //     children: [
                  //     Text(
                  //         list.data[index].questionsDate == null
                  //             ? ''
                  //             : DateFormat('yyyy. MM. dd').format(
                  //                 DateFormat('yyyy-MM-dd')
                  //                     .parse(list.data[index].questionsDate)),
                  //         style: TextStyle(
                  //             fontSize: 16, color: Colors.grey),
                  //       ),
                  //       Visibility(
                  //           visible: 1==1,
                  //           child: Text("답변완료",
                  //               style: TextStyle(
                  //                   color: Colors.grey,
                  //                   fontSize: 16,
                  //                   fontWeight:
                  //                   FontWeight.w600))),
                  //     ]
                  // )),
                  // Text(list.data[index].questions,
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              list.data[index].questionsDate == null
                                  ? ''
                                  : DateFormat('yyyy. MM. dd').format(
                                      DateFormat('yyyy-MM-dd').parse(
                                          list.data[index].questionsDate)),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Visibility(
                                visible: list.data[index].answers != null && list.data[index].answers != "" ,
                                child: Container(
                                    width: 70,
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Center(
                                        child: Text("답변완료",
                                            style: TextStyle(
                                                color: Colors.white)))))
                          ]),
                          Text(list.data[index].questions,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ],
                      )),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ])),
        onTap: () {
          Get.to(QnaDetail(list.data[index].qnaID),
              transition: Transition.fadeIn);
        },
      )),
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
