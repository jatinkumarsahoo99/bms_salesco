class TapeIDCampaignLoadModel {
  TapeIDCampaignLoadModel({
    required this.tapeIdDetails,
  });
  late final TapeIdDetails tapeIdDetails;

  TapeIDCampaignLoadModel.fromJson(Map<String, dynamic> json) {
    tapeIdDetails = TapeIdDetails.fromJson(json['tapeIdDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tapeIdDetails'] = tapeIdDetails.toJson();
    return _data;
  }
}

class TapeIdDetails {
  TapeIdDetails({
    required this.clientName,
    required this.agencyName,
    required this.brandName,
    required this.commercialCaption,
    required this.commercialDuration,
    required this.agencytapeid,
    required this.loginName,
    required this.brandCode,
    required this.locationLst,
  });
  late final String clientName;
  late final String agencyName;
  late final String brandName;
  late final String commercialCaption;
  late final int commercialDuration;
  late final String agencytapeid;
  late final String loginName;
  late final String brandCode;
  late final List<LocationLst> locationLst;

  TapeIdDetails.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    agencyName = json['agencyName'];
    brandName = json['brandName'];
    commercialCaption = json['commercialCaption'];
    commercialDuration = json['commercialDuration'];
    agencytapeid = json['agencytapeid'];
    loginName = json['loginName'];
    brandCode = json['brandCode'];
    locationLst = List.from(json['locationLst']).map((e) => LocationLst.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['clientName'] = clientName;
    _data['agencyName'] = agencyName;
    _data['brandName'] = brandName;
    _data['commercialCaption'] = commercialCaption;
    _data['commercialDuration'] = commercialDuration;
    _data['agencytapeid'] = agencytapeid;
    _data['loginName'] = loginName;
    _data['brandCode'] = brandCode;
    _data['locationLst'] = locationLst.map((e) => e.toJson()).toList();
    return _data;
  }
}

class LocationLst {
  LocationLst({
    required this.selectRow,
    required this.locationName,
    required this.channelName,
    required this.startDate,
    required this.endDate,
    required this.locationCode,
    required this.channelCode,
  });
  late final bool selectRow;
  late final String locationName;
  late final String channelName;
  late final String startDate;
  late final String endDate;
  late final String locationCode;
  late final String channelCode;

  LocationLst.fromJson(Map<String, dynamic> json) {
    selectRow = json['selectRow'];
    locationName = json['locationName'];
    channelName = json['channelName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final _data = <String, dynamic>{};
    if (fromSave) {
      _data['selectRow'] = selectRow;
      _data['locationCode'] = locationCode;
      _data['channelCode'] = channelCode;
      // _data['locationName'] = locationName;
      // _data['channelName'] = channelName;
      _data['startDate'] = startDate;
      _data['endDate'] = endDate;
    } else {
      _data['selectRow'] = selectRow.toString();
      _data['locationName'] = locationName;
      _data['channelName'] = channelName;
      _data['startDate'] = startDate;
      _data['endDate'] = endDate;
      _data['locationCode'] = locationCode;
      _data['channelCode'] = channelCode;
    }
    return _data;
  }
}

class TapeIdCampaignHistoryModel {
  TapeIdCampaignHistoryModel({
    required this.historyDetails,
  });
  late final List<HistoryDetails> historyDetails;

  TapeIdCampaignHistoryModel.fromJson(Map<String, dynamic> json) {
    historyDetails = List.from(json['historyDetails']).map((e) => HistoryDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['historyDetails'] = historyDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class HistoryDetails {
  HistoryDetails({
    required this.id,
    required this.locationName,
    required this.channelName,
    required this.brandName,
    required this.exportTapeCode,
    required this.startDate,
    required this.endDate,
    required this.activityMonth,
    required this.isActive,
  });
  late final int id;
  late final String locationName;
  late final String channelName;
  late final String brandName;
  late final String exportTapeCode;
  late final String startDate;
  late final String endDate;
  late final int activityMonth;
  late final bool isActive;

  HistoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['locationName'];
    channelName = json['channelName'];
    brandName = json['brandName'];
    exportTapeCode = json['exportTapeCode'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    activityMonth = json['activityMonth'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final _data = <String, dynamic>{};
    if (fromSave) {
      _data['id'] = id;
      _data['isActive'] = isActive;
    } else {
      _data['id'] = id;
      _data['locationName'] = locationName;
      _data['channelName'] = channelName;
      _data['brandName'] = brandName;
      _data['exportTapeCode'] = exportTapeCode;
      _data['startDate'] = startDate;
      _data['endDate'] = endDate;
      _data['activityMonth'] = activityMonth;
      _data['isActive'] = isActive;
    }
    return _data;
  }
}
