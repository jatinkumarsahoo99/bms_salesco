class MarkROSFlagModel {
  String? telecastDate;
  String? telecastTime;
  String? programName;
  String? programTypeName;
  String? originalRepeatName;
  int? episodeDuration;
  bool? flag;
  String? locationCode;
  String? channelCode;
  String? programCode;

  MarkROSFlagModel(
      {this.telecastDate,
      this.telecastTime,
      this.programName,
      this.programTypeName,
      this.originalRepeatName,
      this.episodeDuration,
      this.flag,
      this.locationCode,
      this.channelCode,
      this.programCode});

  MarkROSFlagModel.fromJson(Map<String, dynamic> json) {
    telecastDate = json['telecastDate'];
    telecastTime = json['telecastTime'];
    programName = json['programName'];
    programTypeName = json['programTypeName'];
    originalRepeatName = json['originalRepeatName'];
    episodeDuration = json['episodeDuration'];
    flag = json['flag'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    programCode = json['programCode'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (fromSave) {
      data['telecastDate'] = telecastDate;
      data['telecastTime'] = telecastTime;
      data['flag'] = flag;
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
      data['programCode'] = programCode;

      // data['programName'] = programName;
      // data['programTypeName'] = programTypeName;
      // data['originalRepeatName'] = originalRepeatName;
      // data['episodeDuration'] = episodeDuration;
    } else {
      data['telecastDate'] = telecastDate;
      data['telecastTime'] = telecastTime;
      data['programName'] = programName;
      data['programTypeName'] = programTypeName;
      data['originalRepeatName'] = originalRepeatName;
      data['episodeDuration'] = episodeDuration;
      data['flag'] = flag.toString();
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
      data['programCode'] = programCode;
    }
    return data;
  }
}
