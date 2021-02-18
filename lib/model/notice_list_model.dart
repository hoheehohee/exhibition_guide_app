class NoticeListModel {
  List<Data> data;
  int noticeCount;

  NoticeListModel({this.data, this.noticeCount});

  NoticeListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    noticeCount = json['noticeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['noticeCount'] = this.noticeCount;
    return data;
  }
}

class Data {
  int boardIdx;
  String writeDate;
  String title;
  String content;

  Data({this.boardIdx, this.writeDate, this.title, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    boardIdx = json['boardIdx'];
    writeDate = json['writeDate'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boardIdx'] = this.boardIdx;
    data['writeDate'] = this.writeDate;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
