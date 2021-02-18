class ApplyCountModel {
  ApplyCountModel({
    this.applyCount=0,
    this.applyEnd=0,
    this.applyNow=0,
  });

  int applyCount;
  int applyEnd;
  int applyNow;

  ApplyCountModel.fromJson(Map<String, dynamic> json) {
      this.applyCount = json['data']['apply_count'];
      this.applyEnd = json['data']['apply_end'];
      this.applyNow = json['data']['apply_now'];
  }
}