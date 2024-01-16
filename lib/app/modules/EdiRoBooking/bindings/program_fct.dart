import 'package:intl/intl.dart';

class InfoCheckAllProgramFct {
  InfoCheckAllProgramFct1? infoCheckAllProgramFct;

  InfoCheckAllProgramFct({this.infoCheckAllProgramFct});

  InfoCheckAllProgramFct.fromJson(Map<String, dynamic> json) {
    infoCheckAllProgramFct = json["infoCheckAllProgramFCT"] == null
        ? null
        : InfoCheckAllProgramFct1.fromJson(json["infoCheckAllProgramFCT"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (infoCheckAllProgramFct != null) {
      _data["infoCheckAllProgramFCT"] = infoCheckAllProgramFct?.toJson();
    }
    return _data;
  }
}

class InfoCheckAllProgramFct1 {
  int? totalValAmount;
  int? totalBookedAmount;
  dynamic message;
  GetTimeAvailable? getTimeAvailable;

  InfoCheckAllProgramFct1(
      {this.totalValAmount,
      this.totalBookedAmount,
      this.message,
      this.getTimeAvailable});

  InfoCheckAllProgramFct1.fromJson(Map<String, dynamic> json) {
    totalValAmount = json["totalValAmount"];
    totalBookedAmount = json["totalBookedAmount"];
    message = json["message"];
    getTimeAvailable = json["getTimeAvailable"] == null
        ? null
        : GetTimeAvailable.fromJson(json["getTimeAvailable"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalValAmount"] = totalValAmount;
    _data["totalBookedAmount"] = totalBookedAmount;
    _data["message"] = message;
    if (getTimeAvailable != null) {
      _data["getTimeAvailable"] = getTimeAvailable?.toJson();
    }
    return _data;
  }
}

class GetTimeAvailable {
  String? dtpEffDate;
  String? txtSpots;
  String? txtDuration;
  String? txtAmount;
  String? txtValAmount;
  List<LstSpot>? lstSpot;
  dynamic message;

  GetTimeAvailable(
      {this.dtpEffDate,
      this.txtSpots,
      this.txtDuration,
      this.txtAmount,
      this.txtValAmount,
      this.lstSpot,
      this.message});

  GetTimeAvailable.fromJson(Map<String, dynamic> json) {
    dtpEffDate = json["dtpEffDate"];
    txtSpots = json["txtSpots"];
    txtDuration = json["txtDuration"];
    txtAmount = json["txtAmount"];
    txtValAmount = json["txtValAmount"];
    lstSpot = json["lstSpot"] == null
        ? null
        : (json["lstSpot"] as List).map((e) => LstSpot.fromJson(e)).toList();
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dtpEffDate"] = dtpEffDate;
    _data["txtSpots"] = txtSpots;
    _data["txtDuration"] = txtDuration;
    _data["txtAmount"] = txtAmount;
    _data["txtValAmount"] = txtValAmount;
    if (lstSpot != null) {
      _data["lstSpot"] = lstSpot?.map((e) => e.toJson()).toList();
    }
    _data["message"] = message;
    return _data;
  }
}

class LstSpot {
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

  LstSpot(
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

  LstSpot.fromJson(Map<String, dynamic> json) {
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
    _data["acT_DT"] = dateConvertToyyyy(acTDt ?? "");
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

String dateConvertToyyyy(String date) {
  return (DateFormat('yyyy-MM-ddTHH:mm:ss')
      .format(DateFormat('dd-MM-yyyy').parse(date)));
}
