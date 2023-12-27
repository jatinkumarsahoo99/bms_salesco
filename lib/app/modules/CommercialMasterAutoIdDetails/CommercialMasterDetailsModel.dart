class CommercialMasterDetailsModel {
  List<LstShowACID>? lstShowACID;

  CommercialMasterDetailsModel({this.lstShowACID});

  CommercialMasterDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['lstShowACID'] != null) {
      lstShowACID = <LstShowACID>[];
      json['lstShowACID'].forEach((v) {
        lstShowACID!.add(new LstShowACID.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstShowACID != null) {
      data['lstShowACID'] = this.lstShowACID!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstShowACID {
  String? languageName;
  String? censorshipShortName;
  String? accountname;
  String? eventName;
  int? acid;
  String? clientCode;
  String? mailBody;
  String? brandcode;
  String? languagecode;
  String? censorshipCode;
  String? revenueCode;
  int? secTypeCode;
  String? clientName;
  String? brandName;
  String? provider;
  String? brand;
  String? commercialCaption;
  int? commercialDuration;
  String? language;
  String? clockId;
  String? exportTapeCode;
  String? censorship;
  String? revenue;
  String? secType;
  String? locationCode;
  String? territory;
  String? locationName;
  String? tapeType;
  String? endDate;
  String? txtSOM;
  int? txtDurationInSeconds;
  int? txtEOMDurationInSeconds;
  String? tapeid;

  LstShowACID(
      {this.languageName,
        this.censorshipShortName,
        this.accountname,
        this.eventName,
        this.acid,
        this.clientCode,
        this.mailBody,
        this.brandcode,
        this.languagecode,
        this.censorshipCode,
        this.revenueCode,
        this.secTypeCode,
        this.clientName,
        this.brandName,
        this.provider,
        this.brand,
        this.commercialCaption,
        this.commercialDuration,
        this.language,
        this.clockId,
        this.exportTapeCode,
        this.censorship,
        this.revenue,
        this.secType,
        this.locationCode,
        this.territory,
        this.locationName,
        this.tapeType,
        this.endDate,
        this.txtSOM,
        this.txtDurationInSeconds,
        this.txtEOMDurationInSeconds,
        this.tapeid});

  LstShowACID.fromJson(Map<String, dynamic> json) {
    languageName = json['languageName'];
    censorshipShortName = json['censorshipShortName'];
    accountname = json['accountname'];
    eventName = json['eventName'];
    acid = json['acid'];
    clientCode = json['clientCode'];
    mailBody = json['mailBody'];
    brandcode = json['brandcode'];
    languagecode = json['languagecode'];
    censorshipCode = (json['censorshipCode']??"").toString();
    revenueCode = json['revenueCode'];
    secTypeCode = json['secTypeCode'];
    clientName = json['clientName'];
    brandName = json['brandName'];
    provider = json['provider'];
    brand = json['brand'];
    commercialCaption = json['commercialCaption'];
    commercialDuration = json['commercialDuration'];
    language = json['language'];
    clockId = json['clockId'];
    exportTapeCode = json['exportTapeCode'];
    censorship = json['censorship'];
    revenue = json['revenue'];
    secType = json['secType'];
    locationCode = json['locationCode'];
    territory = json['territory'];
    locationName = json['locationName'];
    tapeType = json['tapeType'];
    endDate = json['endDate'];
    txtSOM = json['txtSOM'];
    txtDurationInSeconds = json['txtDurationInSeconds'];
    txtEOMDurationInSeconds = json['txtEOMDurationInSeconds'];
    tapeid = json['tapeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languageName'] = this.languageName;
    data['censorshipShortName'] = this.censorshipShortName;
    data['accountname'] = this.accountname;
    data['eventName'] = this.eventName;
    data['acid'] = this.acid;
    data['clientCode'] = this.clientCode;
    data['mailBody'] = this.mailBody;
    data['brandcode'] = this.brandcode;
    data['languagecode'] = this.languagecode;
    data['censorshipCode'] = this.censorshipCode;
    data['revenueCode'] = this.revenueCode;
    data['secTypeCode'] = this.secTypeCode;
    data['clientName'] = this.clientName;
    data['brandName'] = this.brandName;
    data['provider'] = this.provider;
    data['brand'] = this.brand;
    data['commercialCaption'] = this.commercialCaption;
    data['commercialDuration'] = this.commercialDuration;
    data['language'] = this.language;
    data['clockId'] = this.clockId;
    data['exportTapeCode'] = this.exportTapeCode;
    data['censorship'] = this.censorship;
    data['revenue'] = this.revenue;
    data['secType'] = this.secType;
    data['locationCode'] = this.locationCode;
    data['territory'] = this.territory;
    data['locationName'] = this.locationName;
    data['tapeType'] = this.tapeType;
    data['endDate'] = this.endDate;
    data['txtSOM'] = this.txtSOM;
    data['txtDurationInSeconds'] = this.txtDurationInSeconds;
    data['txtEOMDurationInSeconds'] = this.txtEOMDurationInSeconds;
    data['tapeid'] = this.tapeid;
    return data;
  }
}

