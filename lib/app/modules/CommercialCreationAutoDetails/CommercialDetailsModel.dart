class CommercialDetailsModel {
  List<LstShowACID>? lstShowACID;

  CommercialDetailsModel({this.lstShowACID});

  CommercialDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? myCaption;
  int? acid;
  String? provider;
  String? advertiser;
  String? brand;
  String? commercialCaption;
  String? commercialDuration;
  String? commerciallanguage;
  String? agencyId;
  String? mailBody;
  String? createdon;
  String? clientCode;
  String? brandCode;
  String? updatedBy;
  String? updatedOn;
  String? commercialCode;
  String? languageCode;
  String? tapeid;
  String? endDate;
  String? txtSOM;
  String? brandName;
  String? clientName;
  int? txtDurationInSeconds;
  int? txtEOMDurationInSeconds;

  LstShowACID(
      {this.myCaption,
        this.acid,
        this.provider,
        this.advertiser,
        this.brand,
        this.commercialCaption,
        this.commercialDuration,
        this.commerciallanguage,
        this.agencyId,
        this.mailBody,
        this.createdon,
        this.clientCode,
        this.brandCode,
        this.updatedBy,
        this.updatedOn,
        this.commercialCode,
        this.languageCode,
        this.tapeid,
        this.endDate,
        this.txtSOM,
        this.txtDurationInSeconds,
        this.brandName,
        this.clientName,
        this.txtEOMDurationInSeconds});

  LstShowACID.fromJson(Map<String, dynamic> json) {
    myCaption = json['myCaption'];
    acid = json['acid'];
    provider = json['provider'];
    advertiser = json['advertiser'];
    brand = json['brand'];
    commercialCaption = json['commercialCaption'];
    commercialDuration = json['commercialDuration'];
    commerciallanguage = json['commerciallanguage'];
    agencyId = json['AgencyId'];
    mailBody = json['mailBody'];
    createdon = json['createdon'];
    clientCode = json['clientCode'];
    brandCode = json['brandCode'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    commercialCode = json['commercialCode'];
    languageCode = json['languageCode'];
    tapeid = json['tapeid'];
    endDate = json['endDate'];
    txtSOM = json['txtSOM'];
    txtDurationInSeconds = json['txtDurationInSeconds'];
    txtEOMDurationInSeconds = json['txtEOMDurationInSeconds'];
    brandName = json['brandName'];
    clientName = json['clientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myCaption'] = this.myCaption;
    data['acid'] = this.acid;
    data['provider'] = this.provider;
    data['advertiser'] = this.advertiser;
    data['brand'] = this.brand;
    data['commercialCaption'] = this.commercialCaption;
    data['commercialDuration'] = this.commercialDuration;
    data['commerciallanguage'] = this.commerciallanguage;
    data['AgencyId'] = this.agencyId;
    data['mailBody'] = this.mailBody;
    data['createdon'] = this.createdon;
    data['clientCode'] = this.clientCode;
    data['brandCode'] = this.brandCode;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    data['commercialCode'] = this.commercialCode;
    data['languageCode'] = this.languageCode;
    data['tapeid'] = this.tapeid;
    data['endDate'] = this.endDate;
    data['txtSOM'] = this.txtSOM;
    data['clientName'] = this.clientName;
    data['brandName'] = this.brandName;
    data['txtDurationInSeconds'] = this.txtDurationInSeconds;
    data['txtEOMDurationInSeconds'] = this.txtEOMDurationInSeconds;
    return data;
  }
}
