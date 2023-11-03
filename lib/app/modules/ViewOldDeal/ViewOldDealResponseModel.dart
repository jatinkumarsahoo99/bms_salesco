import 'package:bms_salesco/app/providers/Utils.dart';

class ViewOldDealResponseModel {
  Deal? deal;

  ViewOldDealResponseModel({this.deal});

  ViewOldDealResponseModel.fromJson(Map<String, dynamic> json) {
    deal = json['deal'] != null ? new Deal.fromJson(json['deal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deal != null) {
      data['deal'] = this.deal!.toJson();
    }
    return data;
  }
}

class Deal {
  List<Lstdealmaster>? lstdealmaster;
  List<Lstdealusage>? lstdealusage;

  Deal({this.lstdealmaster, this.lstdealusage});

  Deal.fromJson(Map<String, dynamic> json) {
    if (json['lstdealmaster'] != null) {
      lstdealmaster = <Lstdealmaster>[];
      json['lstdealmaster'].forEach((v) {
        lstdealmaster!.add(new Lstdealmaster.fromJson(v));
      });
    }
    if (json['lstdealusage'] != null) {
      lstdealusage = <Lstdealusage>[];
      json['lstdealusage'].forEach((v) {
        lstdealusage!.add(new Lstdealusage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstdealmaster != null) {
      data['lstdealmaster'] =
          this.lstdealmaster!.map((v) => v.toJson()).toList();
    }
    if (this.lstdealusage != null) {
      data['lstdealusage'] = this.lstdealusage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lstdealmaster {
  String? fromDate;
  String? todate;
  int? dealamount;
  int? seconds;

  Lstdealmaster({this.fromDate, this.todate, this.dealamount, this.seconds});

  Lstdealmaster.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    todate = json['todate'];
    dealamount = json['dealamount'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromDate'] = this.fromDate;
    data['todate'] = this.todate;
    data['dealamount'] = this.dealamount;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Lstdealusage {
  String? dealnumber;
  int? recordnumber;
  String? sponsorTypeName;
  String? programCategoryName;
  String? programname;
  String? starttime;
  String? endTime;
  int? seconds;
  int? rate;
  int? amount;
  int? utilisedTime;
  int? booked;
  int? valuationrate;
  String? fromdate;
  String? todate;
  int? balance;
  String? locationname;
  String? channelname;
  int? maxspend;
  String? paymentmodecaption;
  int? ispdcenterd;
  String? startdate;
  String? enddate;
  String? bandcode;
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? groupCode;
  String? clientName;
  String? agencyName;

  Lstdealusage(
      {this.dealnumber,
        this.recordnumber,
        this.sponsorTypeName,
        this.programCategoryName,
        this.programname,
        this.starttime,
        this.endTime,
        this.seconds,
        this.rate,
        this.amount,
        this.utilisedTime,
        this.booked,
        this.valuationrate,
        this.fromdate,
        this.todate,
        this.balance,
        this.locationname,
        this.channelname,
        this.maxspend,
        this.paymentmodecaption,
        this.ispdcenterd,
        this.startdate,
        this.enddate,
        this.bandcode,
        this.sun,
        this.mon,
        this.tue,
        this.wed,
        this.thu,
        this.fri,
        this.sat,
        this.groupCode,
        this.clientName,
        this.agencyName});

  Lstdealusage.fromJson(Map<String, dynamic> json) {
    dealnumber = json['dealnumber'];
    recordnumber = json['recordnumber'];
    sponsorTypeName = json['sponsorTypeName'];
    programCategoryName = (json['programCategoryName']??"").toString();
    programname = json['programname'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    seconds = json['seconds'];
    rate = json['rate'];
    amount = json['amount'];
    utilisedTime = json['utilisedTime'];
    booked = json['booked'];
    valuationrate = json['valuationrate'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    balance = json['balance'];
    locationname = json['locationname'];
    channelname = json['channelname'];
    maxspend = json['maxspend'];
    paymentmodecaption = json['paymentmodecaption'];
    ispdcenterd = json['ispdcenterd'];
    startdate = (json['startdate']??"").toString();
    enddate = (json['enddate']??"").toString();
    bandcode = json['bandcode'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    groupCode = json['groupCode'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealnumber'] = this.dealnumber;
    data['recordnumber'] = this.recordnumber;
    data['sponsorTypeName'] = this.sponsorTypeName;
    data['programCategoryName'] = this.programCategoryName;
    data['programname'] = this.programname;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['seconds'] = this.seconds;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['utilisedTime'] = this.utilisedTime;
    data['booked'] = this.booked;
    data['valuationrate'] = this.valuationrate;
    data['fromdate'] = Utils.toDateFormat4(this.fromdate) ;
    data['todate'] = Utils.toDateFormat4(this.todate);
    data['balance'] = this.balance;
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['maxspend'] = this.maxspend;
    data['paymentmodecaption'] = this.paymentmodecaption;
    data['ispdcenterd'] = this.ispdcenterd;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['bandcode'] = this.bandcode;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['groupCode'] = this.groupCode;
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    return data;
  }
}
