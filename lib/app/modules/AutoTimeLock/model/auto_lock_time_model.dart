class AutoTimeLockModel {
  String? channelName;
  String? channelCode;
  int? sameDayClose;
  String? resCanLockTime;
  String? channelLockYN;
  int? fpcLockDays;
  int? excessBooking;
  String? nextDayLockTime;

  AutoTimeLockModel(
      {this.channelName,
      this.channelCode,
      this.sameDayClose,
      this.resCanLockTime,
      this.channelLockYN,
      this.fpcLockDays,
      this.excessBooking,
      this.nextDayLockTime});

  AutoTimeLockModel.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    channelCode = json['channelCode'];
    sameDayClose = json['sameDayClose'];
    resCanLockTime = json['resCanLockTime'];
    channelLockYN = json['channelLockYN'];
    fpcLockDays = json['fpcLockDays'];
    excessBooking = json['excessBooking'];
    nextDayLockTime = json['nextDayLockTime'];
  }

  Map<String, dynamic> toJson({bool fromSave = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (fromSave) {
      data['channelCode'] = this.channelCode;
      data['nextDayLockTime'] = this.nextDayLockTime;
      data['lockTime'] = this.resCanLockTime;
      data['flag'] = this.channelLockYN;
      data['fpcLockDays'] = this.fpcLockDays;
      data['hours'] = this.sameDayClose;
      data['excessBook'] = this.excessBooking;
    } else {
      data['channelName'] = this.channelName;
      data['channelCode'] = this.channelCode;
      data['sameDayClose'] = this.sameDayClose;
      data['resCanLockTime'] = this.resCanLockTime;
      data['channelLockYN'] = this.channelLockYN;
      data['fpcLockDays'] = this.fpcLockDays;
      data['excessBooking %'] = this.excessBooking;
      data['nextDayLockTime'] = this.nextDayLockTime;
    }
    return data;
  }
}
