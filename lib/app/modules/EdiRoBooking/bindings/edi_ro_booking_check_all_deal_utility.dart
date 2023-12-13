class RoBookingCheckAllDealUtility {
  InfoCheckAllDealUtility? infoCheckAllDealUtility;

  RoBookingCheckAllDealUtility({this.infoCheckAllDealUtility});

  RoBookingCheckAllDealUtility.fromJson(Map<String, dynamic> json) {
    infoCheckAllDealUtility = json["infoCheckAllDealUtility"] == null
        ? null
        : InfoCheckAllDealUtility.fromJson(json["infoCheckAllDealUtility"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (infoCheckAllDealUtility != null) {
      _data["infoCheckAllDealUtility"] = infoCheckAllDealUtility?.toJson();
    }
    return _data;
  }
}

class InfoCheckAllDealUtility {
  List<LstDealEntries>? lstDealEntries;
  FlagDeals? flagDeals;

  InfoCheckAllDealUtility({this.lstDealEntries, this.flagDeals});

  InfoCheckAllDealUtility.fromJson(Map<String, dynamic> json) {
    lstDealEntries = json["lstDealEntries"] == null
        ? null
        : (json["lstDealEntries"] as List)
            .map((e) => LstDealEntries.fromJson(e))
            .toList();
    flagDeals = json["flagDeals"] == null
        ? null
        : FlagDeals.fromJson(json["flagDeals"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstDealEntries != null) {
      _data["lstDealEntries"] = lstDealEntries?.map((e) => e.toJson()).toList();
    }
    if (flagDeals != null) {
      _data["flagDeals"] = flagDeals?.toJson();
    }
    return _data;
  }
}

class FlagDeals {
  List<LstSpots>? lstSpots;
  dynamic checkRevenue;
  dynamic message;
  int? intSpotDuration;
  int? intBalanceDuration;

  FlagDeals(
      {this.lstSpots,
      this.checkRevenue,
      this.message,
      this.intSpotDuration,
      this.intBalanceDuration});

  FlagDeals.fromJson(Map<String, dynamic> json) {
    lstSpots = json["lstSpots"] == null
        ? null
        : (json["lstSpots"] as List).map((e) => LstSpots.fromJson(e)).toList();
    checkRevenue = json["checkRevenue"];
    message = json["message"];
    intSpotDuration = json["intSpotDuration"];
    intBalanceDuration = json["intBalanceDuration"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstSpots != null) {
      _data["lstSpots"] = lstSpots?.map((e) => e.toJson()).toList();
    }
    _data["checkRevenue"] = checkRevenue;
    _data["message"] = message;
    _data["intSpotDuration"] = intSpotDuration;
    _data["intBalanceDuration"] = intBalanceDuration;
    return _data;
  }
}

class LstSpots {
  String? station;
  String? acTDt;
  String? stime;
  String? etime;
  String? program;
  String? fpcstart;
  String? fpcprogram;
  String? tapEId;
  String? commercialcaption;
  int? dur;
  int? commercialduration;
  String? brand;
  String? commCaption;
  String? pmtType;
  String? schDId;
  String? spoTStatus;
  String? dealno;
  int? dealrow;
  int? amount;
  int? spoTRate;
  String? fctok;
  String? dealOk;
  String? clienTName;
  String? endTime;
  String? nOSpot;
  String? okSpot;
  dynamic programcategoryname;
  String? groupcode;
  String? rONum;
  String? rODate;
  String? statioNId;
  String? clienTId;
  int? noProgram;
  String? brandName;
  String? branDId;
  int? sEgmentNumber;
  String? programCode;
  String? pEndTime;
  dynamic backColor;
  bool? selected;
  bool? isSpotsAvailable;

  LstSpots(
      {this.station,
      this.acTDt,
      this.stime,
      this.etime,
      this.program,
      this.fpcstart,
      this.fpcprogram,
      this.tapEId,
      this.commercialcaption,
      this.dur,
      this.commercialduration,
      this.brand,
      this.commCaption,
      this.pmtType,
      this.schDId,
      this.spoTStatus,
      this.dealno,
      this.dealrow,
      this.amount,
      this.spoTRate,
      this.fctok,
      this.dealOk,
      this.clienTName,
      this.endTime,
      this.nOSpot,
      this.okSpot,
      this.programcategoryname,
      this.groupcode,
      this.rONum,
      this.rODate,
      this.statioNId,
      this.clienTId,
      this.noProgram,
      this.brandName,
      this.branDId,
      this.sEgmentNumber,
      this.programCode,
      this.pEndTime,
      this.backColor,
      this.selected,
      this.isSpotsAvailable});

  LstSpots.fromJson(Map<String, dynamic> json) {
    station = json["station"];
    acTDt = json["acT_DT"];
    stime = json["stime"];
    etime = json["etime"];
    program = json["program"];
    fpcstart = json["fpcstart"];
    fpcprogram = json["fpcprogram"];
    tapEId = json["tapE_ID"];
    commercialcaption = json["commercialcaption"];
    dur = json["dur"];
    commercialduration = json["commercialduration"];
    brand = json["brand"];
    commCaption = json["commCaption"];
    pmtType = json["pmtType"];
    schDId = json["schD_ID"];
    spoTStatus = json["spoT_STATUS"];
    dealno = json["dealno"];
    dealrow = json["dealrow"];
    amount = json["amount"];
    spoTRate = json["spoT_RATE"];
    fctok = json["fctok"];
    dealOk = json["dealOK"];
    clienTName = json["clienT_NAME"];
    endTime = json["endTime"];
    nOSpot = json["nO_SPOT"];
    okSpot = json["okSpot"];
    programcategoryname = json["programcategoryname"];
    groupcode = json["groupcode"];
    rONum = json["rO_NUM"];
    rODate = json["rO_DATE"];
    statioNId = json["statioN_ID"];
    clienTId = json["clienT_ID"];
    noProgram = json["noProgram"];
    brandName = json["brandName"];
    branDId = json["branD_ID"];
    sEgmentNumber = json["sEgmentNumber"];
    programCode = json["programCode"];
    pEndTime = json["pEndTime"];
    backColor = json["backColor"];
    selected = json["selected"];
    isSpotsAvailable = json["isSpotsAvailable"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["station"] = station;
    _data["acT_DT"] = acTDt;
    _data["stime"] = stime;
    _data["etime"] = etime;
    _data["program"] = program;
    _data["fpcstart"] = fpcstart;
    _data["fpcprogram"] = fpcprogram;
    _data["tapE_ID"] = tapEId;
    _data["commercialcaption"] = commercialcaption;
    _data["dur"] = dur;
    _data["commercialduration"] = commercialduration;
    _data["brand"] = brand;
    _data["commCaption"] = commCaption;
    _data["pmtType"] = pmtType;
    _data["schD_ID"] = schDId;
    _data["spoT_STATUS"] = spoTStatus;
    _data["dealno"] = dealno;
    _data["dealrow"] = dealrow;
    _data["amount"] = amount;
    _data["spoT_RATE"] = spoTRate;
    _data["fctok"] = fctok;
    _data["dealOK"] = dealOk;
    _data["clienT_NAME"] = clienTName;
    _data["endTime"] = endTime;
    _data["nO_SPOT"] = nOSpot;
    _data["okSpot"] = okSpot;
    _data["programcategoryname"] = programcategoryname;
    _data["groupcode"] = groupcode;
    _data["rO_NUM"] = rONum;
    _data["rO_DATE"] = rODate;
    _data["statioN_ID"] = statioNId;
    _data["clienT_ID"] = clienTId;
    _data["noProgram"] = noProgram;
    _data["brandName"] = brandName;
    _data["branD_ID"] = branDId;
    _data["sEgmentNumber"] = sEgmentNumber;
    _data["programCode"] = programCode;
    _data["pEndTime"] = pEndTime;
    _data["backColor"] = backColor;
    _data["selected"] = selected;
    _data["isSpotsAvailable"] = isSpotsAvailable;
    return _data;
  }
}

class LstDealEntries {
  int? recordnumber;
  String? bandcode;
  String? impactNonImpact;
  String? sponsorTypeName;
  dynamic programCategoryName;
  dynamic programname;
  String? starttime;
  String? endTime;
  int? seconds;
  int? costPer10Sec;
  int? utilisedTime;
  int? balance;
  int? amount;
  int? valuationrate;
  dynamic groupCode;
  int? sun;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? booked;
  String? fromdate;
  String? todate;
  String? locationname;
  String? channelname;
  int? maxspend;
  String? paymentmodecaption;
  int? ispdcenterd;
  String? startdate;
  String? enddate;
  String? clientName;
  String? agencyName;
  String? dealnumber;
  int? valuationAmount;
  int? balanceAmount;
  int? dealValAmount;
  int? balanceValAmount;
  int? utilInRo;
  int? totalUtil;
  int? totalBookedAmt;
  int? totalValAmt;
  int? bookedAmt;
  String? locationcode;
  String? channelCode;
  int? baseduration;
  int? countbased;

  LstDealEntries(
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

  LstDealEntries.fromJson(Map<String, dynamic> json) {
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
