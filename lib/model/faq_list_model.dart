class FaqListModel {
  List<Data> data;
  int faqCount;

  FaqListModel({this.data, this.faqCount});

  FaqListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    faqCount = json['faqCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['faqCount'] = this.faqCount;
    return data;
  }
}

class Data {
  String answer;
  int boardIdx;
  String writeDate;
  String title;
  bool isExpanded = false;

  Data(
      {this.answer,
        this.boardIdx,
        this.writeDate,
        this.title,
        this.isExpanded
      });

  Data.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    boardIdx = json['boardIdx'];
    writeDate = json['writeDate'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['boardIdx'] = this.boardIdx;
    data['writeDate'] = this.writeDate;
    data['title'] = this.title;
    return data;
  }
}
