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
  RateCardFromDealWorkFlowModel.fromJson1(Map<String, dynamic> json) {
    if (json['S1'] != null) {
      export = <Export>[];
      json['S1'].forEach((v) {
        export!.add(new Export.fromJson1(v));
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
  Export.fromJson1(Map<String, dynamic> json) {
    programName = json['programName'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    baseRate = int.parse((json['baseRate'] != null && json['baseRate'] != "")?json['baseRate']:"0");
    mon = int.parse((json['mon'] != null && json['mon'] != "")?json['mon']:"0") ;
    tue = int.parse((json['tue'] != null && json['tue'] != "")?json['tue']:"0");
    wed = int.parse((json['wed'] != null && json['wed'] != "")?json['wed']:"0");
    thu =  int.parse((json['thu'] != null && json['thu'] != "")?json['thu']:"0");
    fri =int.parse((json['fri'] != null && json['fri'] != "")?json['fri']:"0");
    sat = int.parse((json['sat'] != null && json['sat'] != "")?json['sat']:"0");
    sun = int.parse((json['sun'] != null && json['sun'] != "")?json['sun']:"0");
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
  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programName'] = this.programName;
    data['starttime'] =  "1899-12-30T${this.starttime}";
    data['endtime'] = "1899-12-30T${this.endtime}" ;

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
