class QnaListModel {
  List<Data> data;
  String state;
  int dataCount;

  QnaListModel({this.data, this.state, this.dataCount});

  QnaListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    state = json['state'];
    dataCount = json['dataCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['state'] = this.state;
    data['dataCount'] = this.dataCount;
    return data;
  }
}

class Data {
  String questionsDate;
  int qnaID;
  String questions;
  int rowNumber;
  String answerDate;
  String answers;

  Data(
      {this.questionsDate,
        this.qnaID,
        this.questions,
        this.rowNumber,
        this.answerDate,
        this.answers});

  Data.fromJson(Map<String, dynamic> json) {
    questionsDate = json['questionsDate'];
    qnaID = json['qnaID'];
    questions = json['questions'];
    rowNumber = json['rowNumber'];
    answerDate = json['answerDate'];
    answers = json['answers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionsDate'] = this.questionsDate;
    data['qnaID'] = this.qnaID;
    data['questions'] = this.questions;
    data['rowNumber'] = this.rowNumber;
    data['answerDate'] = this.answerDate;
    data['answers'] = this.answers;
    return data;
  }
}
