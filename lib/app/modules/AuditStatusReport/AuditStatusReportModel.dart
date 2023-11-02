class AuditStatusReportModel {
  List<Audit>? audit;

  AuditStatusReportModel({this.audit});

  AuditStatusReportModel.fromJson(Map<String, dynamic> json) {
    if (json['audit'] != null) {
      audit = <Audit>[];
      json['audit'].forEach((v) {
        audit!.add(new Audit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    /*if (this.audit != null) {
      data['audit'] = this.audit!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Audit {
  String? channelName;
  int? bookingmonth;
  int? bookingnumber;
  String? zonename;
  String? clientname;
  String? agencyName;
  String? bookedAMount;
  String? payRouteName;
  String? bookingno;
  String? reveuneType;
  String? panCardNo;
  String? agencyGSTNumber;
  String? plantName;
  String? bookedby;
  String? bookedon;
  String? bookedTime;
  String? verifiedby;
  String? verifiedTime;
  String? verifieddate;
  String? auditedBy;
  String? auditedOn;
  String? auditedTime;
  double? valuationAmountINR;
  int? noOfSpotAudited;
  int? totalDuration;

  Audit(
      {this.channelName,
        this.bookingmonth,
        this.bookingnumber,
        this.zonename,
        this.clientname,
        this.agencyName,
        this.bookedAMount,
        this.payRouteName,
        this.bookingno,
        this.reveuneType,
        this.panCardNo,
        this.agencyGSTNumber,
        this.plantName,
        this.bookedby,
        this.bookedon,
        this.bookedTime,
        this.verifiedby,
        this.verifiedTime,
        this.verifieddate,
        this.auditedBy,
        this.auditedOn,
        this.auditedTime,
        this.valuationAmountINR,
        this.noOfSpotAudited,
        this.totalDuration});

  Audit.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    bookingmonth = json['bookingmonth'];
    bookingnumber = json['bookingnumber'];
    zonename = json['zonename'];
    clientname = json['clientname'];
    agencyName = json['agencyName'];
    bookedAMount = (json['bookedAMount']??json["BookedAMount"]??"0").toString();
    payRouteName = json['payRouteName'];
    bookingno = json['bookingno'];
    reveuneType = json['reveuneType'];
    panCardNo = json['panCardNo'];
    agencyGSTNumber = json['agencyGSTNumber'];
    plantName = json['plantName'];
    bookedby = json['bookedby'];
    bookedon = json['bookedon'];
    bookedTime = json['bookedTime'];
    verifiedby = json['verifiedby'];
    verifiedTime = json['verifiedTime'];
    verifieddate = json['verifieddate'];
    auditedBy = json['auditedBy'];
    auditedOn = json['auditedOn'];
    auditedTime = json['auditedTime'];
    valuationAmountINR = json['valuationAmountINR'];
    noOfSpotAudited = json['noOfSpotAudited'];
    totalDuration = json['totalDuration'];
  }

  Map<String, dynamic> toJson(String? val) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   /* switch(val){
      case "1":
        break;
      case "2":

        break;
      case "3":
        break;
    }*/
    data['channelName'] = this.channelName;
    data['bookingmonth'] = this.bookingmonth;
    data['bookingnumber'] = this.bookingnumber;
    data['zonename'] = this.zonename;
    data['clientname'] = this.clientname;
    data['agencyName'] = this.agencyName;
    data['bookedAMount'] = this.bookedAMount;
    data['payRouteName'] = this.payRouteName;
    data['bookingno'] = this.bookingno;
    data['reveuneType'] = this.reveuneType;
    data['panCardNo'] = this.panCardNo;
    data['agencyGSTNumber'] = this.agencyGSTNumber;
    data['plantName'] = this.plantName;
    data['bookedby'] = this.bookedby;
    data['bookedon'] = this.bookedon;
    data['bookedTime'] = this.bookedTime;
    data['verifiedby'] = this.verifiedby;
    data['verifiedTime'] = this.verifiedTime;
    data['verifieddate'] = this.verifieddate;
    data['auditedBy'] = this.auditedBy;
    data['auditedOn'] = this.auditedOn;
    data['auditedTime'] = this.auditedTime;
 /*   data['valuationAmountINR'] = this.valuationAmountINR;
    data['noOfSpotAudited'] = this.noOfSpotAudited;
    data['totalDuration'] = this.totalDuration;*/
    return data;
  }
}
