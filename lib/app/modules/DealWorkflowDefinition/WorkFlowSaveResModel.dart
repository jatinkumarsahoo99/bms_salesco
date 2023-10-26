class WorkFlowSaveResModel {
  SaveData? save;

  WorkFlowSaveResModel({this.save});

  WorkFlowSaveResModel.fromJson(Map<String, dynamic> json) {
    save = json['save'] != null ? new SaveData.fromJson(json['save']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.save != null) {
      data['save'] = this.save!.toJson();
    }
    return data;
  }
}

class SaveData {
  List<LstApprovalTrail>? lstApprovalTrail;

  SaveData({this.lstApprovalTrail});

  SaveData.fromJson(Map<String, dynamic> json) {
    if (json['lstApprovalTrail'] != null) {
      lstApprovalTrail = <LstApprovalTrail>[];
      json['lstApprovalTrail'].forEach((v) {
        lstApprovalTrail!.add(new LstApprovalTrail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstApprovalTrail != null) {
      data['lstApprovalTrail'] =
          this.lstApprovalTrail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstApprovalTrail {
  int? approvalSequenceID;
  String? sequenceName;
  String? formName;
  String? groupID;
  String? groupName;
  String? personnelNo;
  String? employees;

  LstApprovalTrail(
      {this.approvalSequenceID,
        this.sequenceName,
        this.formName,
        this.groupID,
        this.groupName,
        this.personnelNo,
        this.employees});

  LstApprovalTrail.fromJson(Map<String, dynamic> json) {
    approvalSequenceID = json['approvalSequenceID'];
    sequenceName = json['sequenceName'];
    formName = json['formName'];
    groupID = (json['groupID']??"").toString();
    groupName = json['groupName'];
    personnelNo = json['personnelNo'];
    employees = json['employees'];
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
    return data;
  }
}
