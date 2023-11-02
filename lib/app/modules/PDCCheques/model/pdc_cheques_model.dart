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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
