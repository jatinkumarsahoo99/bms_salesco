class DealWorkDefinitionGridModel {
  List<Display>? display;

  DealWorkDefinitionGridModel({this.display});

  DealWorkDefinitionGridModel.fromJson(Map<String, dynamic> json) {
    if (json['display'] != null) {
      display = <Display>[];
      json['display'].forEach((v) {
        display!.add(new Display.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.display != null) {
      data['display'] = this.display!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Display {
  int? approvalSequenceID;
  String? sequenceName;
  String? formName;
  int? groupID;
  String? groupName;
  String? personnelNo;
  String? employees;
  String? employeeCode;

  Display(
      {this.approvalSequenceID,
        this.sequenceName,
        this.formName,
        this.groupID,
        this.groupName,
        this.personnelNo,
        this.employees,
        this.employeeCode
      });

  Display.fromJson(Map<String, dynamic> json) {
    approvalSequenceID = json['approvalSequenceID'];
    sequenceName = json['sequenceName'];
    formName = json['formName'];
    groupID = json['groupID'];
    groupName = json['groupName'];
    personnelNo = json['personnelNo'];
    employees = json['employees'];
    employeeCode = json['employeeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approvalSequenceID'] = this.approvalSequenceID;
    data['sequenceName'] = this.sequenceName;
    data['formName'] = this.formName;
    data['groupID'] = this.groupID;
    data['groupName'] = this.groupName;
    data['personnelNo'] = this.personnelNo;
    data['employees'] = this.employees;
    data['employeeCode'] = this.employeeCode;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approvalSequenceID'] = this.approvalSequenceID;
    data['sequenceName'] = this.sequenceName;
    data['formName'] = this.formName;
    data['groupID'] = this.groupID;
    data['groupName'] = this.groupName;
    data['personnelNo'] = this.personnelNo;
    data['employeename'] = this.employees;
    data['employeeCode'] = this.personnelNo;
    return data;
  }

}
