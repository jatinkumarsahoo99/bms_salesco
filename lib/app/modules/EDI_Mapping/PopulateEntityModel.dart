class PopulateEntityModel {
  PopulateEntity? populateEntity;

  PopulateEntityModel({this.populateEntity});

  PopulateEntityModel.fromJson(Map<String, dynamic> json) {
    populateEntity = json['populateEntity'] != null
        ? new PopulateEntity.fromJson(json['populateEntity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.populateEntity != null) {
      data['populateEntity'] = this.populateEntity!.toJson();
    }
    return data;
  }
}

class PopulateEntity {
  bool? isClientMaster;
  bool? isAgencyMaster;
  bool? isChannelMaster;
  List<ClientMaster>? clientMaster;
  List<AgencyMaster>? agencyMaster;
  List<ChannelMaster>? channelMaster;

  PopulateEntity(
      {this.isClientMaster,
        this.isAgencyMaster,
        this.isChannelMaster,
        this.clientMaster,
        this.agencyMaster,
        this.channelMaster});

  PopulateEntity.fromJson(Map<String, dynamic> json) {
    isClientMaster = json['isClientMaster'];
    isAgencyMaster = json['isAgencyMaster'];
    isChannelMaster = json['isChannelMaster'];
    if (json['clientMaster'] != null) {
      clientMaster = <ClientMaster>[];
      json['clientMaster'].forEach((v) {
        clientMaster!.add(new ClientMaster.fromJson(v));
      });
    }
    if (json['agencyMaster'] != null) {
      agencyMaster = <AgencyMaster>[];
      json['agencyMaster'].forEach((v) {
        agencyMaster!.add(new AgencyMaster.fromJson(v));
      });
    }
    if (json['channelMaster'] != null) {
      channelMaster = <ChannelMaster>[];
      json['channelMaster'].forEach((v) {
        channelMaster!.add(new ChannelMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isClientMaster'] = this.isClientMaster;
    data['isAgencyMaster'] = this.isAgencyMaster;
    data['isChannelMaster'] = this.isChannelMaster;
    if (this.clientMaster != null) {
      data['clientMaster'] = this.clientMaster!.map((v) => v.toJson()).toList();
    }
    if (this.agencyMaster != null) {
      data['agencyMaster'] = this.agencyMaster!.map((v) => v.toJson()).toList();
    }
    if (this.channelMaster != null) {
      data['channelMaster'] =
          this.channelMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientMaster {
  int? sId;
  String? softClient;

  ClientMaster({this.sId, this.softClient});

  ClientMaster.fromJson(Map<String, dynamic> json) {
    sId = json['sId'];
    softClient = json['softClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['softClient'] = this.softClient;
    return data;
  }
}
class AgencyMaster {
  int? agencyId;
  String? softAgency;

  AgencyMaster({this.agencyId, this.softAgency});

  AgencyMaster.fromJson(Map<String, dynamic> json) {
    agencyId = json['agencyId'];
    softAgency = json['softAgency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agencyId'] = this.agencyId;
    data['softAgency'] = this.softAgency;
    return data;
  }
}

class ChannelMaster {
  int? SId;
  String? SoftChannel;

  ChannelMaster({this.SId, this.SoftChannel});

  ChannelMaster.fromJson(Map<String, dynamic> json) {
    SId = json['SId'];
    SoftChannel = json['SoftChannel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SId'] = this.SId;
    data['SoftChannel'] = this.SoftChannel;
    return data;
  }
}