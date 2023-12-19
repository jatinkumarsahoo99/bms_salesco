class RoBookingDealLeave {
  InfoLeaveOnDealNumber? infoLeaveOnDealNumber;

  RoBookingDealLeave({this.infoLeaveOnDealNumber});

  RoBookingDealLeave.fromJson(Map<String, dynamic> json) {
    infoLeaveOnDealNumber = json["infoLeaveOnDealNumber"] == null
        ? null
        : InfoLeaveOnDealNumber.fromJson(json["infoLeaveOnDealNumber"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (infoLeaveOnDealNumber != null) {
      _data["infoLeaveOnDealNumber"] = infoLeaveOnDealNumber?.toJson();
    }
    return _data;
  }
}

class InfoLeaveOnDealNumber {
  String? bookingMonth;
  DisplayDealDetails? displayDealDetails;
  ShowLinkDeal? showLinkDeal;
  List<GstPlantList>? gstPlantList;
  String? gstPlantId;
  String? gstRegNo;
  String? gstPlantIdCheck;
  String? gstRegNoCheck;
  String? gstRegN;
  String? gstPlantListSelected;

  InfoLeaveOnDealNumber(
      {this.bookingMonth,
      this.displayDealDetails,
      this.showLinkDeal,
      this.gstPlantList,
      this.gstPlantId,
      this.gstRegNo,
      this.gstPlantIdCheck,
      this.gstRegNoCheck,
      this.gstRegN,
      this.gstPlantListSelected});

  InfoLeaveOnDealNumber.fromJson(Map<String, dynamic> json) {
    bookingMonth = json["bookingMonth"];
    displayDealDetails = json["displayDealDetails"] == null
        ? null
        : DisplayDealDetails.fromJson(json["displayDealDetails"]);
    showLinkDeal = json["showLinkDeal"] == null
        ? null
        : ShowLinkDeal.fromJson(json["showLinkDeal"]);
    gstPlantList = json["gstPlantList"] == null
        ? null
        : (json["gstPlantList"] as List)
            .map((e) => GstPlantList.fromJson(e))
            .toList();
    gstPlantId = json["gstPlantID"];
    gstRegNo = json["gstRegNo"];
    gstPlantIdCheck = json["gstPlantIDCheck"];
    gstRegNoCheck = json["gstRegNoCheck"];
    gstRegN = json["gstRegN"];
    gstPlantListSelected = json["gstPlantListSelected"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["bookingMonth"] = bookingMonth;
    if (displayDealDetails != null) {
      _data["displayDealDetails"] = displayDealDetails?.toJson();
    }
    if (showLinkDeal != null) {
      _data["showLinkDeal"] = showLinkDeal?.toJson();
    }
    if (gstPlantList != null) {
      _data["gstPlantList"] = gstPlantList?.map((e) => e.toJson()).toList();
    }
    _data["gstPlantID"] = gstPlantId;
    _data["gstRegNo"] = gstRegNo;
    _data["gstPlantIDCheck"] = gstPlantIdCheck;
    _data["gstRegNoCheck"] = gstRegNoCheck;
    _data["gstRegN"] = gstRegN;
    _data["gstPlantListSelected"] = gstPlantListSelected;
    return _data;
  }
}

class GstPlantList {
  num? plantid;
  String? column1;

  GstPlantList({this.plantid, this.column1});

  GstPlantList.fromJson(Map<String, dynamic> json) {
    plantid = json["plantid"];
    column1 = json["column1"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["plantid"] = plantid;
    _data["column1"] = column1;
    return _data;
  }
}

class ShowLinkDeal {
  String? linkDealNo;
  String? linkDealName;

  ShowLinkDeal({this.linkDealNo, this.linkDealName});

  ShowLinkDeal.fromJson(Map<String, dynamic> json) {
    linkDealNo = json["linkDealNo"];
    linkDealName = json["linkDealName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["linkDealNo"] = linkDealNo;
    _data["linkDealName"] = linkDealName;
    return _data;
  }
}

class DisplayDealDetails {
  String? startDate;
  String? endDate;
  String? dealType;
  String? dealMaxSpent;
  List<LstDgvDealEntries>? lstDgvDealEntries;
  List<LstDgvLinkedDeals>? lstDgvLinkedDeals;
  String? payMode;
  String? previousBookedAmount;
  String? previousValAmount;
  dynamic message;
  bool? grpPdc;

  DisplayDealDetails(
      {this.startDate,
      this.endDate,
      this.dealType,
      this.dealMaxSpent,
      this.lstDgvDealEntries,
      this.lstDgvLinkedDeals,
      this.payMode,
      this.previousBookedAmount,
      this.previousValAmount,
      this.message,
      this.grpPdc});

  DisplayDealDetails.fromJson(Map<String, dynamic> json) {
    startDate = json["startDate"];
    endDate = json["endDate"];
    dealType = json["dealType"];
    dealMaxSpent = json["dealMaxSpent"];
    lstDgvDealEntries = json["lstDgvDealEntries"] == null
        ? null
        : (json["lstDgvDealEntries"] as List)
            .map((e) => LstDgvDealEntries.fromJson(e))
            .toList();
    lstDgvLinkedDeals = json["lstDgvLinkedDeals"] == null
        ? null
        : (json["lstDgvLinkedDeals"] as List)
            .map((e) => LstDgvLinkedDeals.fromJson(e))
            .toList();
    payMode = json["payMode"];
    previousBookedAmount = json["previousBookedAmount"];
    previousValAmount = json["previousValAmount"];
    message = json["message"];
    grpPdc = json["grpPDC"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["startDate"] = startDate;
    _data["endDate"] = endDate;
    _data["dealType"] = dealType;
    _data["dealMaxSpent"] = dealMaxSpent;
    if (lstDgvDealEntries != null) {
      _data["lstDgvDealEntries"] =
          lstDgvDealEntries?.map((e) => e.toJson()).toList();
    }
    if (lstDgvLinkedDeals != null) {
      _data["lstDgvLinkedDeals"] =
          lstDgvLinkedDeals?.map((e) => e.toJson()).toList();
    }
    _data["payMode"] = payMode;
    _data["previousBookedAmount"] = previousBookedAmount;
    _data["previousValAmount"] = previousValAmount;
    _data["message"] = message;
    _data["grpPDC"] = grpPdc;
    return _data;
  }
}

class LstDgvLinkedDeals {
  num? recordnumber;
  String? bandcode;
  String? impactNonImpact;
  String? sponsorTypeName;
  dynamic programCategoryName;
  dynamic programname;
  String? starttime;
  String? endTime;
  num? seconds;
  num? costPer10Sec;
  num? utilisedTime;
  num? balance;
  num? amount;
  num? valuationrate;
  num? groupCode;
  num? sun;
  num? mon;
  num? tue;
  num? wed;
  num? thu;
  num? fri;
  num? sat;
  num? booked;
  String? fromdate;
  String? todate;
  String? locationname;
  String? channelname;
  num? maxspend;
  String? paymentmodecaption;
  num? ispdcenterd;
  String? startdate;
  String? enddate;
  String? clientName;
  String? agencyName;
  String? dealnumber;
  num? valuationAmount;
  num? balanceAmount;
  num? dealValAmount;
  num? balanceValAmount;
  num? utilInRo;
  num? totalUtil;
  num? totalBookedAmt;
  num? totalValAmt;
  num? bookedAmt;
  String? locationcode;
  String? channelCode;
  num? baseduration;
  num? countbased;

  LstDgvLinkedDeals(
      {this.recordnumber,
      this.bandcode,
      this.impactNonImpact,
      this.sponsorTypeName,
      this.programCategoryName,
      this.programname,
      this.starttime,
      this.endTime,
      this.seconds,
      this.costPer10Sec,
      this.utilisedTime,
      this.balance,
      this.amount,
      this.valuationrate,
      this.groupCode,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.booked,
      this.fromdate,
      this.todate,
      this.locationname,
      this.channelname,
      this.maxspend,
      this.paymentmodecaption,
      this.ispdcenterd,
      this.startdate,
      this.enddate,
      this.clientName,
      this.agencyName,
      this.dealnumber,
      this.valuationAmount,
      this.balanceAmount,
      this.dealValAmount,
      this.balanceValAmount,
      this.utilInRo,
      this.totalUtil,
      this.totalBookedAmt,
      this.totalValAmt,
      this.bookedAmt,
      this.locationcode,
      this.channelCode,
      this.baseduration,
      this.countbased});

  LstDgvLinkedDeals.fromJson(Map<String, dynamic> json) {
    recordnumber = json["recordnumber"];
    bandcode = json["bandcode"];
    impactNonImpact = json["impactNonImpact"];
    sponsorTypeName = json["sponsorTypeName"];
    programCategoryName = json["programCategoryName"];
    programname = json["programname"];
    starttime = json["starttime"];
    endTime = json["endTime"];
    seconds = json["seconds"];
    costPer10Sec = json["costPer10Sec"];
    utilisedTime = json["utilisedTime"];
    balance = json["balance"];
    amount = json["amount"];
    valuationrate = json["valuationrate"];
    groupCode = json["groupCode"];
    sun = json["sun"];
    mon = json["mon"];
    tue = json["tue"];
    wed = json["wed"];
    thu = json["thu"];
    fri = json["fri"];
    sat = json["sat"];
    booked = json["booked"];
    fromdate = json["fromdate"];
    todate = json["todate"];
    locationname = json["locationname"];
    channelname = json["channelname"];
    maxspend = json["maxspend"];
    paymentmodecaption = json["paymentmodecaption"];
    ispdcenterd = json["ispdcenterd"];
    startdate = json["startdate"];
    enddate = json["enddate"];
    clientName = json["clientName"];
    agencyName = json["agencyName"];
    dealnumber = json["dealnumber"];
    valuationAmount = json["valuationAmount"];
    balanceAmount = json["balanceAmount"];
    dealValAmount = json["dealValAmount"];
    balanceValAmount = json["balanceValAmount"];
    utilInRo = json["utilInRo"];
    totalUtil = json["totalUtil"];
    totalBookedAmt = json["totalBookedAmt"];
    totalValAmt = json["totalValAmt"];
    bookedAmt = json["bookedAmt"];
    locationcode = json["locationcode"];
    channelCode = json["channelCode"];
    baseduration = json["baseduration"];
    countbased = json["countbased"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["recordnumber"] = recordnumber;
    _data["bandcode"] = bandcode;
    _data["impactNonImpact"] = impactNonImpact;
    _data["sponsorTypeName"] = sponsorTypeName;
    _data["programCategoryName"] = programCategoryName;
    _data["programname"] = programname;
    _data["starttime"] = starttime;
    _data["endTime"] = endTime;
    _data["seconds"] = seconds;
    _data["costPer10Sec"] = costPer10Sec;
    _data["utilisedTime"] = utilisedTime;
    _data["balance"] = balance;
    _data["amount"] = amount;
    _data["valuationrate"] = valuationrate;
    _data["groupCode"] = groupCode;
    _data["sun"] = sun;
    _data["mon"] = mon;
    _data["tue"] = tue;
    _data["wed"] = wed;
    _data["thu"] = thu;
    _data["fri"] = fri;
    _data["sat"] = sat;
    _data["booked"] = booked;
    _data["fromdate"] = fromdate;
    _data["todate"] = todate;
    _data["locationname"] = locationname;
    _data["channelname"] = channelname;
    _data["maxspend"] = maxspend;
    _data["paymentmodecaption"] = paymentmodecaption;
    _data["ispdcenterd"] = ispdcenterd;
    _data["startdate"] = startdate;
    _data["enddate"] = enddate;
    _data["clientName"] = clientName;
    _data["agencyName"] = agencyName;
    _data["dealnumber"] = dealnumber;
    _data["valuationAmount"] = valuationAmount;
    _data["balanceAmount"] = balanceAmount;
    _data["dealValAmount"] = dealValAmount;
    _data["balanceValAmount"] = balanceValAmount;
    _data["utilInRo"] = utilInRo;
    _data["totalUtil"] = totalUtil;
    _data["totalBookedAmt"] = totalBookedAmt;
    _data["totalValAmt"] = totalValAmt;
    _data["bookedAmt"] = bookedAmt;
    _data["locationcode"] = locationcode;
    _data["channelCode"] = channelCode;
    _data["baseduration"] = baseduration;
    _data["countbased"] = countbased;
    return _data;
  }
}

class LstDgvDealEntries {
  num? recordnumber;
  String? bandcode;
  String? impactNonImpact;
  String? sponsorTypeName;
  dynamic programCategoryName;
  dynamic programname;
  String? starttime;
  String? endTime;
  num? seconds;
  num? costPer10Sec;
  num? utilisedTime;
  num? balance;
  num? amount;
  num? valuationrate;
  dynamic groupCode;
  num? sun;
  num? mon;
  num? tue;
  num? wed;
  num? thu;
  num? fri;
  num? sat;
  num? booked;
  String? fromdate;
  String? todate;
  String? locationname;
  String? channelname;
  num? maxspend;
  String? paymentmodecaption;
  num? ispdcenterd;
  String? startdate;
  String? enddate;
  String? clientName;
  String? agencyName;
  String? dealnumber;
  num? valuationAmount;
  num? balanceAmount;
  num? dealValAmount;
  num? balanceValAmount;
  num? utilInRo;
  num? totalUtil;
  num? totalBookedAmt;
  num? totalValAmt;
  num? bookedAmt;
  String? locationcode;
  String? channelCode;
  num? baseduration;
  num? countbased;

  LstDgvDealEntries(
      {this.recordnumber,
      this.bandcode,
      this.impactNonImpact,
      this.sponsorTypeName,
      this.programCategoryName,
      this.programname,
      this.starttime,
      this.endTime,
      this.seconds,
      this.costPer10Sec,
      this.utilisedTime,
      this.balance,
      this.amount,
      this.valuationrate,
      this.groupCode,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.booked,
      this.fromdate,
      this.todate,
      this.locationname,
      this.channelname,
      this.maxspend,
      this.paymentmodecaption,
      this.ispdcenterd,
      this.startdate,
      this.enddate,
      this.clientName,
      this.agencyName,
      this.dealnumber,
      this.valuationAmount,
      this.balanceAmount,
      this.dealValAmount,
      this.balanceValAmount,
      this.utilInRo,
      this.totalUtil,
      this.totalBookedAmt,
      this.totalValAmt,
      this.bookedAmt,
      this.locationcode,
      this.channelCode,
      this.baseduration,
      this.countbased});

  LstDgvDealEntries.fromJson(Map<String, dynamic> json) {
    recordnumber = json["recordnumber"];
    bandcode = json["bandcode"];
    impactNonImpact = json["impactNonImpact"];
    sponsorTypeName = json["sponsorTypeName"];
    programCategoryName = json["programCategoryName"];
    programname = json["programname"];
    starttime = json["starttime"];
    endTime = json["endTime"];
    seconds = json["seconds"];
    costPer10Sec = json["costPer10Sec"];
    utilisedTime = json["utilisedTime"];
    balance = json["balance"];
    amount = json["amount"];
    valuationrate = json["valuationrate"];
    groupCode = json["groupCode"];
    sun = json["sun"];
    mon = json["mon"];
    tue = json["tue"];
    wed = json["wed"];
    thu = json["thu"];
    fri = json["fri"];
    sat = json["sat"];
    booked = json["booked"];
    fromdate = json["fromdate"];
    todate = json["todate"];
    locationname = json["locationname"];
    channelname = json["channelname"];
    maxspend = json["maxspend"];
    paymentmodecaption = json["paymentmodecaption"];
    ispdcenterd = json["ispdcenterd"];
    startdate = json["startdate"];
    enddate = json["enddate"];
    clientName = json["clientName"];
    agencyName = json["agencyName"];
    dealnumber = json["dealnumber"];
    valuationAmount = json["valuationAmount"];
    balanceAmount = json["balanceAmount"];
    dealValAmount = json["dealValAmount"];
    balanceValAmount = json["balanceValAmount"];
    utilInRo = json["utilInRo"];
    totalUtil = json["totalUtil"];
    totalBookedAmt = json["totalBookedAmt"];
    totalValAmt = json["totalValAmt"];
    bookedAmt = json["bookedAmt"];
    locationcode = json["locationcode"];
    channelCode = json["channelCode"];
    baseduration = json["baseduration"];
    countbased = json["countbased"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["recordnumber"] = recordnumber;
    _data["bandcode"] = bandcode;
    _data["impactNonImpact"] = impactNonImpact;
    _data["sponsorTypeName"] = sponsorTypeName;
    _data["programCategoryName"] = programCategoryName;
    _data["programname"] = programname;
    _data["starttime"] = starttime;
    _data["endTime"] = endTime;
    _data["seconds"] = seconds;
    _data["costPer10Sec"] = costPer10Sec;
    _data["utilisedTime"] = utilisedTime;
    _data["balance"] = balance;
    _data["amount"] = amount;
    _data["valuationrate"] = valuationrate;
    _data["groupCode"] = groupCode;
    _data["sun"] = sun;
    _data["mon"] = mon;
    _data["tue"] = tue;
    _data["wed"] = wed;
    _data["thu"] = thu;
    _data["fri"] = fri;
    _data["sat"] = sat;
    _data["booked"] = booked;
    _data["fromdate"] = fromdate;
    _data["todate"] = todate;
    _data["locationname"] = locationname;
    _data["channelname"] = channelname;
    _data["maxspend"] = maxspend;
    _data["paymentmodecaption"] = paymentmodecaption;
    _data["ispdcenterd"] = ispdcenterd;
    _data["startdate"] = startdate;
    _data["enddate"] = enddate;
    _data["clientName"] = clientName;
    _data["agencyName"] = agencyName;
    _data["dealnumber"] = dealnumber;
    _data["valuationAmount"] = valuationAmount;
    _data["balanceAmount"] = balanceAmount;
    _data["dealValAmount"] = dealValAmount;
    _data["balanceValAmount"] = balanceValAmount;
    _data["utilInRo"] = utilInRo;
    _data["totalUtil"] = totalUtil;
    _data["totalBookedAmt"] = totalBookedAmt;
    _data["totalValAmt"] = totalValAmt;
    _data["bookedAmt"] = bookedAmt;
    _data["locationcode"] = locationcode;
    _data["channelCode"] = channelCode;
    _data["baseduration"] = baseduration;
    _data["countbased"] = countbased;
    return _data;
  }
}
