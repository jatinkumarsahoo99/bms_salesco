class AuditStatusGenerateToList {
  List<ToList>? toList;

  AuditStatusGenerateToList({this.toList});

  AuditStatusGenerateToList.fromJson(Map<String, dynamic> json) {
    if (json['toList'] != null) {
      toList = <ToList>[];
      json['toList'].forEach((v) {
        toList!.add(new ToList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.toList != null) {
      data['toList'] = this.toList!.map((v) => v.toJson()).toList();
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
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['zonename'] = this.zonename;
    data['bookingnumber'] = this.bookingnumber;
    return data;
  }
}
