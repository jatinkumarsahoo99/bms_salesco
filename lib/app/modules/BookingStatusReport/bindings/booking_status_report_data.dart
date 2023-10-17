class BookingStatusReportData {
  String? locationname;
  String? channelname;
  String? zonename;
  String? stationName;
  String? accountname;
  String? brandname;
  String? productname;
  String? industries;
  String? level2Name;
  String? level3Name;
  String? clientname;
  String? agencyname;
  String? monthname;
  String? currency;
  int? paid;
  int? bonus;
  int? crdur;
  int? totaldur;
  int? bookedamount;
  int? totalamount;
  int? inrAmount;
  String? a2Desc;
  String? agencyGstNumber;
  String? plantname;
  String? panNumber;

  BookingStatusReportData(
      {this.locationname,
      this.channelname,
      this.zonename,
      this.stationName,
      this.accountname,
      this.brandname,
      this.productname,
      this.industries,
      this.level2Name,
      this.level3Name,
      this.clientname,
      this.agencyname,
      this.monthname,
      this.currency,
      this.paid,
      this.bonus,
      this.crdur,
      this.totaldur,
      this.bookedamount,
      this.totalamount,
      this.inrAmount,
      this.a2Desc,
      this.agencyGstNumber,
      this.plantname,
      this.panNumber});

  BookingStatusReportData.fromJson(Map<String, dynamic> json) {
    locationname = json["locationname"];
    channelname = json["channelname"];
    zonename = json["zonename"];
    stationName = json["stationName"];
    accountname = json["accountname"];
    brandname = json["brandname"];
    productname = json["productname"];
    industries = json["industries"];
    level2Name = json["level2Name"];
    level3Name = json["level3Name"];
    clientname = json["clientname"];
    agencyname = json["agencyname"];
    monthname = json["monthname"];
    currency = json["currency"];
    paid = json["paid"];
    bonus = json["bonus"];
    crdur = json["crdur"];
    totaldur = json["totaldur"];
    bookedamount = json["bookedamount"];
    totalamount = json["totalamount"];
    inrAmount = json["inrAmount"];
    a2Desc = json["a2desc"];
    agencyGstNumber = json["agencyGSTNumber"];
    plantname = json["plantname"];
    panNumber = json["panNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationname"] = locationname;
    _data["channelname"] = channelname;
    _data["zonename"] = zonename;
    _data["stationName"] = stationName;
    _data["accountname"] = accountname;
    _data["brandname"] = brandname;
    _data["productname"] = productname;
    _data["industries"] = industries;
    _data["level2Name"] = level2Name;
    _data["level3Name"] = level3Name;
    _data["clientname"] = clientname;
    _data["agencyname"] = agencyname;
    _data["monthname"] = monthname;
    _data["currency"] = currency;
    _data["paid"] = paid;
    _data["bonus"] = bonus;
    _data["crdur"] = crdur;
    _data["totaldur"] = totaldur;
    _data["bookedamount"] = bookedamount;
    _data["totalamount"] = totalamount;
    _data["inrAmount"] = inrAmount;
    _data["a2desc"] = a2Desc;
    _data["agencyGSTNumber"] = agencyGstNumber;
    _data["plantname"] = plantname;
    _data["panNumber"] = panNumber;
    return _data;
  }
}
