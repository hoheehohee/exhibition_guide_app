class ExhibitThemeItemModel {
  String title;
  String titleEng;
  String titleChn;
  String titleJpn;
  String subTitle;
  String subTitleEng;
  String subTitleChn;
  String subTitleJpn;
  String content;
  String contentEng;
  String contentChn;
  String contentJpn;
  String exhibitionCode;
  String imgPath;
  bool isOpen;

  ExhibitThemeItemModel(
      {this.title,
        this.titleEng,
        this.titleChn,
        this.titleJpn,
        this.subTitle,
        this.subTitleEng,
        this.subTitleChn,
        this.subTitleJpn,
        this.content,
        this.contentEng,
        this.contentChn,
        this.contentJpn,
        this.exhibitionCode,
        this.imgPath,
        this.isOpen});

  ExhibitThemeItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleEng = json['title_eng'];
    titleChn = json['title_chn'];
    titleJpn = json['title_jpn'];
    subTitle = json['subTitle'];
    subTitleEng = json['subTitle_eng'];
    subTitleChn = json['subTitle_chn'];
    subTitleJpn = json['subTitle_jpn'];
    content = json['content'];
    contentEng = json['content_eng'];
    contentChn = json['content_chn'];
    contentJpn = json['content_jpn'];
    exhibitionCode = json['exhibition_code'];
    imgPath = json['imgPath'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_eng'] = this.titleEng;
    data['title_chn'] = this.titleChn;
    data['title_jpn'] = this.titleJpn;
    data['subTitle'] = this.subTitle;
    data['subTitle_eng'] = this.subTitleEng;
    data['subTitle_chn'] = this.subTitleChn;
    data['subTitle_jpn'] = this.subTitleJpn;
    data['content'] = this.content;
    data['content_eng'] = this.contentEng;
    data['content_chn'] = this.contentChn;
    data['content_jpn'] = this.contentJpn;
    data['exhibition_code'] = this.exhibitionCode;
    data['imgPath'] = this.imgPath;
    data['isOpen'] = this.isOpen;
    return data;
  }
}
