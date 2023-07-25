import 'package:bms_salesco/app/data/DropDownValue.dart';

class ComercialAutoLoadModel {
  LoadData? loadData;

  ComercialAutoLoadModel({this.loadData});

  ComercialAutoLoadModel.fromJson(Map<String, dynamic> json) {
    loadData = json['loadData'] != null
        ? new LoadData.fromJson(json['loadData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loadData != null) {
      data['loadData'] = this.loadData!.toJson();
    }
    return data;
  }
}

class LoadData {
  List<DropDownValue>? lstProviders;
  List<LstNewMedia>? lstNewMedia;
  List<DropDownValue>? lstLanguage;
  List<DropDownValue>? lstRevenuetype;
  List<DropDownValue>? lstCensorship;

  LoadData(
      {this.lstProviders,
        this.lstNewMedia,
        this.lstLanguage,
        this.lstRevenuetype,
        this.lstCensorship});

  LoadData.fromJson(Map<String, dynamic> json) {
    if (json['lstProviders'] != null) {
      lstProviders = <DropDownValue>[];
      json['lstProviders'].forEach((v) {
        lstProviders!.add(new DropDownValue.fromJsonDynamic(v,"provider","provider"));
      });
    }
    if (json['lstLanguage'] != null) {
      lstLanguage = <DropDownValue>[];
      json['lstLanguage'].forEach((v) {
        lstLanguage!.add(new DropDownValue.fromJsonDynamic(v,"languageCode","languagename"));
      });
    }
    if (json['lstNewMedia'] != null) {
      lstNewMedia = <LstNewMedia>[];
      json['lstNewMedia'].forEach((v) {
        lstNewMedia!.add(new LstNewMedia.fromJson(v));
      });
    }
    if (json['lstRevenuetype'] != null) {
      lstRevenuetype = <DropDownValue>[];
      json['lstRevenuetype'].forEach((v) {
        lstRevenuetype!.add(new DropDownValue.fromJsonDynamic(v,"accountCode","accountname"));
      });
    }
    if (json['lstCensorship'] != null) {
      lstCensorship = <DropDownValue>[];
      json['lstCensorship'].forEach((v) {
        lstCensorship!.add(new DropDownValue.fromJsonDynamic(v,"censorshipCode","censorshipShortName"));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstProviders != null) {
      data['lstProviders'] = this.lstProviders!.map((v) => v.toJson()).toList();
    }
    data['lstNewMedia'] = this.lstNewMedia;
    if (this.lstLanguage != null) {
      data['lstLanguage'] = this.lstLanguage!.map((v) => v.toJson()).toList();
    }
    if (this.lstRevenuetype != null) {
      data['lstRevenuetype'] =
          this.lstRevenuetype!.map((v) => v.toJson()).toList();
    }
    if (this.lstCensorship != null) {
      data['lstCensorship'] =
          this.lstCensorship!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstNewMedia {
  String? clientName;
  String? brandName;
  String? provider;
  String? advertiser;
  String? brand;
  String? commercialCaption;
  String? commercialDuration;
  String? commerciallanguage;
  String? clockid;
  String? createdon;
  String? tapeid;

  LstNewMedia(
      {this.clientName,
        this.brandName,
        this.provider,
        this.advertiser,
        this.brand,
        this.commercialCaption,
        this.commercialDuration,
        this.commerciallanguage,
        this.clockid,
        this.createdon,
        this.tapeid});

  LstNewMedia.fromJson(Map<String, dynamic> json) {
    clientName = json['clientName'];
    brandName = json['brandName'];
    provider = json['provider'];
    advertiser = json['advertiser'];
    brand = json['brand'];
    commercialCaption = json['commercialCaption'];
    commercialDuration = json['commercialDuration'];
    commerciallanguage = json['commerciallanguage'];
    clockid = json['clockid'];
    createdon = json['createdon'];
    tapeid = json['tapeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientName'] = this.clientName;
    data['brandName'] = this.brandName;
    data['provider'] = this.provider;
    data['advertiser'] = this.advertiser;
    data['brand'] = this.brand;
    data['commercialCaption'] = this.commercialCaption;
    data['commercialDuration'] = this.commercialDuration;
    data['commerciallanguage'] = this.commerciallanguage;
    data['clockid'] = this.clockid;
    data['createdon'] = this.createdon;
    data['tapeid'] = this.tapeid;
    return data;
  }
}
