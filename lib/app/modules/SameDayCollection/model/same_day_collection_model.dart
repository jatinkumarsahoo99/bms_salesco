import 'package:intl/intl.dart';

class SameDayCollectionModel {
  bool? cancel;
  String? locationCode;
  String? channelCode;
  String? bookingNumber;
  num? bookingDetailCode;
  String? clientname;
  String? agencyname;
  String? brandname;
  String? dealNumber;
  String? commercialCaption;
  String? scheduleDate;
  String? scheduleTime;
  String? dealTime;
  num? spotAmount;
  num? tapeDuration;
  num? rate;
  num? valuationrate;
  String? zoneName;

  SameDayCollectionModel(
      {this.cancel,
      this.locationCode,
      this.channelCode,
      this.bookingNumber,
      this.bookingDetailCode,
      this.clientname,
      this.agencyname,
      this.brandname,
      this.dealNumber,
      this.commercialCaption,
      this.scheduleDate,
      this.scheduleTime,
      this.dealTime,
      this.spotAmount,
      this.tapeDuration,
      this.rate,
      this.valuationrate,
      this.zoneName});

  SameDayCollectionModel.fromJson(Map<String, dynamic> json) {
    cancel = json['cancel'];
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
    bookingNumber = json['bookingNumber'];
    bookingDetailCode = json['bookingDetailCode'];
    clientname = json['clientname'];
    agencyname = json['agencyname'];
    brandname = json['brandname'];
    dealNumber = json['dealNumber'];
    commercialCaption = json['commercialCaption'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    dealTime = json['dealTime'];
    spotAmount = json['spotAmount'];
    tapeDuration = json['tapeDuration'];
    rate = json['rate'];
    valuationrate = json['valuationrate'];
    zoneName = json['zoneName'];
  }

  Map<String, dynamic> toJson({bool fromSame = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fromSame) {
      data['cancel'] = (cancel ?? false);
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
      data['bookingNumber'] = bookingNumber;
      data['bookingDetailCode'] = bookingDetailCode;
      data['zoneName'] = zoneName;
    } else {
      data['cancel'] = (cancel ?? false).toString();
      data['locationCode'] = locationCode;
      data['channelCode'] = channelCode;
      data['bookingNumber'] = bookingNumber;
      data['bookingDetailCode'] = bookingDetailCode;
      data['clientname'] = clientname;
      data['agencyname'] = agencyname;
      data['brandname'] = brandname;
      data['dealNumber'] = dealNumber;
      data['commercialCaption'] = commercialCaption;
      data['scheduleDate'] = (scheduleDate ?? '').contains("T")
          ? DateFormat('dd-MM-yyyy')
              .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(scheduleDate!))
          : scheduleDate;
      data['scheduleTime'] = scheduleTime;
      data['dealTime'] = dealTime;
      data['spotAmount'] = spotAmount;
      data['tapeDuration'] = tapeDuration;
      data['rate'] = rate;
      data['valuationrate'] = valuationrate;
      data['zoneName'] = zoneName;
    }
    return data;
  }
}
