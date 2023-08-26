class DisPlayGroupModel {
  DisplayGroup? displayGroup;

  DisPlayGroupModel({this.displayGroup});

  DisPlayGroupModel.fromJson(Map<String, dynamic> json) {
    displayGroup = json['displayGroup'] != null
        ? new DisplayGroup.fromJson(json['displayGroup'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.displayGroup != null) {
      data['displayGroup'] = this.displayGroup!.toJson();
    }
    return data;
  }
}

class DisplayGroup {
  String? groupId;
  List<Employees>? employees;

  DisplayGroup({this.groupId, this.employees});

  DisplayGroup.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(new Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employees {
  String? personnelno;
  String? employees;

  Employees({this.personnelno, this.employees});

  Employees.fromJson(Map<String, dynamic> json) {
    personnelno = json['personnelno'];
    employees = json['employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personnelno'] = this.personnelno;
    data['employees'] = this.employees;
    return data;
  }
  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personnelno'] = this.personnelno;
    return data;
  }
}
