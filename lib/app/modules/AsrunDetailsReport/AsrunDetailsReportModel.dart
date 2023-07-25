class AsrunDetailsReportModel {
  List<Generate>? generate;

  AsrunDetailsReportModel({this.generate});

  AsrunDetailsReportModel.fromJson(Map<String, dynamic> json) {
    if (json['generate'] != null) {
      generate = <Generate>[];
      json['generate'].forEach((v) {
        generate!.add(new Generate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generate != null) {
      data['generate'] = this.generate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Generate {
  String? locationname;
  String? channelname;
  String? eventDate;
  String? telecastdate;
  String? ratingDate;
  int? eventNo;
  String? starttime;
  String? endtime;
  String? duration;
  int? tapeDuration;
  String? asrunCaption;
  String? tapeid;
  int? segno;
  String? eventType;
  String? programname;
  String? fpctime;
  String? bookingNumber;
  String? agencyROnumber;
  int? bookingDetailCode;
  String? clientName;
  String? agencyName;
  String? brandName;
  int? bookedDuration;
  int? breakNumber;
  int? spotPositionNumber;
  String? positionCode;
  String? personnelName;
  String? zoneName;
  String? dealNumber;
  int? recordnumber;
  String? spotType;
  String? accountname;
  String? productName;
  String? sTationname;
  String? ratingTime;
  String? telecastTimeBand;
  String? flightingCode;

  Generate(
      {this.locationname,
        this.channelname,
        this.eventDate,
        this.telecastdate,
        this.ratingDate,
        this.eventNo,
        this.starttime,
        this.endtime,
        this.duration,
        this.tapeDuration,
        this.asrunCaption,
        this.tapeid,
        this.segno,
        this.eventType,
        this.programname,
        this.fpctime,
        this.bookingNumber,
        this.agencyROnumber,
        this.bookingDetailCode,
        this.clientName,
        this.agencyName,
        this.brandName,
        this.bookedDuration,
        this.breakNumber,
        this.spotPositionNumber,
        this.positionCode,
        this.personnelName,
        this.zoneName,
        this.dealNumber,
        this.recordnumber,
        this.spotType,
        this.accountname,
        this.productName,
        this.sTationname,
        this.ratingTime,
        this.telecastTimeBand,
        this.flightingCode});

  Generate.fromJson(Map<String, dynamic> json) {
    locationname = json['locationname'];
    channelname = json['channelname'];
    eventDate = json['eventDate'];
    telecastdate = json['telecastdate'];
    ratingDate = json['ratingDate'];
    eventNo = json['eventNo'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    duration = json['duration'];
    tapeDuration = json['tapeDuration'];
    asrunCaption = json['asrunCaption'];
    tapeid = json['tapeid'];
    segno = json['segno'];
    eventType = json['eventType'];
    programname = json['programname'];
    fpctime = json['fpctime'];
    bookingNumber = json['bookingNumber'];
    agencyROnumber = json['agencyROnumber'];
    bookingDetailCode = json['bookingDetailCode'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    brandName = json['brandName'];
    bookedDuration = json['bookedDuration'];
    breakNumber = json['breakNumber'];
    spotPositionNumber = json['spotPositionNumber'];
    positionCode = json['positionCode'];
    personnelName = json['personnelName'];
    zoneName = json['zoneName'];
    dealNumber = json['dealNumber'];
    recordnumber = json['recordnumber'];
    spotType = json['spotType'];
    accountname = json['accountname'];
    productName = json['productName'];
    sTationname = json['sTationname'];
    ratingTime = json['ratingTime'];
    telecastTimeBand = json['telecastTimeBand'];
    flightingCode = json['flightingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['eventDate'] = this.eventDate;
    data['telecastdate'] = this.telecastdate;
    data['ratingDate'] = this.ratingDate;
    data['eventNo'] = this.eventNo;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['duration'] = this.duration;
    data['tapeDuration'] = this.tapeDuration;
    data['asrunCaption'] = this.asrunCaption;
    data['tapeid'] = this.tapeid;
    data['segno'] = this.segno;
    data['eventType'] = this.eventType;
    data['programname'] = this.programname;
    data['fpctime'] = this.fpctime;
    data['bookingNumber'] = this.bookingNumber;
    data['agencyROnumber'] = this.agencyROnumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    data['brandName'] = this.brandName;
    data['bookedDuration'] = this.bookedDuration;
    data['breakNumber'] = this.breakNumber;
    data['spotPositionNumber'] = this.spotPositionNumber;
    data['positionCode'] = this.positionCode;
    data['personnelName'] = this.personnelName;
    data['zoneName'] = this.zoneName;
    data['dealNumber'] = this.dealNumber;
    data['recordnumber'] = this.recordnumber;
    data['spotType'] = this.spotType;
    data['accountname'] = this.accountname;
    data['productName'] = this.productName;
    data['sTationname'] = this.sTationname;
    data['ratingTime'] = this.ratingTime;
    data['telecastTimeBand'] = this.telecastTimeBand;
    data['flightingCode'] = this.flightingCode;
    return data;
  }
}
