class EdiRoInitData {
  List<LstLocation>? lstLocation;
  List<SoftListMyFiles>? softListMyFiles;
  List<LstSpotPosType>? lstSpotPosType;
  List<Executives>? executives;

  EdiRoInitData({this.lstLocation, this.softListMyFiles, this.lstSpotPosType, this.executives});

  EdiRoInitData.fromJson(Map<String, dynamic> json) {
    if (json['lstLocation'] != null) {
      lstLocation = <LstLocation>[];
      json['lstLocation'].forEach((v) {
        lstLocation!.add(LstLocation.fromJson(v));
      });
    }
    if (json['softListMyFiles'] != null) {
      softListMyFiles = <SoftListMyFiles>[];
      json['softListMyFiles'].forEach((v) {
        softListMyFiles!.add(SoftListMyFiles.fromJson(v));
      });
    }
    if (json['lstSpotPosType'] != null) {
      lstSpotPosType = <LstSpotPosType>[];
      json['lstSpotPosType'].forEach((v) {
        lstSpotPosType!.add(LstSpotPosType.fromJson(v));
      });
    }
    if (json['executives'] != null) {
      executives = <Executives>[];
      json['executives'].forEach((v) {
        executives!.add(Executives.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lstLocation != null) {
      data['lstLocation'] = lstLocation!.map((v) => v.toJson()).toList();
    }
    if (softListMyFiles != null) {
      data['softListMyFiles'] = softListMyFiles!.map((v) => v.toJson()).toList();
    }
    if (lstSpotPosType != null) {
      data['lstSpotPosType'] = lstSpotPosType!.map((v) => v.toJson()).toList();
    }
    if (executives != null) {
      data['executives'] = executives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstLocation {
  String? locationCode;
  String? locationName;

  LstLocation({this.locationCode, this.locationName});

  LstLocation.fromJson(Map<String, dynamic> json) {
    locationCode = json['locationCode'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locationCode'] = locationCode;
    data['locationName'] = locationName;
    return data;
  }
}

class SoftListMyFiles {
  String? convertedFileName;

  SoftListMyFiles({this.convertedFileName});

  SoftListMyFiles.fromJson(Map<String, dynamic> json) {
    convertedFileName = json['convertedFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['convertedFileName'] = convertedFileName;
    return data;
  }
}

class LstSpotPosType {
  String? spotPositionTypeCode;
  String? spotPositionTypeName;

  LstSpotPosType({this.spotPositionTypeCode, this.spotPositionTypeName});

  LstSpotPosType.fromJson(Map<String, dynamic> json) {
    spotPositionTypeCode = json['spotPositionTypeCode'];
    spotPositionTypeName = json['spotPositionTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spotPositionTypeCode'] = spotPositionTypeCode;
    data['spotPositionTypeName'] = spotPositionTypeName;
    return data;
  }
}

class Executives {
  String? personnelCode;
  String? personnelName;

  Executives({this.personnelCode, this.personnelName});

  Executives.fromJson(Map<String, dynamic> json) {
    personnelCode = json['personnelCode'];
    personnelName = json['personnelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personnelCode'] = personnelCode;
    data['personnelName'] = personnelName;
    return data;
  }
}
