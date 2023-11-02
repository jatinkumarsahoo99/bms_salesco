class AuditStatusGenerateToList {
  List<ToList>? listData;

  AuditStatusGenerateToList({this.listData});

  AuditStatusGenerateToList.fromJson(Map<String, dynamic> json) {
    if (json['toList'] != null) {
      listData = <ToList>[];
      json['toList'].forEach((v) {
        listData!.add(new ToList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listData != null) {
      data['toList'] = this.listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToList {
  String? locationname;
  String? channelname;
  String? clientname;
  String? agencyname;
  String? zonename;
  String? bookingnumber;

  ToList(
      {this.locationname,
        this.channelname,
        this.clientname,
        this.agencyname,
        this.zonename,
        this.bookingnumber});

  ToList.fromJson(Map<String, dynamic> json) {
    locationname = json['locationname'];
    channelname = json['channelname'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    zonename = json['zonename'];
    bookingnumber = json['bookingnumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelname'] = this.channelname;
    data['locationname'] = this.locationname;
    data['bookingnumber'] = this.bookingnumber;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['zonename'] = this.zonename;
    return data;
  }
}
