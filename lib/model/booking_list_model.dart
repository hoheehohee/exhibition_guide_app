class BookingListModel {
  List<Data> data;
  String state;
  int dataCount;

  BookingListModel({this.data, this.state, this.dataCount});

  BookingListModel.fromJson(Map<String, dynamic> json) {
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
  String type5;
  String type4;
  String type3;
  String type2;
  String type6;
  String langType;
  String type1;
  String groupPersonnel;
  int applyID;
  String groupName;
  String name;
  String tel;
  String lang;
  String applyDate;
  String applyTime;
  String obstacle;
  String applyNumber;
  String status;

  Data(
      {this.type5,
        this.type4,
        this.type3,
        this.type2,
        this.type6,
        this.langType,
        this.type1,
        this.groupPersonnel,
        this.applyID,
        this.groupName,
        this.name,
        this.tel,
        this.lang,
        this.applyDate,
        this.applyTime,
        this.obstacle,
        this.applyNumber,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    type5 = json['type5'];
    type4 = json['type4'];
    type3 = json['type3'];
    type2 = json['type2'];
    type6 = json['type6'];
    langType = json['langType'];
    type1 = json['type1'];
    groupPersonnel = json['groupPersonnel'];
    applyID = json['applyID'];
    groupName = json['groupName'];
    name = json['name'];
    tel = json['tel'];
    lang = json['lang'];
    applyDate = json['applyDate'];
    applyTime = json['applyTime'];
    obstacle = json['obstacle'];
    applyNumber = json['applyNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type5'] = this.type5;
    data['type4'] = this.type4;
    data['type3'] = this.type3;
    data['type2'] = this.type2;
    data['type6'] = this.type6;
    data['langType'] = this.langType;
    data['type1'] = this.type1;
    data['groupPersonnel'] = this.groupPersonnel;
    data['applyID'] = this.applyID;
    data['groupName'] = this.groupName;
    data['name'] = this.name;
    data['tel'] = this.tel;
    data['lang'] = this.lang;
    data['applyDate'] = this.applyDate;
    data['applyTime'] = this.applyTime;
    data['obstacle'] = this.obstacle;
    data['applyNumber'] = this.applyNumber;
    data['status'] = this.status;
    return data;
  }
}
