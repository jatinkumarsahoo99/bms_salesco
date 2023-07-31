class DisPlayGroupModel {
  List<DisplayGroup>? displayGroup;

  DisPlayGroupModel({this.displayGroup});

  DisPlayGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['displayGroup'] != null) {
      displayGroup = <DisplayGroup>[];
      json['displayGroup'].forEach((v) {
        displayGroup!.add(new DisplayGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.displayGroup != null) {
      data['displayGroup'] = this.displayGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisplayGroup {
  String? personnelno;
  String? employees;

  DisplayGroup({this.personnelno, this.employees});

  DisplayGroup.fromJson(Map<String, dynamic> json) {
    personnelno = json['personnelno'];
    employees = json['employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personnelno'] = this.personnelno;
    data['employees'] = this.employees;
    return data;
  }
}
