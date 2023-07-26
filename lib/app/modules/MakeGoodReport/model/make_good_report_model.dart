class MakeGoodReportModel {
  String? message;
  String? bookingNumber;
  int? bookingDetailCode;
  String? dealno;
  int? recordnumber;
  String? programName;
  String? scheduleDate;
  String? scheduletime;
  String? endTime;
  String? clientName;
  String? agencyname;
  String? bookingreferencenumber;
  String? brandName;
  String? exportTapeCode;
  String? commercialcaption;
  int? tapeDuration;
  int? spotAmount;
  int? er;
  String? sponsorTypeName;
  String? startTime;
  String? endTime1;
  String? personnelname;
  String? zoneName;
  String? channelName;
  int? weekday;
  int? valuationrate;
  int? valuationAMT;
  String? cancelRefNoRemarks;
  String? cancelNumber;
  String? cancelDate;
  String? bookingDate;
  String? mgStatus;

  MakeGoodReportModel(
      {this.message,
      this.bookingNumber,
      this.bookingDetailCode,
      this.dealno,
      this.recordnumber,
      this.programName,
      this.scheduleDate,
      this.scheduletime,
      this.endTime,
      this.clientName,
      this.agencyname,
      this.bookingreferencenumber,
      this.brandName,
      this.exportTapeCode,
      this.commercialcaption,
      this.tapeDuration,
      this.spotAmount,
      this.er,
      this.sponsorTypeName,
      this.startTime,
      this.endTime1,
      this.personnelname,
      this.zoneName,
      this.channelName,
      this.weekday,
      this.valuationrate,
      this.valuationAMT,
      this.cancelRefNoRemarks,
      this.cancelNumber,
      this.cancelDate,
      this.bookingDate,
      this.mgStatus});

  MakeGoodReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    dealno = json['dealno'];
    recordnumber = json['recordnumber'];
    programName = json['programName'];
    scheduleDate = json['scheduleDate'];
    scheduletime = json['scheduletime'];
    endTime = json['endTime'];
    clientName = json['clientName'];
    agencyname = json['agencyname'];
    bookingreferencenumber = json['bookingreferencenumber'];
    brandName = json['brandName'];
    exportTapeCode = json['exportTapeCode'];
    commercialcaption = json['commercialcaption'];
    tapeDuration = json['tapeDuration'];
    spotAmount = json['spotAmount'];
    er = json['er'];
    sponsorTypeName = json['sponsorTypeName'];
    startTime = json['startTime'];
    endTime1 = json['endTime1'];
    personnelname = json['personnelname'];
    zoneName = json['zoneName'];
    channelName = json['channelName'];
    weekday = json['weekday'];
    valuationrate = json['valuationrate'];
    valuationAMT = json['valuationAMT'];
    cancelRefNoRemarks = json['cancelRefNoRemarks'];
    cancelNumber = json['cancelNumber'];
    cancelDate = json['cancelDate'];
    bookingDate = json['bookingDate'];
    mgStatus = json['mgStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['bookingNumber'] = bookingNumber;
    data['bookingDetailCode'] = bookingDetailCode;
    data['dealno'] = dealno;
    data['recordnumber'] = recordnumber;
    data['programName'] = programName;
    data['scheduleDate'] = scheduleDate;
    data['scheduletime'] = scheduletime;
    data['endTime'] = endTime;
    data['clientName'] = clientName;
    data['agencyname'] = agencyname;
    data['bookingreferencenumber'] = bookingreferencenumber;
    data['brandName'] = brandName;
    data['exportTapeCode'] = exportTapeCode;
    data['commercialcaption'] = commercialcaption;
    data['tapeDuration'] = tapeDuration;
    data['spotAmount'] = spotAmount;
    data['er'] = er;
    data['sponsorTypeName'] = sponsorTypeName;
    data['startTime'] = startTime;
    data['endTime1'] = endTime1;
    data['personnelname'] = personnelname;
    data['zoneName'] = zoneName;
    data['channelName'] = channelName;
    data['weekday'] = weekday;
    data['valuationrate'] = valuationrate;
    data['valuationAMT'] = valuationAMT;
    data['cancelRefNoRemarks'] = cancelRefNoRemarks;
    data['cancelNumber'] = cancelNumber;
    data['cancelDate'] = cancelDate;
    data['bookingDate'] = bookingDate;
    data['mgStatus'] = mgStatus;
    return data;
  }
}
