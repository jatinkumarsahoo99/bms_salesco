class RoReceiveData {
  String? locationCode;
  String? channelCode;
  String? clientCode;
  String? agencyCode;
  String? brandCode;
  String? roNumber;
  String? roDate;
  int? activityMonth;
  int? roAmount;
  int? fct;
  bool? adDCAN;
  String? remarks;
  String? revenueType;
  String? zoneCode;
  int? valROAmount;

  RoReceiveData(
      {this.locationCode,
      this.channelCode,
      this.clientCode,
      this.agencyCode,
      this.brandCode,
      this.roNumber,
      this.roDate,
      this.activityMonth,
      this.roAmount,
      this.fct,
      this.adDCAN,
      this.remarks,
      this.revenueType,
      this.zoneCode,
      this.valROAmount});

  RoReceiveData.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    clientCode = json['clientCode'];
    agencyCode = json['agencyCode'];
    brandCode = json['brandCode'];
    roNumber = json['roNumber'];
    roDate = json['roDate'];
    activityMonth = json['activityMonth'];
    roAmount = json['roAmount'];
    fct = json['fct'];
    adDCAN = json['adD_CAN'];
    remarks = json['remarks'];
    revenueType = json['revenueType'];
    zoneCode = json['zoneCode'];
    valROAmount = json['valROAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    data['clientCode'] = this.clientCode;
    data['agencyCode'] = this.agencyCode;
    data['brandCode'] = this.brandCode;
    data['roNumber'] = this.roNumber;
    data['roDate'] = this.roDate;
    data['activityMonth'] = this.activityMonth;
    data['roAmount'] = this.roAmount;
    data['fct'] = this.fct;
    data['adD_CAN'] = this.adDCAN;
    data['remarks'] = this.remarks;
    data['revenueType'] = this.revenueType;
    data['zoneCode'] = this.zoneCode;
    data['valROAmount'] = this.valROAmount;
    return data;
  }
}
