class BookingListModel {
  List<Data> data;
  int bookingCount;

  BookingListModel({this.data, this.bookingCount});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    bookingCount = json['dataCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['bookingCount'] = this.bookingCount;
    return data;
  }
}

class Data {
  String applyNumber;
  String applyDate;
  String applyTime;
  String status;

  Data(
      {this.applyNumber,
        this.applyDate,
        this.applyTime,
        this.status,
      });

  Data.fromJson(Map<String, dynamic> json) {
    applyNumber = json['applyNumber'];
    applyDate = json['applyDate'];
    applyTime = json['applyTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applyNumber'] = this.applyNumber;
    data['applyDate'] = this.applyDate;
    data['applyTime'] = this.applyTime;
    return data;
  }
}
