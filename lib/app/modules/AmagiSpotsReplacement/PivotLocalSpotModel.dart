import 'dart:convert';

class PivotLocalSpotModel {
  LocalSpot? localSpot;

  PivotLocalSpotModel({this.localSpot});

  PivotLocalSpotModel.fromJson(Map<String, dynamic> json) {
    localSpot = json['localSpot'] != null
        ? new LocalSpot.fromJson(json['localSpot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localSpot != null) {
      data['localSpot'] = this.localSpot!.toJson();
    }
    return data;
  }
}

class LocalSpot {
  List<LocalBookingData>? localBookingData;
  List<LocalColData>? localColData;

  LocalSpot({this.localBookingData, this.localColData});

  LocalSpot.fromJson(Map<String, dynamic> json) {
    if (json['localBookingData'] != null) {
      localBookingData = <LocalBookingData>[];
     jsonDecode(json['localBookingData']).forEach((v) {
        localBookingData!.add(LocalBookingData.fromJson(v));
      });
    }
    if (json['localColData'] != null) {
      localColData = <LocalColData>[];
      jsonDecode(json['localColData']).forEach((v) {
        localColData!.add( LocalColData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localBookingData != null) {
      data['localBookingData'] =
          this.localBookingData!.map((v) => v.toJson()).toList();
    }
    if (this.localColData != null) {
      data['localColData'] = this.localColData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalBookingData {
  String? clientName;
  String? parentID;
  String? colNo;
  String? bookingNumber;

  LocalBookingData(
      {this.clientName, this.parentID, this.colNo, this.bookingNumber});

  LocalBookingData.fromJson(Map<String, dynamic> json) {
    clientName = json['ClientName'];
    parentID = json['ParentID'];
    colNo = json['ColNo'];
    bookingNumber = json['BookingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientName'] = this.clientName;
    data['ParentID'] = this.parentID;
    data['ColNo'] = this.colNo;
    data['BookingNumber'] = this.bookingNumber;
    return data;
  }
}

class LocalColData {
  String? colNo;
  String? parentid;
  String? bookingnumber;

  LocalColData({this.colNo, this.parentid, this.bookingnumber});

  LocalColData.fromJson(Map<String, dynamic> json) {
    colNo = json['ColNo'];
    parentid = json['parentid'];
    bookingnumber = json['Bookingnumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColNo'] = this.colNo;
    data['parentid'] = this.parentid;
    data['Bookingnumber'] = this.bookingnumber;
    return data;
  }
}
