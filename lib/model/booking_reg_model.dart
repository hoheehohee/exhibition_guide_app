class BookingRegModel {
  String name;
  String tel;
  String groupName;
  String groupPersonnel;
  String type1;
  String type2;
  String type3;
  String type4;
  String type5;
  String type6;
  String langType;
  String lang;
  String obstacle;
  String applyDate;
  String applyTime;
  String loginID;

  BookingRegModel(
      {this.name,
        this.tel,
        this.groupName,
        this.groupPersonnel,
        this.type1,
        this.type2,
        this.type3,
        this.type4,
        this.type5,
        this.type6,
        this.langType,
        this.lang,
        this.obstacle,
        this.applyDate,
        this.applyTime,
        this.loginID});

  BookingRegModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tel = json['tel'];
    groupName = json['groupName'];
    groupPersonnel = json['groupPersonnel'];
    type1 = json['type1'];
    type2 = json['type2'];
    type3 = json['type3'];
    type4 = json['type4'];
    type5 = json['type5'];
    type6 = json['type6'];
    langType = json['langType'];
    lang = json['lang'];
    obstacle = json['obstacle'];
    applyDate = json['applyDate'];
    applyTime = json['applyTime'];
    loginID = json['loginID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tel'] = this.tel;
    data['groupName'] = this.groupName;
    data['groupPersonnel'] = this.groupPersonnel;
    data['type1'] = this.type1;
    data['type2'] = this.type2;
    data['type3'] = this.type3;
    data['type4'] = this.type4;
    data['type5'] = this.type5;
    data['type6'] = this.type6;
    data['langType'] = this.langType;
    data['lang'] = this.lang;
    data['obstacle'] = this.obstacle;
    data['applyDate'] = this.applyDate;
    data['applyTime'] = this.applyTime;
    data['loginID'] = this.loginID;
    return data;
  }
}
