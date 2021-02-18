class NoticeDetailModel {
  String writeDate;
  String title;
  String content;

  NoticeDetailModel({this.writeDate, this.title, this.content});

  NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    writeDate = json['writeDate'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['writeDate'] = this.writeDate;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
