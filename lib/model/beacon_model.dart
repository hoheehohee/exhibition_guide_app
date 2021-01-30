class BeaconModel {
  String name;
  String uuid;
  String major;
  String minor;
  String rssi;
  String distance;
  String proximity;

  BeaconModel(
      {this.name,
        this.uuid,
        this.major,
        this.minor,
        this.rssi,
        this.distance,
        this.proximity});

  BeaconModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uuid = json['uuid'];
    major = json['major'];
    minor = json['minor'];
    rssi = json['rssi'];
    distance = json['distance'];
    proximity = json['proximity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uuid'] = this.uuid;
    data['major'] = this.major;
    data['minor'] = this.minor;
    data['rssi'] = this.rssi;
    data['distance'] = this.distance;
    data['proximity'] = this.proximity;
    return data;
  }
}
