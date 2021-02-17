class ExhibitItemModel {
  Data data;
  String state;

  ExhibitItemModel({this.data, this.state});

  ExhibitItemModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['state'] = this.state;
    return data;
  }
}

class Data {
  String exhibitionType;
  String titleEng;
  String qryn;
  String videoFileChn;
  String beaconMinorID;
  String videoFileJpn;
  String subNameEng;
  String exhibitionCode;
  String qrID;
  String beaconId;
  String voiceFileEng;
  String contentEng;
  String title;
  String content;
  String qrImgFile;
  String voiceFileJpn;
  String locationFile;
  String highlightOrder;
  String contentsImgFile;
  String contentsType;
  String subNameChn;
  String subNameJpn;
  String exhibitionNameJpn;
  String exhibitionNameChn;
  String voiceFileChn;
  String exhibitionNameEng;
  String qrUrl;
  String subName;
  String exhibitionName;
  String viewYN;
  String beaconyn;
  String contentJpn;
  String contentChn;
  String voiceFile;
  String videoFileEng;
  String titleChn;
  String titleJpn;
  String location;
  String beaconMajorID;
  String videoFile;
  int idx;
  String highlightYN;

  Data(
      {this.exhibitionType,
        this.titleEng,
        this.qryn,
        this.videoFileChn,
        this.beaconMinorID,
        this.videoFileJpn,
        this.subNameEng,
        this.exhibitionCode,
        this.qrID,
        this.beaconId,
        this.voiceFileEng,
        this.contentEng,
        this.title,
        this.content,
        this.qrImgFile,
        this.voiceFileJpn,
        this.locationFile,
        this.highlightOrder,
        this.contentsImgFile,
        this.contentsType,
        this.subNameChn,
        this.subNameJpn,
        this.exhibitionNameJpn,
        this.exhibitionNameChn,
        this.voiceFileChn,
        this.exhibitionNameEng,
        this.qrUrl,
        this.subName,
        this.exhibitionName,
        this.viewYN,
        this.beaconyn,
        this.contentJpn,
        this.contentChn,
        this.voiceFile,
        this.videoFileEng,
        this.titleChn,
        this.titleJpn,
        this.location,
        this.beaconMajorID,
        this.videoFile,
        this.idx,
        this.highlightYN});

  Data.fromJson(Map<String, dynamic> json) {
    exhibitionType = json['exhibitionType'];
    titleEng = json['title_eng'];
    qryn = json['qryn'];
    videoFileChn = json['videoFile_chn'];
    beaconMinorID = json['beaconMinorID'];
    videoFileJpn = json['videoFile_jpn'];
    subNameEng = json['sub_name_eng'];
    exhibitionCode = json['exhibition_code'];
    qrID = json['qrID'];
    beaconId = json['beaconId'];
    voiceFileEng = json['voiceFile_eng'];
    contentEng = json['content_eng'];
    title = json['title'];
    content = json['content'];
    qrImgFile = json['qrImgFile'];
    voiceFileJpn = json['voiceFile_jpn'];
    locationFile = json['locationFile'];
    highlightOrder = json['highlightOrder'];
    contentsImgFile = json['contentsImgFile'];
    contentsType = json['contentsType'];
    subNameChn = json['sub_name_chn'];
    subNameJpn = json['sub_name_jpn'];
    exhibitionNameJpn = json['exhibition_name_jpn'];
    exhibitionNameChn = json['exhibition_name_chn'];
    voiceFileChn = json['voiceFile_chn'];
    exhibitionNameEng = json['exhibition_name_eng'];
    qrUrl = json['qrUrl'];
    subName = json['sub_name'];
    exhibitionName = json['exhibition_name'];
    viewYN = json['viewYN'];
    beaconyn = json['beaconyn'];
    contentJpn = json['content_jpn'];
    contentChn = json['content_chn'];
    voiceFile = json['voiceFile'];
    videoFileEng = json['videoFile_eng'];
    titleChn = json['title_chn'];
    titleJpn = json['title_jpn'];
    location = json['location'];
    beaconMajorID = json['beaconMajorID'];
    videoFile = json['videoFile'];
    idx = json['idx'];
    highlightYN = json['highlightYN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exhibitionType'] = this.exhibitionType;
    data['title_eng'] = this.titleEng;
    data['qryn'] = this.qryn;
    data['videoFile_chn'] = this.videoFileChn;
    data['beaconMinorID'] = this.beaconMinorID;
    data['videoFile_jpn'] = this.videoFileJpn;
    data['sub_name_eng'] = this.subNameEng;
    data['exhibition_code'] = this.exhibitionCode;
    data['qrID'] = this.qrID;
    data['beaconId'] = this.beaconId;
    data['voiceFile_eng'] = this.voiceFileEng;
    data['content_eng'] = this.contentEng;
    data['title'] = this.title;
    data['content'] = this.content;
    data['qrImgFile'] = this.qrImgFile;
    data['voiceFile_jpn'] = this.voiceFileJpn;
    data['locationFile'] = this.locationFile;
    data['highlightOrder'] = this.highlightOrder;
    data['contentsImgFile'] = this.contentsImgFile;
    data['contentsType'] = this.contentsType;
    data['sub_name_chn'] = this.subNameChn;
    data['sub_name_jpn'] = this.subNameJpn;
    data['exhibition_name_jpn'] = this.exhibitionNameJpn;
    data['exhibition_name_chn'] = this.exhibitionNameChn;
    data['voiceFile_chn'] = this.voiceFileChn;
    data['exhibition_name_eng'] = this.exhibitionNameEng;
    data['qrUrl'] = this.qrUrl;
    data['sub_name'] = this.subName;
    data['exhibition_name'] = this.exhibitionName;
    data['viewYN'] = this.viewYN;
    data['beaconyn'] = this.beaconyn;
    data['content_jpn'] = this.contentJpn;
    data['content_chn'] = this.contentChn;
    data['voiceFile'] = this.voiceFile;
    data['videoFile_eng'] = this.videoFileEng;
    data['title_chn'] = this.titleChn;
    data['title_jpn'] = this.titleJpn;
    data['location'] = this.location;
    data['beaconMajorID'] = this.beaconMajorID;
    data['videoFile'] = this.videoFile;
    data['idx'] = this.idx;
    data['highlightYN'] = this.highlightYN;
    return data;
  }
}
