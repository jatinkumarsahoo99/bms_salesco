class RateCardFromDealWorkFlowModel {
  List<Export>? export;

  RateCardFromDealWorkFlowModel({this.export});

  RateCardFromDealWorkFlowModel.fromJson(Map<String, dynamic> json) {
    if (json['export'] != null) {
      export = <Export>[];
      json['export'].forEach((v) {
        export!.add(new Export.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.export != null) {
      data['export'] = this.export!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Export {
  String? programName;
  String? starttime;
  String? endtime;
  int? baseRate;
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? sun;

  Export(
      {this.programName,
        this.starttime,
        this.endtime,
        this.baseRate,
        this.mon,
        this.tue,
        this.wed,
        this.thu,
        this.fri,
        this.sat,
        this.sun});

  Export.fromJson(Map<String, dynamic> json) {
    programName = json['programName'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    baseRate = json['baseRate'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
    sat = json['sat'];
    sun = json['sun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programName'] = this.programName;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['baseRate'] = this.baseRate;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    return data;
  }
}
