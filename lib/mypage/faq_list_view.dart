import 'package:exhibition_guide_app/model/faq_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exhibition_guide_app/provider/mypage_provider.dart';

class FaqListView extends StatefulWidget {
  @override
  _FaqListViewState createState() => _FaqListViewState();
}

class _FaqListViewState extends State<FaqListView> {
  MyPageProvider _mypage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        {Provider.of<MyPageProvider>(context, listen: false).getFaqListSel()});
  }

  Widget _randerListView() {
    final loading = _mypage.loading;
    final FaqListModel list = _mypage.faqList;

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
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              list.data[index].isExpanded = !isExpanded;
            });
          },
          children: list.data.map<ExpansionPanel>((Data item) {
            return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.title),
                  );
                },
              body: ListTile(
                  title: Text(item.answer),
                  onTap: () {
                  }),
                  isExpanded: item.isExpanded,
                );
          }).toList(),
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
}
