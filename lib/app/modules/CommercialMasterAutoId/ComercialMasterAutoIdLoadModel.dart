import 'package:bms_salesco/app/data/DropDownValue.dart';

class ComercialMasterAutoIdLoadModel {
  LoadData? loadData;

  ComercialMasterAutoIdLoadModel({this.loadData});

  ComercialMasterAutoIdLoadModel.fromJson(Map<String, dynamic> json) {
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
  List<DropDownValue>? location;

  LoadData(
      {this.lstProviders,
        this.lstNewMedia,
        this.lstLanguage,
        this.lstRevenuetype,
        this.lstCensorship,this.location});

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

    if (json['lstLocation'] != null) {
      location = <DropDownValue>[];
      json['lstLocation'].forEach((v) {
        location!.add( DropDownValue.fromJsonDynamic(v,"locationCode","locationName"));
      });
    }

  }
  LoadData.fromJson1(Map<String, dynamic> json) {
    if (json['lstNewMedia'] != null) {
      lstNewMedia = <LstNewMedia>[];
      json['lstNewMedia'].forEach((v) {
        lstNewMedia!.add(new LstNewMedia.fromJson(v));
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

    if (this.location != null) {
      data['lstLocation'] =
          this.location!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class LstNewMedia {
  int? acid;
  String? clientCode;
  String? brandcode;
  String? languagecode;
  String? clientName;
  String? brandName;
  String? provider;
  String? brand;
  String? commercialCaption;
  int? commercialDuration;
  String? language;
  String? clockId;
  String? exportTapeCode;
  String? territory;
  String? location;

  LstNewMedia(
      {this.acid,
        this.clientCode,
        this.brandcode,
        this.languagecode,
        this.clientName,
        this.brandName,
        this.provider,
        this.brand,
        this.commercialCaption,
        this.commercialDuration,
        this.language,
        this.clockId,
        this.exportTapeCode,
        this.territory,
        this.location});

  LstNewMedia.fromJson(Map<String, dynamic> json) {
    acid = json['acid'];
    clientCode = json['clientCode'];
    brandcode = json['brandcode'];
    languagecode = json['languagecode'];
    clientName = json['clientName'];
    brandName = json['brandName'];
    provider = json['provider'];
    brand = json['brand'];
    commercialCaption = json['commercialCaption'];
    commercialDuration = json['commercialDuration'];
    language = json['language'];
    clockId = json['clockId'];
    exportTapeCode = json['exportTapeCode'];
    territory = json['territory'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acid'] = this.acid;
    data['clientCode'] = this.clientCode;
    data['brandcode'] = this.brandcode;
    data['languagecode'] = this.languagecode;
    data['clientName'] = this.clientName;
    data['brandName'] = this.brandName;
    data['provider'] = this.provider;
    data['brand'] = this.brand;
    data['commercialCaption'] = this.commercialCaption;
    data['commercialDuration'] = this.commercialDuration;
    data['language'] = this.language;
    data['clockId'] = this.clockId;
    data['exportTapeCode'] = this.exportTapeCode;
    data['territory'] = this.territory;
    data['location'] = this.location;
    return data;
  }
}

