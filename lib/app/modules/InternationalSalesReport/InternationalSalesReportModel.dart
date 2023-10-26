class InternationalSalesReportModel {
  Report? report;

  InternationalSalesReportModel({this.report});

  InternationalSalesReportModel.fromJson(Map<String, dynamic> json) {
    report =
    json['report'] != null ? new Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    return data;
  }
}

class Report {
  List<InternationalDetails>? internationalDetails;
  List<InternationalSalesSummary>? internationalSalesSummary;

  Report({this.internationalDetails,
    this.internationalSalesSummary
  });

  Report.fromJson(Map<String, dynamic> json) {
    if (json['internationalDetails'] != null) {
      internationalDetails = <InternationalDetails>[];
      json['internationalDetails'].forEach((v) {
        internationalDetails!.add(new InternationalDetails.fromJson(v));
      });
    }
    if (json['internationalSalesSummary'] != null) {
      internationalSalesSummary = <InternationalSalesSummary>[];
      json['internationalSalesSummary'].forEach((v) {
        internationalSalesSummary!.add(new InternationalSalesSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.internationalDetails != null) {
      data['internationalDetails'] =
          this.internationalDetails!.map((v) => v.toJson()).toList();
    }
    if (this.internationalSalesSummary != null) {
      data['internationalSalesSummary'] =
          this.internationalSalesSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InternationalDetails {
  String? channelName;
  String? bookingnumber;
  int? bookingDetailCode;
  String? scheduledate;
  String? scheduletime;
  String? clientname;
  String? agencyname;
  String? programname;
  String? commercialcaption;
  String? exporttapecode;
  int? bonusDuration;
  int? paidDuration;
  int? totalDuration;
  String? amount;
  String? currencyType;
  String? zonename;
  String? brandname;
  String? telecasttime;
  int? telecastduration;
  String? telecastprogram;
  String? billnumber;
  String? spotstatus;
  String? billdate;
  String? dealno;
  int? recordnumber;
  int? yearname;
  String? month;
  String? dayname;
  String? producttype;
  String? producttype1;
  String? producttype2;
  String? producttype3;
  String? productname;
  String? revenueType;
  String? executivname;
  String? networknonetwork;

  InternationalDetails(
      {this.channelName,
        this.bookingnumber,
        this.bookingDetailCode,
        this.scheduledate,
        this.scheduletime,
        this.clientname,
        this.agencyname,
        this.programname,
        this.commercialcaption,
        this.exporttapecode,
        this.bonusDuration,
        this.paidDuration,
        this.totalDuration,
        this.amount,
        this.currencyType,
        this.zonename,
        this.brandname,
        this.telecasttime,
        this.telecastduration,
        this.telecastprogram,
        this.billnumber,
        this.spotstatus,
        this.billdate,
        this.dealno,
        this.recordnumber,
        this.yearname,
        this.month,
        this.dayname,
        this.producttype,
        this.producttype1,
        this.producttype2,
        this.producttype3,
        this.productname,
        this.revenueType,
        this.executivname,
        this.networknonetwork});

  InternationalDetails.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    bookingnumber = json['bookingnumber'];
    bookingDetailCode = json['bookingDetailCode'];
    scheduledate = json['scheduledate'];
    scheduletime = json['scheduletime'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    programname = json['programname'];
    commercialcaption = json['commercialcaption'];
    exporttapecode = json['exporttapecode'];
    bonusDuration = json['bonusDuration'];
    paidDuration = json['paidDuration'];
    totalDuration = json['totalDuration'];
    amount = (json['amount']??"").toString();
    currencyType = json['currencyType'];
    zonename = json['zonename'];
    brandname = json['brandname'];
    telecasttime = json['telecasttime'];
    telecastduration = json['telecastduration'];
    telecastprogram = json['telecastprogram'];
    billnumber = json['billnumber'];
    spotstatus = json['spotstatus'];
    billdate = json['billdate'];
    dealno = json['dealno'];
    recordnumber = json['recordnumber'];
    yearname = json['yearname'];
    month = json['month'];
    dayname = json['dayname'];
    producttype = json['producttype'];
    producttype1 = json['producttype_1'];
    producttype2 = json['producttype_2'];
    producttype3 = json['producttype_3'];
    productname = json['productname'];
    revenueType = json['revenueType'];
    executivname = json['executivname'];
    networknonetwork = json['networknonetwork'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelName'] = this.channelName;
    data['bookingnumber'] = this.bookingnumber;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['scheduledate'] = this.scheduledate;
    data['scheduletime'] = this.scheduletime;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['programname'] = this.programname;
    data['commercialcaption'] = this.commercialcaption;
    data['exporttapecode'] = this.exporttapecode;
    data['bonusDuration'] = this.bonusDuration;
    data['paidDuration'] = this.paidDuration;
    data['totalDuration'] = this.totalDuration;
    data['amount'] = this.amount;
    data['currencyType'] = this.currencyType;
    data['zonename'] = this.zonename;
    data['brandname'] = this.brandname;
    data['telecasttime'] = this.telecasttime;
    data['telecastduration'] = this.telecastduration;
    data['telecastprogram'] = this.telecastprogram;
    data['billnumber'] = this.billnumber;
    data['spotstatus'] = this.spotstatus;
    data['billdate'] = this.billdate;
    data['dealno'] = this.dealno;
    data['recordnumber'] = this.recordnumber;
    data['yearname'] = this.yearname;
    data['month'] = this.month;
    data['dayname'] = this.dayname;
    data['producttype'] = this.producttype;
    data['producttype_1'] = this.producttype1;
    data['producttype_2'] = this.producttype2;
    data['producttype_3'] = this.producttype3;
    data['productname'] = this.productname;
    data['revenueType'] = this.revenueType;
    data['executivname'] = this.executivname;
    data['networknonetwork'] = this.networknonetwork;
    return data;
  }
}

class InternationalSalesSummary {
  String? zonename;
  String? channelname;
  String? clientname;
  String? agencyname;
  String? brandname;
  String? month;
  int? paidDur;
  int? bonusDur;
  int? totDur;
  String? spotAmount;
  String? currencyType;
  String? executivname;

  InternationalSalesSummary(
      {this.zonename,
        this.channelname,
        this.clientname,
        this.agencyname,
        this.brandname,
        this.month,
        this.paidDur,
        this.bonusDur,
        this.totDur,
        this.spotAmount,
        this.currencyType,
        this.executivname});

  InternationalSalesSummary.fromJson(Map<String, dynamic> json) {
    zonename = json['zonename'];
    channelname = json['channelname'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandname = json['brandname'];
    month = json['month'];
    paidDur = json['paidDur'];
    bonusDur = json['bonusDur'];
    totDur = json['totDur'];
    spotAmount = (json['spotAmount']??"").toString();
    currencyType = json['currencyType'];
    executivname = json['executivname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zonename'] = this.zonename;
    data['channelname'] = this.channelname;
    data['clientname'] = this.clientname;
    data['agencyname'] = this.agencyname;
    data['brandname'] = this.brandname;
    data['month'] = this.month;
    data['paidDur'] = this.paidDur;
    data['bonusDur'] = this.bonusDur;
    data['totDur'] = this.totDur;
    data['spotAmount'] = this.spotAmount;
    data['currencyType'] = this.currencyType;
    data['executivname'] = this.executivname;
    return data;
  }
}

