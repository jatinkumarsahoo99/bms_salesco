class AuditStatusCancel {
  List<Cancel>? cancel;

  AuditStatusCancel({this.cancel});

  AuditStatusCancel.fromJson(Map<String, dynamic> json) {
    if (json['cancel'] != null) {
      cancel = <Cancel>[];
      json['cancel'].forEach((v) {
        cancel!.add(new Cancel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cancel != null) {
      data['cancel'] = this.cancel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cancel {
  String? channelName;
  int? month;
  int? number;
  String? zoneName;
  String? clientname;
  String? brandName;
  String? agencyname;
  int? amount;
  String? payroutename;
  String? bookingNumber;
  String? salesBook;
  String? panCardNo;
  String? agencyGSTNumber;
  String? plantName;
  String? by;
  String? on;
  String? time;
  int? totalspots;
  int? auditedSpots;
  String? numbers;
  String? auditedBy;
  String? reportType;

  Cancel(
      {this.channelName,
        this.month,
        this.number,
        this.zoneName,
        this.clientname,
        this.brandName,
        this.agencyname,
        this.amount,
        this.payroutename,
        this.bookingNumber,
        this.salesBook,
        this.panCardNo,
        this.agencyGSTNumber,
        this.plantName,
        this.by,
        this.on,
        this.time,
        this.totalspots,
        this.auditedSpots,
        this.numbers,
        this.auditedBy,
        this.reportType});

  Cancel.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    month = json['month'];
    number = json['number'];
    zoneName = json['zoneName'];
    clientname = json['clientname'];
    brandName = json['brandName'];
    agencyname = json['agencyname'];
    amount = json['amount'];
    payroutename = json['payroutename'];
    bookingNumber = json['bookingNumber'];
    salesBook = json['salesBook'];
    panCardNo = json['panCardNo'];
    agencyGSTNumber = json['agencyGSTNumber'];
    plantName = json['plantName'];
    by = json['by'];
    on = json['on'];
    time = json['time'];
    totalspots = json['totalspots'];
    auditedSpots = json['auditedSpots'];
    numbers = json['numbers'];
    auditedBy = json['auditedBy'];
    reportType = json['reportType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelName'] = this.channelName;
    data['month'] = this.month;
    data['number'] = this.number;
    data['zoneName'] = this.zoneName;
    data['clientname'] = this.clientname;
    data['brandName'] = this.brandName;
    data['agencyname'] = this.agencyname;
    data['amount'] = this.amount;
    data['payroutename'] = this.payroutename;
    data['bookingNumber'] = this.bookingNumber;
    data['salesBook'] = this.salesBook;
    data['panCardNo'] = this.panCardNo;
    data['agencyGSTNumber'] = this.agencyGSTNumber;
    data['plantName'] = this.plantName;
    data['by'] = this.by;
    data['on'] = this.on;
    data['time'] = this.time;
    data['totalspots'] = this.totalspots;
    data['auditedSpots'] = this.auditedSpots;
    data['numbers'] = this.numbers;
    data['auditedBy'] = this.auditedBy;
    data['reportType'] = this.reportType;
    return data;
  }
}
