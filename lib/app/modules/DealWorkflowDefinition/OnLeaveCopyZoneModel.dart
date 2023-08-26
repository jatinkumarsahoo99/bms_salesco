class OnLeaveCopyZoneModel {
  List<OnLeaveCopyZone>? onLeaveCopyZone;

  OnLeaveCopyZoneModel({this.onLeaveCopyZone});

  OnLeaveCopyZoneModel.fromJson(Map<String, dynamic> json) {
    if (json['onLeaveCopyZone'] != null) {
      onLeaveCopyZone = <OnLeaveCopyZone>[];
      json['onLeaveCopyZone'].forEach((v) {
        onLeaveCopyZone!.add(new OnLeaveCopyZone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onLeaveCopyZone != null) {
      data['onLeaveCopyZone'] =
          this.onLeaveCopyZone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnLeaveCopyZone {
  String? stationcode;
  String? stationname;
  bool? isChecked = false;

  OnLeaveCopyZone({this.stationcode, this.stationname,this.isChecked});

  OnLeaveCopyZone.fromJson(Map<String, dynamic> json) {
    stationcode = json['stationcode'];
    stationname = json['stationname'];
    isChecked = json['isChecked']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationcode'] = this.stationcode;
    data['stationname'] = this.stationname;
    data['isChecked'] = this.isChecked??false;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationcode'] = this.stationcode;
    return data;
  }

}
