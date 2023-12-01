class RoBookingLeaveFileName {
  InfoFileNameLeave? infoFileNameLeave;

  RoBookingLeaveFileName({this.infoFileNameLeave});

  RoBookingLeaveFileName.fromJson(Map<String, dynamic> json) {
    infoFileNameLeave = json["infoFileNameLeave"] == null
        ? null
        : InfoFileNameLeave.fromJson(json["infoFileNameLeave"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (infoFileNameLeave != null) {
      _data["infoFileNameLeave"] = infoFileNameLeave?.toJson();
    }
    return _data;
  }
}

class InfoFileNameLeave {
  List<dynamic>? lstSpots;
  List<dynamic>? lstDealEntries;
  LstLoadXml? lstLoadXml;
  List<String>? strRoRefNo;
  HeaderData? headerData;

  InfoFileNameLeave(
      {this.lstSpots,
      this.lstDealEntries,
      this.lstLoadXml,
      this.strRoRefNo,
      this.headerData});

  InfoFileNameLeave.fromJson(Map<String, dynamic> json) {
    lstSpots = json["lstSpots"] ?? [];
    lstDealEntries = json["lstDealEntries"] ?? [];
    lstLoadXml = json["lstLoadXml"] == null
        ? null
        : LstLoadXml.fromJson(json["lstLoadXml"]);
    strRoRefNo = json["strRoRefNo"] == null
        ? null
        : List<String>.from(json["strRoRefNo"]);
    headerData = json["headerData"] == null
        ? null
        : HeaderData.fromJson(json["headerData"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstSpots != null) {
      _data["lstSpots"] = lstSpots;
    }
    if (lstDealEntries != null) {
      _data["lstDealEntries"] = lstDealEntries;
    }
    if (lstLoadXml != null) {
      _data["lstLoadXml"] = lstLoadXml?.toJson();
    }
    if (strRoRefNo != null) {
      _data["strRoRefNo"] = strRoRefNo;
    }
    if (headerData != null) {
      _data["headerData"] = headerData?.toJson();
    }
    return _data;
  }
}

class HeaderData {
  String? locationCode;
  String? channelCode;
  List<LstChannel>? lstChannel;
  List<LstClients>? lstClients;
  String? clientcode;
  List<LstDealNumbers>? lstDealNumbers;
  List<LstBrands>? lstBrands;
  List<LstAgencies>? lstAgencies;
  String? agencyCode;
  dynamic message;
  List<ExecutivesSelectedValue>? executivesSelectedValue;

  HeaderData(
      {this.locationCode,
      this.channelCode,
      this.lstChannel,
      this.lstClients,
      this.clientcode,
      this.lstDealNumbers,
      this.lstBrands,
      this.lstAgencies,
      this.agencyCode,
      this.message,
      this.executivesSelectedValue});

  HeaderData.fromJson(Map<String, dynamic> json) {
    locationCode = json["locationCode"];
    channelCode = json["channelCode"];
    lstChannel = json["lstChannel"] == null
        ? null
        : (json["lstChannel"] as List)
            .map((e) => LstChannel.fromJson(e))
            .toList();
    lstClients = json["lstClients"] == null
        ? null
        : (json["lstClients"] as List)
            .map((e) => LstClients.fromJson(e))
            .toList();
    clientcode = json["clientcode"];
    lstDealNumbers = json["lstDealNumbers"] == null
        ? null
        : (json["lstDealNumbers"] as List)
            .map((e) => LstDealNumbers.fromJson(e))
            .toList();
    lstBrands = json["lstBrands"] == null
        ? null
        : (json["lstBrands"] as List)
            .map((e) => LstBrands.fromJson(e))
            .toList();
    lstAgencies = json["lstAgencies"] == null
        ? null
        : (json["lstAgencies"] as List)
            .map((e) => LstAgencies.fromJson(e))
            .toList();
    agencyCode = json["agencyCode"];
    message = json["message"];
    executivesSelectedValue = json["executivesSelectedValue"] == null
        ? null
        : (json["executivesSelectedValue"] as List)
            .map((e) => ExecutivesSelectedValue.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationCode"] = locationCode;
    _data["channelCode"] = channelCode;
    if (lstChannel != null) {
      _data["lstChannel"] = lstChannel?.map((e) => e.toJson()).toList();
    }
    if (lstClients != null) {
      _data["lstClients"] = lstClients?.map((e) => e.toJson()).toList();
    }
    _data["clientcode"] = clientcode;
    if (lstDealNumbers != null) {
      _data["lstDealNumbers"] = lstDealNumbers?.map((e) => e.toJson()).toList();
    }
    if (lstBrands != null) {
      _data["lstBrands"] = lstBrands?.map((e) => e.toJson()).toList();
    }
    if (lstAgencies != null) {
      _data["lstAgencies"] = lstAgencies?.map((e) => e.toJson()).toList();
    }
    _data["agencyCode"] = agencyCode;
    _data["message"] = message;
    if (executivesSelectedValue != null) {
      _data["executivesSelectedValue"] =
          executivesSelectedValue?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ExecutivesSelectedValue {
  String? personnelCode;
  String? personnelName;

  ExecutivesSelectedValue({this.personnelCode, this.personnelName});

  ExecutivesSelectedValue.fromJson(Map<String, dynamic> json) {
    personnelCode = json["personnelCode"];
    personnelName = json["personnelName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["personnelCode"] = personnelCode;
    _data["personnelName"] = personnelName;
    return _data;
  }
}

class LstAgencies {
  String? agencyCode;
  String? agencyName;

  LstAgencies({this.agencyCode, this.agencyName});

  LstAgencies.fromJson(Map<String, dynamic> json) {
    agencyCode = json["agencyCode"];
    agencyName = json["agencyName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["agencyCode"] = agencyCode;
    _data["agencyName"] = agencyName;
    return _data;
  }
}

class LstBrands {
  String? brandcode;
  String? brandname;

  LstBrands({this.brandcode, this.brandname});

  LstBrands.fromJson(Map<String, dynamic> json) {
    brandcode = json["brandcode"];
    brandname = json["brandname"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["brandcode"] = brandcode;
    _data["brandname"] = brandname;
    return _data;
  }
}

class LstDealNumbers {
  String? code;
  String? name;

  LstDealNumbers({this.code, this.name});

  LstDealNumbers.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    return _data;
  }
}

class LstClients {
  String? clientName;
  String? clientCode;

  LstClients({this.clientName, this.clientCode});

  LstClients.fromJson(Map<String, dynamic> json) {
    clientName = json["clientName"];
    clientCode = json["clientCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["clientName"] = clientName;
    _data["clientCode"] = clientCode;
    return _data;
  }
}

class LstChannel {
  String? channelCode;
  String? channelName;

  LstChannel({this.channelCode, this.channelName});

  LstChannel.fromJson(Map<String, dynamic> json) {
    channelCode = json["channelCode"];
    channelName = json["channelName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["channelCode"] = channelCode;
    _data["channelName"] = channelName;
    return _data;
  }
}

class LstLoadXml {
  List<LstXmlDt>? lstXmlDt;
  List<String>? lstShowPrograms;

  LstLoadXml({this.lstXmlDt, this.lstShowPrograms});

  LstLoadXml.fromJson(Map<String, dynamic> json) {
    lstXmlDt = json["lstXmlDt"] == null
        ? null
        : (json["lstXmlDt"] as List).map((e) => LstXmlDt.fromJson(e)).toList();
    lstShowPrograms = json["lstShowPrograms"] == null
        ? null
        : List<String>.from(json["lstShowPrograms"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (lstXmlDt != null) {
      _data["lstXmlDt"] = lstXmlDt?.map((e) => e.toJson()).toList();
    }
    if (lstShowPrograms != null) {
      _data["lstShowPrograms"] = lstShowPrograms;
    }
    return _data;
  }
}

class LstXmlDt {
  String? rONum;
  String? rODate;
  String? clienTId;
  String? clienTName;
  String? statioNId;
  String? station;
  String? program;
  String? stime;
  String? etime;
  String? dur;
  String? title;
  String? acTDt;
  String? spoTRate;
  String? schDId;
  String? tapEId;
  String? branDId;
  String? brand;
  String? fpcStart;
  String? fpcProgram;
  String? commercialCaption;
  String? commercialDuration;
  String? pmTCls;
  String? spotStatus;
  String? dealNo;
  String? dealRow;
  String? amount;
  String? fctok;
  String? dealok;
  String? endTime;
  String? noSpot;
  String? okSpot;
  String? programCategoryName;
  String? groupCode;
  String? noProgram;
  String? segmentNumber;
  String? programCode;

  LstXmlDt(
      {this.rONum,
      this.rODate,
      this.clienTId,
      this.clienTName,
      this.statioNId,
      this.station,
      this.program,
      this.stime,
      this.etime,
      this.dur,
      this.title,
      this.acTDt,
      this.spoTRate,
      this.schDId,
      this.tapEId,
      this.branDId,
      this.brand,
      this.fpcStart,
      this.fpcProgram,
      this.commercialCaption,
      this.commercialDuration,
      this.pmTCls,
      this.spotStatus,
      this.dealNo,
      this.dealRow,
      this.amount,
      this.fctok,
      this.dealok,
      this.endTime,
      this.noSpot,
      this.okSpot,
      this.programCategoryName,
      this.groupCode,
      this.noProgram,
      this.segmentNumber,
      this.programCode});

  LstXmlDt.fromJson(Map<String, dynamic> json) {
    rONum = json["rO_NUM"];
    rODate = json["rO_DATE"];
    clienTId = json["clienT_ID"];
    clienTName = json["clienT_NAME"];
    statioNId = json["statioN_ID"];
    station = json["station"];
    program = json["program"];
    stime = json["stime"];
    etime = json["etime"];
    dur = json["dur"];
    title = json["title"];
    acTDt = json["acT_DT"];
    spoTRate = json["spoT_RATE"];
    schDId = json["schD_ID"];
    tapEId = json["tapE_ID"];
    branDId = json["branD_ID"];
    brand = json["brand"];
    fpcStart = json["fpcStart"];
    fpcProgram = json["fpcProgram"];
    commercialCaption = json["commercialCaption"];
    commercialDuration = json["commercialDuration"];
    pmTCls = json["pmT_CLS"];
    spotStatus = json["spot_Status"];
    dealNo = json["dealNo"];
    dealRow = json["dealRow"];
    amount = json["amount"];
    fctok = json["fctok"];
    dealok = json["dealok"];
    endTime = json["endTime"];
    noSpot = json["no_Spot"];
    okSpot = json["okSpot"];
    programCategoryName = json["programCategoryName"];
    groupCode = json["groupCode"];
    noProgram = json["noProgram"];
    segmentNumber = json["segmentNumber"];
    programCode = json["programCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["rO_NUM"] = rONum;
    _data["rO_DATE"] = rODate;
    _data["clienT_ID"] = clienTId;
    _data["clienT_NAME"] = clienTName;
    _data["statioN_ID"] = statioNId;
    _data["station"] = station;
    _data["program"] = program;
    _data["stime"] = stime;
    _data["etime"] = etime;
    _data["dur"] = dur;
    _data["title"] = title;
    _data["acT_DT"] = acTDt;
    _data["spoT_RATE"] = spoTRate;
    _data["schD_ID"] = schDId;
    _data["tapE_ID"] = tapEId;
    _data["branD_ID"] = branDId;
    _data["brand"] = brand;
    _data["fpcStart"] = fpcStart;
    _data["fpcProgram"] = fpcProgram;
    _data["commercialCaption"] = commercialCaption;
    _data["commercialDuration"] = commercialDuration;
    _data["pmT_CLS"] = pmTCls;
    _data["spot_Status"] = spotStatus;
    _data["dealNo"] = dealNo;
    _data["dealRow"] = dealRow;
    _data["amount"] = amount;
    _data["fctok"] = fctok;
    _data["dealok"] = dealok;
    _data["endTime"] = endTime;
    _data["no_Spot"] = noSpot;
    _data["okSpot"] = okSpot;
    _data["programCategoryName"] = programCategoryName;
    _data["groupCode"] = groupCode;
    _data["noProgram"] = noProgram;
    _data["segmentNumber"] = segmentNumber;
    _data["programCode"] = programCode;
    return _data;
  }
}
