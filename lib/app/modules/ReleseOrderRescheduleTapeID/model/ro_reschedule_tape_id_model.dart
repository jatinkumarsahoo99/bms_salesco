import 'package:bms_salesco/app/data/DropDownValue.dart';

///////////////////// on load data model/////////////////

class RORescheduleOnLoadModel {
  LoadData? loadData;

  RORescheduleOnLoadModel({this.loadData});

  RORescheduleOnLoadModel.fromJson(Map<String, dynamic> json) {
    loadData =
        json['loadData'] != null ? LoadData.fromJson(json['loadData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loadData != null) {
      data['loadData'] = loadData!.toJson();
    }
    return data;
  }
}

class LoadData {
  TimeFrame? timeFrame;
  List<DropDownValue>? lstLocation;

  LoadData({this.timeFrame, this.lstLocation});

  LoadData.fromJson(Map<String, dynamic> json) {
    timeFrame = json['timeFrame'] != null
        ? TimeFrame.fromJson(json['timeFrame'])
        : null;
    if (json['lstLocation'] != null) {
      lstLocation = <DropDownValue>[];
      json['lstLocation'].forEach((v) {
        lstLocation!.add(
            DropDownValue(key: v['locationCode'], value: v['locationName']));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (timeFrame != null) {
      data['timeFrame'] = timeFrame!.toJson();
    }
    if (lstLocation != null) {
      data['lstLocation'] = lstLocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeFrame {
  String? timeFormat;
  String? today;
  String? tdate;
  String? nextday;

  TimeFrame({this.timeFormat, this.today, this.tdate, this.nextday});

  TimeFrame.fromJson(Map<String, dynamic> json) {
    timeFormat = json['timeFormat'];
    today = json['today'];
    tdate = json['tdate'];
    nextday = json['nextday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeFormat'] = timeFormat;
    data['today'] = today;
    data['tdate'] = tdate;
    data['nextday'] = nextday;
    return data;
  }
}

//////////////////////////////////////////////////////////// Tape details model//////////////////
class RORescheduleTapeIDTapeDetailsModel {
  List<LsttapeDetails>? lsttapeDetails;

  RORescheduleTapeIDTapeDetailsModel({this.lsttapeDetails});

  RORescheduleTapeIDTapeDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['lsttapeDetails'] != null) {
      lsttapeDetails = <LsttapeDetails>[];
      json['lsttapeDetails'].forEach((v) {
        lsttapeDetails!.add(LsttapeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lsttapeDetails != null) {
      data['lsttapeDetails'] = lsttapeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LsttapeDetails {
  String? exportTapeCode;
  String? commercialCaption;
  String? revType;
  String? tapeLanguage;
  int? duration;

  LsttapeDetails(
      {this.exportTapeCode,
      this.commercialCaption,
      this.revType,
      this.tapeLanguage,
      this.duration});

  LsttapeDetails.fromJson(Map<String, dynamic> json) {
    exportTapeCode = json['exportTapeCode'];
    commercialCaption = json['commercialCaption'];
    revType = json['revType'];
    tapeLanguage = json['tapeLanguage'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exportTapeCode'] = exportTapeCode;
    data['commercialCaption'] = commercialCaption;
    data['revType'] = revType;
    data['tapeLanguage'] = tapeLanguage;
    data['duration'] = duration;
    return data;
  }
}

////////////////////////////////// GET Booking details ///////////////////////

class RORescheduleTapeIDBookingDetailsModel {
  List<LstBookingDetails>? lstBookingDetails;

  RORescheduleTapeIDBookingDetailsModel({this.lstBookingDetails});

  RORescheduleTapeIDBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['lstBookingDetails'] != null) {
      lstBookingDetails = <LstBookingDetails>[];
      json['lstBookingDetails'].forEach((v) {
        lstBookingDetails!.add(LstBookingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lstBookingDetails != null) {
      data['lstBookingDetails'] =
          lstBookingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstBookingDetails {
  bool? action;
  String? newTapeID;
  String? bookingNumber;
  String? programCode;
  String? revType;
  String? tapeLanguage;
  String? midPre;
  String? positionCode;
  String? programName;
  String? scheduleDate;
  String? scheduleTime;
  String? exportTapeCode;
  String? commercialCaption;
  int? tapeDuration;
  int? spotAmount;
  int? bookingDetailCode;
  int? recordnumber;
  int? segmentNumber;
  int? breakNumber;
  String? spotPositionTypeName;
  String? positionName;
  int? edit;
  String? bookingStatus;
  String? dealno;
  String? executiveCode;
  int? audited;
  String? killDate;
  String? campaignStartDate;
  String? campaignEndDate;

  LstBookingDetails(
      {this.action,
      this.newTapeID,
      this.bookingNumber,
      this.programCode,
      this.revType,
      this.tapeLanguage,
      this.midPre,
      this.positionCode,
      this.programName,
      this.scheduleDate,
      this.scheduleTime,
      this.exportTapeCode,
      this.commercialCaption,
      this.tapeDuration,
      this.spotAmount,
      this.bookingDetailCode,
      this.recordnumber,
      this.segmentNumber,
      this.breakNumber,
      this.spotPositionTypeName,
      this.positionName,
      this.edit,
      this.bookingStatus,
      this.dealno,
      this.executiveCode,
      this.audited,
      this.killDate,
      this.campaignStartDate,
      this.campaignEndDate});

  LstBookingDetails.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    newTapeID = json['newTapeID'];
    bookingNumber = json['bookingNumber'];
    programCode = json['programCode'];
    revType = json['revType'];
    tapeLanguage = json['tapeLanguage'];
    midPre = json['midPre'];
    positionCode = json['positionCode'];
    programName = json['programName'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    exportTapeCode = json['exportTapeCode'];
    commercialCaption = json['commercialCaption'];
    tapeDuration = json['tapeDuration'];
    spotAmount = json['spotAmount'];
    bookingDetailCode = json['bookingDetailCode'];
    recordnumber = json['recordnumber'];
    segmentNumber = json['segmentNumber'];
    breakNumber = json['breakNumber'];
    spotPositionTypeName = json['spotPositionTypeName'];
    positionName = json['positionName'];
    edit = json['edit'];
    bookingStatus = json['bookingStatus'];
    dealno = json['dealno'];
    executiveCode = json['executiveCode'];
    audited = json['audited'];
    killDate = json['killDate'];
    campaignStartDate = json['campaignStartDate'];
    campaignEndDate = json['campaignEndDate'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fromSave) {
      data['action'] = action;
      data['newTapeID'] = newTapeID;
      data['bookingNumber'] = bookingNumber;
      data['programCode'] = programCode;
      data['revType'] = revType;
      data['tapeLanguage'] = tapeLanguage;
      data['midPre'] = midPre;
      data['positionCode'] = positionCode;
      data['programName'] = programName;
      data['scheduleDate'] = scheduleDate;
      data['scheduleTime'] = scheduleTime;
      data['exportTapeCode'] = exportTapeCode;
      data['commercialCaption'] = commercialCaption;
      data['tapeDuration'] = tapeDuration;
      data['spotAmount'] = spotAmount;
      data['bookingDetailCode'] = bookingDetailCode;
      data['recordnumber'] = recordnumber;
      data['segmentNumber'] = segmentNumber;
      data['breakNumber'] = breakNumber;
      data['spotPositionTypeName'] = spotPositionTypeName;
      data['positionName'] = positionName;
      data['edit'] = edit;
      data['bookingStatus'] = bookingStatus;
      data['dealno'] = dealno;
      data['executiveCode'] = executiveCode;
      data['audited'] = audited;
      data['killDate'] = killDate;
      data['campaignStartDate'] = campaignStartDate;
      data['campaignEndDate'] = campaignEndDate;
    } else {
      data['action'] = (action ?? false).toString();
      data['newTapeID'] = (newTapeID ?? '').toString();
      data['bookingNumber'] = bookingNumber;
      data['programCode'] = programCode;
      data['revType'] = revType;
      data['tapeLanguage'] = tapeLanguage;
      data['midPre'] = midPre;
      data['positionCode'] = positionCode;
      data['programName'] = programName;
      data['scheduleDate'] = scheduleDate;
      data['scheduleTime'] = scheduleTime;
      data['exportTapeCode'] = exportTapeCode;
      data['commercialCaption'] = commercialCaption;
      data['tapeDuration'] = tapeDuration;
      data['spotAmount'] = spotAmount;
      data['bookingDetailCode'] = bookingDetailCode;
      data['recordnumber'] = recordnumber;
      data['segmentNumber'] = segmentNumber;
      data['breakNumber'] = breakNumber;
      data['spotPositionTypeName'] = spotPositionTypeName;
      data['positionName'] = positionName;
      data['edit'] = edit;
      data['bookingStatus'] = bookingStatus;
      data['dealno'] = dealno;
      data['executiveCode'] = executiveCode;
      data['audited'] = audited;
      data['killDate'] = killDate;
      data['campaignStartDate'] = campaignStartDate;
      data['campaignEndDate'] = campaignEndDate;
    }
    return data;
  }
}
