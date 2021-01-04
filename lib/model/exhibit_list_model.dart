class ExhibitListModel {
  List<ExhibitItem> exhibitItem;
  ExhibitListModel({this.exhibitItem});

  ExhibitListModel.fromJson(Map<String, dynamic> json) {
    if (json['exhibitItem'] != null) {
      exhibitItem = new List<ExhibitItem>();
      json['exhibitItem'].forEach((v) {
        exhibitItem.add(new ExhibitItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exhibitItem != null) {
      data['exhibitItem'] = this.exhibitItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExhibitItem {
  String titleEng;
  String qryn;
  String videoFileChn;
  String videoFileJpn;
  String subNameEng;
  String exhibitionCode;
  String beaconId;
  String voiceFileEng;
  String contentEng;
  String title;
  String content;
  String voiceFileJpn;
  String locationFile;
  String subNameChn;
  String subNameJpn;
  String exhibitionNameJpn;
  String exhibitionNameChn;
  String voiceFileChn;
  String exhibitionNameEng;
  String subName;
  String exhibitionName;
  String beaconyn;
  String contentJpn;
  String contentChn;
  String voiceFile;
  String videoFileEng;
  String titleChn;
  String titleJpn;
  String videoFile;
  int idx;

  ExhibitItem(
      {this.titleEng,
        this.qryn,
        this.videoFileChn,
        this.videoFileJpn,
        this.subNameEng,
        this.exhibitionCode,
        this.beaconId,
        this.voiceFileEng,
        this.contentEng,
        this.title,
        this.content,
        this.voiceFileJpn,
        this.locationFile,
        this.subNameChn,
        this.subNameJpn,
        this.exhibitionNameJpn,
        this.exhibitionNameChn,
        this.voiceFileChn,
        this.exhibitionNameEng,
        this.subName,
        this.exhibitionName,
        this.beaconyn,
        this.contentJpn,
        this.contentChn,
        this.voiceFile,
        this.videoFileEng,
        this.titleChn,
        this.titleJpn,
        this.videoFile,
        this.idx});

  ExhibitItem.fromJson(Map<String, dynamic> json) {
    titleEng = json['title_eng'];
    qryn = json['qryn'];
    videoFileChn = json['videoFile_chn'];
    videoFileJpn = json['videoFile_jpn'];
    subNameEng = json['sub_name_eng'];
    exhibitionCode = json['exhibition_code'];
    beaconId = json['beaconId'];
    voiceFileEng = json['voiceFile_eng'];
    contentEng = json['content_eng'];
    title = json['title'];
    content = json['content'];
    voiceFileJpn = json['voiceFile_jpn'];
    locationFile = json['locationFile'];
    subNameChn = json['sub_name_chn'];
    subNameJpn = json['sub_name_jpn'];
    exhibitionNameJpn = json['exhibition_name_jpn'];
    exhibitionNameChn = json['exhibition_name_chn'];
    voiceFileChn = json['voiceFile_chn'];
    exhibitionNameEng = json['exhibition_name_eng'];
    subName = json['sub_name'];
    exhibitionName = json['exhibition_name'];
    beaconyn = json['beaconyn'];
    contentJpn = json['content_jpn'];
    contentChn = json['content_chn'];
    voiceFile = json['voiceFile'];
    videoFileEng = json['videoFile_eng'];
    titleChn = json['title_chn'];
    titleJpn = json['title_jpn'];
    videoFile = json['videoFile'];
    idx = json['idx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title_eng'] = this.titleEng;
    data['qryn'] = this.qryn;
    data['videoFile_chn'] = this.videoFileChn;
    data['videoFile_jpn'] = this.videoFileJpn;
    data['sub_name_eng'] = this.subNameEng;
    data['exhibition_code'] = this.exhibitionCode;
    data['beaconId'] = this.beaconId;
    data['voiceFile_eng'] = this.voiceFileEng;
    data['content_eng'] = this.contentEng;
    data['title'] = this.title;
    data['content'] = this.content;
    data['voiceFile_jpn'] = this.voiceFileJpn;
    data['locationFile'] = this.locationFile;
    data['sub_name_chn'] = this.subNameChn;
    data['sub_name_jpn'] = this.subNameJpn;
    data['exhibition_name_jpn'] = this.exhibitionNameJpn;
    data['exhibition_name_chn'] = this.exhibitionNameChn;
    data['voiceFile_chn'] = this.voiceFileChn;
    data['exhibition_name_eng'] = this.exhibitionNameEng;
    data['sub_name'] = this.subName;
    data['exhibition_name'] = this.exhibitionName;
    data['beaconyn'] = this.beaconyn;
    data['content_jpn'] = this.contentJpn;
    data['content_chn'] = this.contentChn;
    data['voiceFile'] = this.voiceFile;
    data['videoFile_eng'] = this.videoFileEng;
    data['title_chn'] = this.titleChn;
    data['title_jpn'] = this.titleJpn;
    data['videoFile'] = this.videoFile;
    data['idx'] = this.idx;
    return data;
  }
}
