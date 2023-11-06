class ClientNameModel {
  List<ClientName>? clientName;

  ClientNameModel({this.clientName});

  ClientNameModel.fromJson(Map<String, dynamic> json) {
    if (json['clientName'] != null) {
      clientName = <ClientName>[];
      json['clientName'].forEach((v) {
        clientName!.add(new ClientName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientName != null) {
      data['clientName'] = this.clientName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientName {
  String? s0;
  String? s1;
  String? clientname;
  String? starttime;
  String? endtime;

  ClientName({this.s0, this.s1, this.clientname, this.starttime, this.endtime});

  ClientName.fromJson(Map<String, dynamic> json) {
    clientname = json['clientname'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    s0 = json['0'];
    s1 = json['1'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientname'] = this.clientname??"";
    data['starttime'] = this.starttime??"";
    data['endtime'] = this.endtime??"";
    data['0'] = this.s0??"";
    data['1'] = this.s1??"";

    return data;
  }
}
