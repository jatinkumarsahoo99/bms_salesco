import 'package:intl/intl.dart';

class LocationChannelModel {
  bool? selectRow;
  String? locationName;
  String? channelName;
  String? locationCode;
  String? channelCode;

  LocationChannelModel(
      {this.selectRow,
      this.locationName,
      this.channelName,
      this.locationCode,
      this.channelCode});

  LocationChannelModel.fromJson(Map<String, dynamic> json) {
    selectRow = json['selectRow'];
    locationName = json['locationName'];
    channelName = json['channelName'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (fromSave) {
      // data['selectRow'] = selectRow;
      // data['locationName'] = locationName;
      // data['channelName'] = channelName;
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
    } else {
      data['selectRow'] = (selectRow ?? false).toString();
      data['locationName'] = locationName;
      data['channelName'] = channelName;
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
    }
    return data;
  }
}

class ChequeGroupingModel {
  bool? selectRow;
  String? chequeNo;
  String? consumeOn;
  String? chequeDate;
  num? chequeAmount;
  String? bankName;
  String? remarks;
  String? isDummy;
  String? approvedTill;
  num? chequeAmount1;
  String? revisedChequeNumber;
  num? revisedChequeAmount;
  String? revisedChequeBank;
  String? clientName;
  String? agencyName;
  num? activityPeriod;
  num? chequeId;

  ChequeGroupingModel(
      {this.selectRow,
      this.chequeNo,
      this.consumeOn,
      this.chequeDate,
      this.chequeAmount,
      this.bankName,
      this.remarks,
      this.isDummy,
      this.approvedTill,
      this.chequeAmount1,
      this.revisedChequeNumber,
      this.revisedChequeAmount,
      this.revisedChequeBank,
      this.clientName,
      this.agencyName,
      this.activityPeriod,
      this.chequeId});

  ChequeGroupingModel.fromJson(Map<String, dynamic> json) {
    selectRow = json['selectRow'];
    chequeNo = json['chequeNo'];
    consumeOn = json['consumeOn'];
    chequeDate = json['chequeDate'];
    chequeAmount = json['chequeAmount'];
    bankName = json['bankName'];
    remarks = json['remarks'];
    isDummy = json['isDummy'];
    approvedTill = json['approvedTill'];
    chequeAmount1 = json['chequeAmount1'];
    revisedChequeNumber = json['revisedChequeNumber'];
    revisedChequeAmount = json['revisedChequeAmount'];
    revisedChequeBank = json['revisedChequeBank'];
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    activityPeriod = json['activityPeriod'];
    chequeId = json['chequeId'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (fromSave) {
      // data['selectRow'] = selectRow;
      // data['chequeNo'] = chequeNo;
      // data['consumeOn'] = consumeOn;
      // data['chequeDate'] = chequeDate;
      // data['chequeAmount'] = chequeAmount;
      // data['bankName'] = bankName;
      // data['remarks'] = remarks;
      // data['isDummy'] = isDummy;
      // data['approvedTill'] = approvedTill;
      // data['chequeAmount1'] = chequeAmount1;
      // data['revisedChequeNumber'] = revisedChequeNumber;
      // data['revisedChequeAmount'] = revisedChequeAmount;
      // data['revisedChequeBank'] = revisedChequeBank;
      // data['clientName'] = clientName;
      // data['agencyName'] = agencyName;
      // data['activityPeriod'] = activityPeriod;
      data['chequeId'] = chequeId.toString();
    } else {
      data['selectRow'] = (selectRow ?? false).toString();
      data['chequeNo'] = chequeNo;
      data['consumeOn'] = consumeOn;
      data['chequeDate'] = (chequeDate ?? '').contains("T")
          ? DateFormat('dd-MM-yyyy')
              .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(chequeDate!))
          : chequeDate;
      data['chequeAmount'] = chequeAmount;
      data['bankName'] = bankName;
      data['remarks'] = remarks;
      data['isDummy'] = isDummy;
      data['approvedTill'] = approvedTill;
      data['chequeAmount1'] = chequeAmount1;
      data['revisedChequeNumber'] = revisedChequeNumber;
      data['revisedChequeAmount'] = revisedChequeAmount;
      data['revisedChequeBank'] = revisedChequeBank;
      data['clientName'] = clientName;
      data['agencyName'] = agencyName;
      data['activityPeriod'] = activityPeriod;
      data['chequeId'] = chequeId;
    }

    return data;
  }
}

class PDCRetriveModel {
  int? chequeId;
  String? clientCode;
  int? activityPeriod;
  String? chequeNo;
  String? chequeDate;
  int? chequeAmount;
  String? bankName;
  String? chequeReceivedBy;
  String? chequeReceivedOn;
  String? ccdVerifiedBy;
  String? ccdVerifiedOn;
  int? pdcTypeId;
  String? remarks;
  String? modifiedBy;
  String? modifiedOn;
  bool? isDummy;
  String? approvedTill;
  String? agencyCode;
  int? chequeAmountGross;
  int? serviceTaxPercent;
  int? serviceTaxAmount;
  int? tdsAmount;
  String? agencyName;
  String? clientName;
  String? pdcTypeName;
  List<LocationChannelModel>? locationChannelModel;

  PDCRetriveModel(
      {this.chequeId,
      this.clientCode,
      this.activityPeriod,
      this.chequeNo,
      this.chequeDate,
      this.chequeAmount,
      this.bankName,
      this.chequeReceivedBy,
      this.chequeReceivedOn,
      this.ccdVerifiedBy,
      this.ccdVerifiedOn,
      this.pdcTypeId,
      this.remarks,
      this.modifiedBy,
      this.modifiedOn,
      this.isDummy,
      this.approvedTill,
      this.agencyCode,
      this.chequeAmountGross,
      this.serviceTaxPercent,
      this.serviceTaxAmount,
      this.tdsAmount,
      this.agencyName,
      this.clientName,
      this.pdcTypeName,
      this.locationChannelModel});

  PDCRetriveModel.fromJson(Map<String, dynamic> json) {
    chequeId = json['chequeId'];
    clientCode = json['clientCode'];
    activityPeriod = json['activityPeriod'];
    chequeNo = json['chequeNo'];
    chequeDate = json['chequeDate'];
    chequeAmount = json['chequeAmount'];
    bankName = json['bankName'];
    chequeReceivedBy = json['chequeReceivedBy'];
    chequeReceivedOn = json['chequeReceivedOn'];
    ccdVerifiedBy = json['ccdVerifiedBy'];
    ccdVerifiedOn = json['ccdVerifiedOn'];
    pdcTypeId = json['pdcTypeId'];
    remarks = json['remarks'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    isDummy = json['isDummy'];
    approvedTill = json['approvedTill'];
    agencyCode = json['agencyCode'];
    chequeAmountGross = json['chequeAmountGross'];
    serviceTaxPercent = json['serviceTaxPercent'];
    serviceTaxAmount = json['serviceTaxAmount'];
    tdsAmount = json['tdsAmount'];
    agencyName = json['agencyName'];
    clientName = json['clientName'];
    pdcTypeName = json['pdcTypeName'];
    if (json['locationChannelModel'] != null) {
      locationChannelModel = <LocationChannelModel>[];
      json['locationChannelModel'].forEach((v) {
        locationChannelModel!.add(LocationChannelModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chequeId'] = chequeId;
    data['clientCode'] = clientCode;
    data['activityPeriod'] = activityPeriod;
    data['chequeNo'] = chequeNo;
    data['chequeDate'] = chequeDate;
    data['chequeAmount'] = chequeAmount;
    data['bankName'] = bankName;
    data['chequeReceivedBy'] = chequeReceivedBy;
    data['chequeReceivedOn'] = chequeReceivedOn;
    data['ccdVerifiedBy'] = ccdVerifiedBy;
    data['ccdVerifiedOn'] = ccdVerifiedOn;
    data['pdcTypeId'] = pdcTypeId;
    data['remarks'] = remarks;
    data['modifiedBy'] = modifiedBy;
    data['modifiedOn'] = modifiedOn;
    data['isDummy'] = isDummy;
    data['approvedTill'] = approvedTill;
    data['agencyCode'] = agencyCode;
    data['chequeAmountGross'] = chequeAmountGross;
    data['serviceTaxPercent'] = serviceTaxPercent;
    data['serviceTaxAmount'] = serviceTaxAmount;
    data['tdsAmount'] = tdsAmount;
    data['agencyName'] = agencyName;
    data['clientName'] = clientName;
    data['pdcTypeName'] = pdcTypeName;
    if (locationChannelModel != null) {
      data['locationChannelModel'] =
          locationChannelModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
