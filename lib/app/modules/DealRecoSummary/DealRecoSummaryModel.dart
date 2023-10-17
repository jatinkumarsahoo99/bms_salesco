class DealRecoSummaryModel {
  List<Gentare>? gentare;

  DealRecoSummaryModel({this.gentare});

  DealRecoSummaryModel.fromJson(Map<String, dynamic> json) {
    if (json['genrate'] != null) {
      gentare = <Gentare>[];
      json['genrate'].forEach((v) {
        gentare!.add(new Gentare.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gentare != null) {
      data['genrate'] = this.gentare!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gentare {
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
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  String? clientName;
  String? agencyName;
  String? bandcode;
  String? networkname;
  String? paymentMode;
  int? dealvalamount;
  int? bookedValAmount;
  int? balanceAmount;
  int? balanceValAmount;

  Gentare(
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
        this.sun,
        this.mon,
        this.tue,
        this.wed,
        this.thu,
        this.fri,
        this.sat,
        this.clientName,
        this.agencyName,
        this.bandcode,
        this.networkname,
        this.paymentMode,
        this.dealvalamount,
        this.bookedValAmount,
        this.balanceAmount,
        this.balanceValAmount});

  Gentare.fromJson(Map<String, dynamic> json) {
    dealnumber = json['dealnumber'];
    recordnumber = json['recordnumber'];
    sponsorTypeName = json['sponsorTypeName'];
    programCategoryName = json['programCategoryName'];
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
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    bandcode = json['bandcode'];
    networkname = json['networkname'];
    paymentMode = json['paymentMode'];
    dealvalamount = json['dealvalamount'];
    bookedValAmount = json['bookedValAmount'];
    balanceAmount = json['balanceAmount'];
    balanceValAmount = json['balanceValAmount'];
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
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['balance'] = this.balance;
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['clientName'] = this.clientName;
    data['agencyName'] = this.agencyName;
    data['bandcode'] = this.bandcode;
    data['networkname'] = this.networkname;
    data['paymentMode'] = this.paymentMode;
    data['dealvalamount'] = this.dealvalamount;
    data['bookedValAmount'] = this.bookedValAmount;
    data['balanceAmount'] = this.balanceAmount;
    data['balanceValAmount'] = this.balanceValAmount;
    return data;
  }
}
