import 'package:bms_salesco/app/providers/Utils.dart';

class AmagiSpotReplacementModel {
  LstSpots? lstSpots;

  AmagiSpotReplacementModel({this.lstSpots});

  AmagiSpotReplacementModel.fromJson(Map<String, dynamic> json) {
    lstSpots = json['lstSpots'] != null
        ? new LstSpots.fromJson(json['lstSpots'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstSpots != null) {
      data['lstSpots'] = this.lstSpots!.toJson();
    }
    return data;
  }
}

class LstSpots {
  List<MasterSpots>? masterSpots;
  List<LocalSpots>? localSpots;
  List<ChildChannel>? childChannel;
  String? fastInsertText;
  FastInserts? fastInserts;

  LstSpots(
      {this.masterSpots,
        this.localSpots,
        this.childChannel,
        this.fastInsertText,
        this.fastInserts});

  LstSpots.fromJson(Map<String, dynamic> json) {
    if (json['masterSpots'] != null) {
      masterSpots = <MasterSpots>[];
      json['masterSpots'].forEach((v) {
        masterSpots!.add(new MasterSpots.fromJson(v));
      });
    }
    if (json['localSpots'] != null) {
      localSpots = <LocalSpots>[];
      json['localSpots'].forEach((v) {
        localSpots!.add(new LocalSpots.fromJson(v));
      });
    }
    if (json['childChannel'] != null) {
      childChannel = <ChildChannel>[];
      json['childChannel'].forEach((v) {
        childChannel!.add(new ChildChannel.fromJson(v));
      });
    }
    fastInsertText = json['fastInsertText'];
    fastInserts = json['fastInserts'] != null
        ? new FastInserts.fromJson(json['fastInserts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.masterSpots != null) {
      data['masterSpots'] = this.masterSpots!.map((v) => v.toJson()).toList();
    }
    if (this.localSpots != null) {
      data['localSpots'] = this.localSpots!.map((v) => v.toJson()).toList();
    }
    if (this.childChannel != null) {
      data['childChannel'] = this.childChannel!.map((v) => v.toJson()).toList();
    }
    data['fastInsertText'] = this.fastInsertText;
    if (this.fastInserts != null) {
      data['fastInserts'] = this.fastInserts!.toJson();
    }
    return data;
  }
}

class MasterSpots {
  String? locationCode;
  String? channelCode;

  String? bookingNumber;
  bool? bookingNumberIsBold;
  int? bookingDetailCode;
  String? tapeCode;
  int? tapeDuration;
  int? rate;
  String? spotAmount;
  String? starttime;
  String? endTime;
  String? scheduleTime;

  String? scheduleDate;
  String? clientName;
  int? valuationrate;
  int? valuationAmount;
  String? brandName;
  int? hold;

  int? id;

  String? scheduleEndTime;
  int? combineSpots;
  int? neWID;
  int? tapeDuration1;
  String? tapeid;

  MasterSpots(
      {this.locationCode,
        this.channelCode,
        this.bookingNumber,
        this.bookingDetailCode,
        this.tapeCode,
        this.tapeDuration,
        this.rate,
        this.spotAmount,
        this.starttime,
        this.endTime,
        this.scheduleTime,
        this.id,
        this.scheduleDate,
        this.clientName,
        this.valuationrate,
        this.valuationAmount,
        this.brandName,
        this.hold,
        this.scheduleEndTime,
        this.combineSpots,
        this.neWID,
        this.tapeDuration1,
        this.tapeid,this.bookingNumberIsBold});

  MasterSpots.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    bookingNumber = json['bookingNumber'];
    bookingNumberIsBold = false;
    bookingDetailCode = json['bookingDetailCode'];
    tapeCode = json['tapeCode'];
    tapeDuration = json['tapeDuration'];
    rate = json['rate'];
    spotAmount = json['SpotAmount'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    scheduleTime = json['scheduleTime'];
    id = json['id'];
    scheduleDate = json['scheduleDate'];
    clientName = json['clientName'];
    valuationrate = json['valuationrate'];
    valuationAmount = json['valuationAmount'];
    brandName = json['brandName'];
    hold = json['hold'];
    scheduleEndTime = json['scheduleEndTime'];
    combineSpots = json['combineSpots'];
    neWID = json['neW_ID'];
    tapeDuration1 = json['tapeDuration1'];
    tapeid = json['tapeid']??"";
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;

    data['bookingDetailCode'] = this.bookingDetailCode;
    data['tapeCode'] = this.tapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['rate'] = this.rate;
    data['spotAmount'] = this.spotAmount;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['scheduleTime'] = this.scheduleTime;
    data['id'] = this.id;
    data['scheduleDate'] = Utils.formatDateTime4(scheduleDate);
    data['clientName'] = this.clientName;
    data['valuationrate'] = this.valuationrate;
    data['valuationAmount'] = this.valuationAmount;
    data['brandName'] = this.brandName;
    data['hold'] = this.hold;
    data['scheduleEndTime'] = this.scheduleEndTime;
    data['combineSpots'] = this.combineSpots;
    data['neW_ID'] = this.neWID;
    data['tapeDuration1'] = this.tapeDuration1;
    data['tapeid'] = this.tapeid;
    data['bookingNumberIsBold'] = this.bookingNumberIsBold;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;

    data['bookingDetailCode'] = this.bookingDetailCode;
    data['tapeCode'] = this.tapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['rate'] = this.rate;
    data['spotAmount'] = this.spotAmount;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['scheduleTime'] = this.scheduleTime;
    data['id'] = this.id;
    data['scheduleDate'] = this.scheduleDate;
    data['clientName'] = this.clientName;
    data['valuationrate'] = this.valuationrate;
    data['valuationAmount'] = this.valuationAmount;
    data['brandName'] = this.brandName;
    data['hold'] = this.hold;
    data['scheduleEndTime'] = this.scheduleEndTime;
    data['combineSpots'] = this.combineSpots;
    data['neW_ID'] = this.neWID;
    data['tapeDuration1'] = this.tapeDuration1;
    data['tapeid'] = this.tapeid;
    data['bookingNumberIsBold'] = this.bookingNumberIsBold;
    return data;
  }
}

class LocalSpots {
  int? colNo;

  int? channelid;

  String? locationCode;
  String? channelCode;

  String? bookingNumber;
  String? bookingNumberIsBold;
  int? bookingDetailCode;
  String? clientName;
  String? tapeCode;
  int? tapeDuration;
  int? rate;
  String? spotAmount;
  int? valuationrate;
  double? valuationAmount;
  String? starttime;
  String? endTime;
  int? parentID;

  int? id;
  int? clientPriority;
  double? priority;

  String? scheduleDate;
  String? brandCode;
  String? productName;
  String? dealno;
  int? dealRownumber;
  String? commercialCaption;
  String? channel;
  String? zoneName;

  LocalSpots(
      {this.colNo,
        this.channelid,
        this.locationCode,
        this.channelCode,
        this.bookingNumber,
        this.bookingDetailCode,
        this.clientName,
        this.tapeCode,
        this.tapeDuration,
        this.rate,
        this.spotAmount,
        this.valuationrate,
        this.valuationAmount,
        this.starttime,
        this.endTime,
        this.parentID,
        this.id,
        this.clientPriority,
        this.priority,
        this.scheduleDate,
        this.brandCode,
        this.productName,
        this.dealno,
        this.dealRownumber,
        this.commercialCaption,
        this.channel,
        this.zoneName,this.bookingNumberIsBold});

  LocalSpots.fromJson(Map<String, dynamic> json) {
    colNo = json['colNo'];
    channelid = json['channelid'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    bookingNumber = json['bookingNumber'];

    bookingDetailCode = json['bookingDetailCode'];
    clientName = json['clientName'];
    tapeCode = json['tapeCode'];
    tapeDuration = json['tapeDuration'];
    rate = json['rate'];
    spotAmount = json['SpotAmount'];
    valuationrate = json['valuationrate'];
    valuationAmount = json['valuationAmount'];
    starttime = json['starttime'];
    endTime = json['endTime'];
    parentID = json['parentID'];
    id = json['id'];
    clientPriority = json['clientPriority'];
    priority = json['priority'];
    scheduleDate = json['scheduleDate'];
    brandCode = json['brandCode'];
    productName = json['productName'];
    dealno = json['dealno'];
    dealRownumber = json['dealRownumber'];
    commercialCaption = json['commercialCaption'];
    channel = json['channel'];
    zoneName = json['zoneName'];
    bookingNumberIsBold = json['bookingNumberIsBold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colNo'] = this.colNo;
    data['channelid'] = this.channelid;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingNumberIsBold'] = this.bookingNumberIsBold;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['clientName'] = this.clientName;
    data['tapeCode'] = this.tapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['rate'] = this.rate;
    data['spotAmount'] = this.spotAmount;
    data['valuationrate'] = this.valuationrate;
    data['valuationAmount'] = this.valuationAmount;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['parentID'] = this.parentID;
    data['id'] = this.id;
    data['clientPriority'] = this.clientPriority;
    data['priority'] = this.priority;
    data['scheduleDate'] = this.scheduleDate;
    // data['scheduleDate'] = Utils.formatDateTime4(scheduleDate);
    data['brandCode'] = this.brandCode;
    data['productName'] = this.productName;
    data['dealno'] = this.dealno;
    data['dealRownumber'] = this.dealRownumber;
    data['commercialCaption'] = this.commercialCaption;
    data['channel'] = this.channel;
    data['zoneName'] = this.zoneName;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colNo'] = this.colNo;
    data['channelid'] = this.channelid;
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['bookingNumber'] = this.bookingNumber;
    data['bookingNumberIsBold'] = this.bookingNumberIsBold;
    data['bookingDetailCode'] = this.bookingDetailCode;
    data['clientName'] = this.clientName;
    data['tapeCode'] = this.tapeCode;
    data['tapeDuration'] = this.tapeDuration;
    data['rate'] = this.rate;
    data['spotAmount'] = this.spotAmount;
    data['valuationrate'] = this.valuationrate;
    data['valuationAmount'] = this.valuationAmount;
    data['starttime'] = this.starttime;
    data['endTime'] = this.endTime;
    data['parentID'] = this.parentID;
    data['id'] = this.id;
    data['clientPriority'] = this.clientPriority;
    data['priority'] = this.priority;
    // data['scheduleDate'] = this.scheduleDate;
    data['scheduleDate'] = Utils.formatDateTime4(scheduleDate);
    data['brandCode'] = this.brandCode;
    data['productName'] = this.productName;
    data['dealno'] = this.dealno;
    data['dealRownumber'] = this.dealRownumber;
    data['commercialCaption'] = this.commercialCaption;
    data['channel'] = this.channel;
    data['zoneName'] = this.zoneName;
    return data;
  }
}

class ChildChannel {
  String? locationCode;
  String? channelCode;

  int? totalSpots;
  int? unallocatedSpots;
  String? locationname;
  String? channelname;

  bool? channelnameIsBold;
  bool? locationnameIsBold;
  bool? unallocatedSpotsIsBold;
  bool? totalSpotsIsBold;

  int? channelid;
  int? isParent;
  int? colNo;



  ChildChannel(
      {this.locationCode,
        this.channelCode,
        this.channelid,
        this.isParent,
        this.colNo,
        this.locationname,
        this.channelname,
        this.totalSpots,
        this.unallocatedSpots,this.channelnameIsBold,this.locationnameIsBold,
        this.totalSpotsIsBold,this.unallocatedSpotsIsBold});

  ChildChannel.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    channelid = json['channelid'];
    isParent = json['isParent'];
    colNo = json['colNo'];
    locationname = json['locationname'];
    channelname = json['channelname'];
    totalSpots = json['totalSpots'];
    unallocatedSpots = json['unallocatedSpots'];

    channelnameIsBold = false;
    locationnameIsBold = false;
    totalSpotsIsBold = false;
    unallocatedSpotsIsBold = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['channelid'] = this.channelid;
    data['isParent'] = this.isParent;
    data['colNo'] = this.colNo;
    data['locationname'] = this.locationname;
    data['channelname'] = this.channelname;
    data['totalSpots'] = this.totalSpots;
    data['unallocatedSpots'] = this.unallocatedSpots;

    data['channelnameIsBold'] = this.channelnameIsBold;
    data['locationnameIsBold'] = this.locationnameIsBold;
    data['totalSpotsIsBold'] = this.totalSpotsIsBold;
    data['unallocatedSpotsIsBold'] = this.unallocatedSpotsIsBold;
    return data;
  }
}

class FastInserts {
  List<PromoResponse>? promoResponse;

  FastInserts({this.promoResponse});

  FastInserts.fromJson(Map<String, dynamic> json) {
    if (json['promoResponse'] != null) {
      promoResponse = <PromoResponse>[];
      json['promoResponse'].forEach((v) {
        promoResponse!.add( PromoResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promoResponse != null) {
      data['promoResponse'] =
          this.promoResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromoResponse {
  String? eventtype;
  String? caption;
  String? txCaption;
  String? txId;
  int? duration;
  String? som;
  int? segmentNumber;
  String? promoTypeCode;
  String? eventCode;

  PromoResponse(
      {this.eventtype,
        this.caption,
        this.txCaption,
        this.txId,
        this.duration,
        this.som,
        this.segmentNumber,
        this.promoTypeCode,
        this.eventCode});

  PromoResponse.fromJson(Map<String, dynamic> json) {
    eventtype = json['eventtype'];
    caption = json['caption'];
    txCaption = json['txCaption'];
    txId = json['txId'];
    duration = json['duration'];
    som = json['som'];
    segmentNumber = json['segmentNumber'];
    promoTypeCode = json['promoTypeCode'];
    eventCode = json['eventCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventtype'] = this.eventtype;
    data['caption'] = this.caption;
    data['txCaption'] = this.txCaption;
    data['txId'] = this.txId;
    data['duration'] = this.duration;
    data['som'] = this.som;
    data['segmentNumber'] = this.segmentNumber;
    data['promoTypeCode'] = this.promoTypeCode;
    data['eventCode'] = this.eventCode;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventtype'] = this.eventtype;
    data['caption'] = this.caption;
    data['txCaption'] = this.txCaption;
    data['txId'] = this.txId;
    data['duration'] = this.duration;
    data['som'] = this.som;
    data['segmentNumber'] = (this.segmentNumber == 0)?"":segmentNumber;
    data['promoTypeCode'] = this.promoTypeCode;
    data['eventCode'] = this.eventCode;
    return data;
  }

}
