import 'package:intl/intl.dart';

class RescheduleImportModel {
  List<Lstreimport>? lstreimport;
  String? locationCode;
  String? channelCode;

  RescheduleImportModel(
      {this.lstreimport, this.locationCode, this.channelCode});

  RescheduleImportModel.fromJson(Map<String, dynamic> json) {
    if (json['lstreimport'] != null) {
      lstreimport = <Lstreimport>[];
      json['lstreimport'].forEach((v) {
        lstreimport!.add(new Lstreimport.fromJson(v));
      });
    }
    locationCode = json['locationCode'];
    channelCode = json['channelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstreimport != null) {
      data['lstreimport'] = this.lstreimport!.map((v) => v.toJson1()).toList();
    }
    data['locationCode'] = this.locationCode;
    data['channelCode'] = this.channelCode;
    return data;
  }
}

class Lstreimport {
  String? tONumber;
  String? bDC;
  String? dealNo;
  String? dealRowNo;
  String? progName;
  String? schDate;
  String? nEWTIME;
  String? progEndTime;
  String? clientName;
  String? agencyName;
  String? rONO;
  String? brand;
  String? tapeId;
  String? caption;
  String? dur;
  String? amt;
  String? eR;
  String? spotType;
  String? startTime;
  String? endTime;
  String? nEWDATE;

  Lstreimport(
      {this.tONumber,
        this.bDC,
        this.dealNo,
        this.dealRowNo,
        this.progName,
        this.schDate,
        this.nEWTIME,
        this.progEndTime,
        this.clientName,
        this.agencyName,
        this.rONO,
        this.brand,
        this.tapeId,
        this.caption,
        this.dur,
        this.amt,
        this.eR,
        this.spotType,
        this.startTime,
        this.endTime,
        this.nEWDATE});

  Lstreimport.fromJson(Map<String, dynamic> json) {
    tONumber = json['TO Number'];
    bDC = json['BDC'];
    dealNo = json['Deal No'];
    dealRowNo = json['Deal Row no'];
    progName = json['Prog Name'];
    schDate = json['Sch Date'];
    nEWTIME = json['NEW TIME'];
    progEndTime = json['Prog End Time'];
    clientName = json['Client_Name'];
    agencyName = json['Agency name'];
    rONO = json['RO NO'];
    brand = json['Brand'];
    tapeId = json['Tape Id'];
    caption = json['Caption'];
    dur = json['Dur'];
    amt = json['Amt'];
    eR = json['ER'];
    spotType = json['Spot_Type'];
    startTime = json['Start Time'];
    endTime = json['End Time'];
    nEWDATE = json['NEW DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TO Number'] = this.tONumber;
    data['BDC'] = this.bDC;
    data['Deal No'] = this.dealNo;
    data['Deal Row no'] = this.dealRowNo;
    data['Prog Name'] = this.progName;
    data['Sch Date'] = this.schDate;
    data['NEW TIME'] = this.nEWTIME;
    data['Prog End Time'] = this.progEndTime;
    data['Client_Name'] = this.clientName;
    data['Agency name'] = this.agencyName;
    data['RO NO'] = this.rONO;
    data['Brand'] = this.brand;
    data['Tape Id'] = this.tapeId;
    data['Caption'] = this.caption;
    data['Dur'] = this.dur;
    data['Amt'] = this.amt;
    data['ER'] = this.eR;
    data['Spot_Type'] = this.spotType;
    data['Start Time'] = this.startTime;
    data['End Time'] = this.endTime;
    data['NEW DATE'] = this.nEWDATE;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toNumber'] = this.tONumber;
    data['bdc'] = int.parse(( this.bDC != null &&  this.bDC != "")? this.bDC.toString():"0");
    data['dealNo'] = this.dealNo;
    data['dealRowNo'] = int.parse(( this.dealRowNo != null &&  this.dealRowNo != "")? this.dealRowNo.toString():"0");
    data['newDate'] =convertDate(this.nEWDATE??"");
    data['newTime'] = this.nEWTIME;
    return data;
  }
}

String convertDate(String date){
  if(date != null && date != ""){
    return DateFormat("dd/MM/yyyy").format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date));
  }else{
    return "";
  }

}