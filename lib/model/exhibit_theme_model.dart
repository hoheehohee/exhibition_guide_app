class ExhibitThemeModel {
  List<Data> data;

  ExhibitThemeModel({this.data});

  ExhibitThemeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String exhibitionNameEng;
  String subName;
  String exhibitionName;
  String subNameEng;
  String exhibitionCode;
  String mainBackground;
  String exhibitionType;
  String contentEng;
  String listBackground;
  String content;
  String contentJpn;
  String contentChn;
  String location;
  String subNameChn;
  String subNameJpn;
  String exhibitionNameJpn;
  String exhibitionNameChn;

  Data(
      {this.exhibitionNameEng,
        this.subName,
        this.exhibitionName,
        this.subNameEng,
        this.exhibitionCode,
        this.mainBackground,
        this.exhibitionType,
        this.contentEng,
        this.listBackground,
        this.content,
        this.contentJpn,
        this.contentChn,
        this.location,
        this.subNameChn,
        this.subNameJpn,
        this.exhibitionNameJpn,
        this.exhibitionNameChn});

  Data.fromJson(Map<String, dynamic> json) {
    exhibitionNameEng = json['exhibition_name_eng'];
    subName = json['sub_name'];
    exhibitionName = json['exhibition_name'];
    subNameEng = json['sub_name_eng'];
    exhibitionCode = json['exhibition_code'];
    mainBackground = json['mainBackground'];
    exhibitionType = json['exhibition_type'];
    contentEng = json['content_eng'];
    listBackground = json['listBackground'];
    content = json['content'];
    contentJpn = json['content_jpn'];
    contentChn = json['content_chn'];
    location = json['location'];
    subNameChn = json['sub_name_chn'];
    subNameJpn = json['sub_name_jpn'];
    exhibitionNameJpn = json['exhibition_name_jpn'];
    exhibitionNameChn = json['exhibition_name_chn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exhibition_name_eng'] = this.exhibitionNameEng;
    data['sub_name'] = this.subName;
    data['exhibition_name'] = this.exhibitionName;
    data['sub_name_eng'] = this.subNameEng;
    data['exhibition_code'] = this.exhibitionCode;
    data['mainBackground'] = this.mainBackground;
    data['exhibition_type'] = this.exhibitionType;
    data['content_eng'] = this.contentEng;
    data['listBackground'] = this.listBackground;
    data['content'] = this.content;
    data['content_jpn'] = this.contentJpn;
    data['content_chn'] = this.contentChn;
    data['location'] = this.location;
    data['sub_name_chn'] = this.subNameChn;
    data['sub_name_jpn'] = this.subNameJpn;
    data['exhibition_name_jpn'] = this.exhibitionNameJpn;
    data['exhibition_name_chn'] = this.exhibitionNameChn;
    return data;
  }
}
