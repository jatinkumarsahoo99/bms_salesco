import '../../providers/Utils.dart';

class ZoneWiseUtilizationResponseModel {
  List<Generate>? generate;

  ZoneWiseUtilizationResponseModel({this.generate});

  ZoneWiseUtilizationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['generate'] != null) {
      generate = <Generate>[];
      json['generate'].forEach((v) {
        generate!.add(new Generate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generate != null) {
      data['generate'] = this.generate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Generate {
  String? programname;
  String? scheduledate;
  String? scheduletime;
  String? zonename;
  int? bookedduration;
  int? commduration;
  int? usacap;
  int? indiacap;
  int? balusa;
  int? balind;

  Generate(
      {this.programname,
        this.scheduledate,
        this.scheduletime,
        this.zonename,
        this.bookedduration,
        this.commduration,
        this.usacap,
        this.indiacap,
        this.balusa,
        this.balind});

  Generate.fromJson(Map<String, dynamic> json) {
    programname = json['programname'];
    scheduledate = json['scheduledate'];
    scheduletime = json['scheduletime'];
    zonename = json['zonename'];
    bookedduration = json['bookedduration'];
    commduration = json['commduration'];
    usacap = json['usacap'];
    indiacap = json['indiacap'];
    balusa = json['balusa'];
    balind = json['balind'];
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programname'] = this.programname;
    data['scheduledate'] = this.scheduledate;
    data['scheduletime'] = this.scheduletime;
    data['zonename'] = this.zonename;
    data['bookedduration'] = this.bookedduration;
    data['commduration'] = this.commduration;
    data['usacap'] = this.usacap;
    data['indiacap'] = this.indiacap;
    data['balusa'] = this.balusa;
    data['balind'] = this.balind;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programname'] = this.programname;
    data['scheduledate'] = (Utils.toDateFormat4(this.scheduledate));
    data['scheduletime'] = (Utils.toDateFormat4(this.scheduletime));
    data['zonename'] = this.zonename;
    data['bookedduration'] = this.bookedduration;
    data['commduration'] = this.commduration;
    data['usacap'] = this.usacap;
    data['indiacap'] = this.indiacap;
    data['balusa'] = this.balusa;
    data['balind'] = this.balind;
    return data;
  }
  
}
