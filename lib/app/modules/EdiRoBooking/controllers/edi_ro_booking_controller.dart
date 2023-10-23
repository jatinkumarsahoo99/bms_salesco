import 'dart:convert';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/FormButton.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class EdiRoBookingController extends GetxController {
  //TODO: Implement EdiRoBookingController
  var bookingNo1TEC = TextEditingController(),
      bookingNo2TEC = TextEditingController(text: "0"),
      bookingNo3TEC = TextEditingController(),
      spotsAllTEC = TextEditingController(text: "0"),
      spotsBookedTEC = TextEditingController(text: "0"),
      spotsBalanceTEC = TextEditingController(text: "0"),
      durAllTEC = TextEditingController(text: "0"),
      durBookedTEC = TextEditingController(text: "0"),
      durBalanceTEC = TextEditingController(text: "0"),
      amtAllTEC = TextEditingController(text: "0"),
      amtBookedTEC = TextEditingController(text: "0"),
      amtBalanceTEC = TextEditingController(text: "0"),
      amtValAmmountTEC = TextEditingController(text: "0"),
      preVAmtTEC = TextEditingController(text: "0"),
      preBAmtTEC = TextEditingController(text: "0"),
      maxSpendTEC = TextEditingController(text: "0"),
      bookedAmountTEC = TextEditingController(text: "0"),
      valAmountTEC = TextEditingController(text: "0"),
      zoneTEC = TextEditingController(),
      payRouteTEC = TextEditingController(),
      payRouteCodeTEC = TextEditingController();

  final count = 0.obs;
  var infoTableList = [].obs;
  var drgabbleDialog = Rxn<Widget>();
  var programList = [].obs;
  var zoneCode = "".obs;

  EdiRoInitData? initData;
  var fileNames = RxList<DropDownValue>();
  var loactions = RxList<DropDownValue>();
  var positions = RxList<DropDownValue>();
  var executives = RxList<DropDownValue>();
  var strRoRefNo = RxList<DropDownValue>();
  var client = RxList<DropDownValue>();
  var agency = RxList<DropDownValue>();
  var brand = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();

  // Selected DropDownValues
  DropDownValue? selectedFile;
  DropDownValue? selectedLoactions;
  DropDownValue? selectedPositions;
  DropDownValue? selectedExecutives;
  DropDownValue? selectedRoRefNo;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedBrand;
  DropDownValue? selectedChannel;

  TextEditingController effectiveDate = TextEditingController();

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  RxBool isEnable = RxBool(true);

  @override
  void onInit() {
    getInitData();
    fetchUserSetting1();
    super.onInit();
  }

  getInitData() {
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_INIT,
          fun: (map) {
            // initData = EdiRoInitData.fromJson(map["onLoadInfo"]);
            //FileName
            fileNames.clear();
            map["onLoadInfo"]['softListMyFiles'].forEach((e) {
              fileNames
                  .add(DropDownValue(key: '', value: e['convertedFileName']));
            });
            //Loaction
            loactions.clear();
            map["onLoadInfo"]['lstLocation'].forEach((e) {
              loactions.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            // Position
            positions.clear();
            map["onLoadInfo"]['lstSpotPosType'].forEach((e) {
              positions.add(DropDownValue(
                  key: e['spotPositionTypeCode'],
                  value: e['spotPositionTypeName']));
            });
            selectedPositions = positions.firstWhereOrNull(
              (element) {
                var result = element.key == "ZAMID00002";
                return result;
              },
            );
            // Executives
            executives.clear();
            map["onLoadInfo"]['executives'].forEach((e) {
              executives.add(DropDownValue(
                  key: e['personnelCode'], value: e['personnelName']));
            });
            update(["initData"]);
          });
    } catch (e) {
      print(e.toString());
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  effectiveDateLeave() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_FILE_LEAVE(
              selectedFile?.value,
              DateFormat("yyyy-MM-dd")
                  .format(DateFormat("dd-MM-yyyy").parse(effectiveDate.text))),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFileNameLeave'] != null &&
                map.containsKey('infoFileNameLeave')) {
              isEnable.value = false;
              //RO Ref No.
              strRoRefNo.clear();
              map["infoFileNameLeave"]['strRoRefNo'].forEach((e) {
                strRoRefNo.add(DropDownValue(key: '', value: e));
                selectedRoRefNo = DropDownValue(key: '', value: e);
              });
              //Location
              selectedLoactions = loactions.firstWhereOrNull((element) {
                var result = element.key ==
                    map['infoFileNameLeave']['headerData']['locationCode'];
                return result;
              });
              //Client
              client.clear();
              map["infoFileNameLeave"]['headerData']['lstClients'].forEach((e) {
                client.add(DropDownValue(
                    key: e['clientCode'], value: e['clientName']));
              });
              selectedClient = client.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['clientcode'];
                  return result;
                },
              );
              //Agency
              agency.clear();
              map["infoFileNameLeave"]['headerData']['lstAgencies']
                  .forEach((e) {
                agency.add(DropDownValue(
                    key: e['agencyCode'], value: e['agencyName']));
              });
              selectedAgency = agency.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['agencyCode'];
                  return result;
                },
              );
              //Brand
              brand.clear();
              map["infoFileNameLeave"]['headerData']['lstBrands'].forEach((e) {
                brand.add(
                    DropDownValue(key: e['brandcode'], value: e['brandname']));
              });
              //Executives
              executives.clear();
              map["infoFileNameLeave"]['headerData']['executivesSelectedValue']
                  .forEach((e) {
                executives.add(DropDownValue(
                    key: e['personnelCode'], value: e['personnelName']));
              });
              selectedExecutives = DropDownValue(
                  key: executives[0].key, value: executives[0].value);
              // Show Programs
              programList.clear();
              map["infoFileNameLeave"]['lstLoadXml']['lstShowPrograms']
                  .forEach((e) {
                programList.add(e);
              });
              // Channel
              channel.clear();
              map["infoFileNameLeave"]['headerData']['lstChannel'].forEach((e) {
                channel.add(DropDownValue(
                    key: e['channelCode'], value: e['channelName']));
              });
              selectedChannel = channel.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['channelCode'];
                  return result;
                },
              );
              leaveFileNameClagdetails();
              update(["initData"]);
            } else {
              LoadingDialog.showErrorDialog('No data found.');
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  leaveFileNameClagdetails() {
    try {
      LoadingDialog.call();
      var effFromDate = DateFormat("dd-MM-yyyy").parse(effectiveDate.text);
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_FILE_NAME_CLAGDETAILS(
            selectedLoactions?.value ?? "",
            selectedChannel?.value ?? "",
            selectedClient?.value ?? "",
            selectedAgency?.value ?? "",
            DateFormat("yyyy-MM-dd").format(effFromDate),
          ),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFileNameLeaveClagdetails'] != null &&
                map.containsKey('infoFileNameLeaveClagdetails') &&
                (map['infoFileNameLeaveClagdetails'] as List<dynamic>)
                    .isNotEmpty) {
              map["infoFileNameLeaveClagdetails"].forEach((e) {
                zoneTEC.text = e['zonename'];
                bookingNo3TEC.text = e["shortname"];
                payRouteTEC.text = e["payroutename"];
                payRouteCodeTEC.text = e["payRouteCode"];
                zoneCode.value = e["zonecode"];
              });

              update(["initData"]);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  locationLeave(locationCode) {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_LOCATION(locationCode ?? ""),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {
              channel.clear();
              map["infoChannelList"].forEach((e) {
                channel.add(DropDownValue(
                    key: e['channelCode'], value: e['channelName']));
              });
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  agencyLeave() {
    try {
      LoadingDialog.call();
      var effFromDate = DateFormat("dd-MM-yyyy").parse(effectiveDate.text);
      var payload = {
        "locationCode": selectedLoactions?.key,
        "locationName": selectedLoactions?.value,
        "channelCode": selectedChannel?.key,
        "channelName": selectedChannel?.value,
        "clientCode": selectedClient?.key,
        "clientName": selectedClient?.value,
        "agencyCode": selectedAgency?.key,
        "agencyName": selectedAgency?.value,
        "effectiveDate": DateFormat("yyyy-MM-dd").format(effFromDate),
        "effectiveFrom": DateFormat("yyyy-MM-dd").format(effFromDate)
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_AGENCY_LEAVE,
          json: payload,
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {}
          });
    } catch (e) {
      print(e.toString());
    }
  }

  onMarkAsDone() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_MARK_AS_DONE(selectedFile?.value),
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {}
          });
    } catch (e) {
      print(e.toString());
    }
  }

  showLink() {
    try {
      LoadingDialog.call();
      var payload = {
        "dealNo": "<string>",
        "locationCode": selectedLoactions?.key,
        "channelCode": selectedChannel?.key,
        "agencyCode": selectedAgency?.key,
        "roRefNo": selectedRoRefNo?.value,
        "lstDgvDealEntries": [
          {
            "recordnumber": "<integer>",
            "bandcode": "<string>",
            "impactNonImpact": "<string>",
            "sponsorTypeName": "<string>",
            "programCategoryName": "<string>",
            "programname": "<string>",
            "starttime": {
              "ticks": "<long>",
              "days": "<integer>",
              "hours": "<integer>",
              "milliseconds": "<integer>",
              "minutes": "<integer>",
              "seconds": "<integer>",
              "totalDays": "<double>",
              "totalHours": "<double>",
              "totalMilliseconds": "<double>",
              "totalMinutes": "<double>",
              "totalSeconds": "<double>"
            },
            "endTime": {
              "ticks": "<long>",
              "days": "<integer>",
              "hours": "<integer>",
              "milliseconds": "<integer>",
              "minutes": "<integer>",
              "seconds": "<integer>",
              "totalDays": "<double>",
              "totalHours": "<double>",
              "totalMilliseconds": "<double>",
              "totalMinutes": "<double>",
              "totalSeconds": "<double>"
            },
            "seconds": "<double>",
            "costPer10Sec": "<double>",
            "utilisedTime": "<double>",
            "balance": "<integer>",
            "amount": "<double>",
            "valuationrate": "<double>",
            "groupCode": "<integer>",
            "sun": "<integer>",
            "mon": "<integer>",
            "tue": "<integer>",
            "wed": "<integer>",
            "thu": "<integer>",
            "fri": "<integer>",
            "sat": "<integer>",
            "booked": "<double>",
            "fromdate": "<dateTime>",
            "todate": "<dateTime>",
            "locationname": "<string>",
            "channelname": "<string>",
            "maxspend": "<double>",
            "paymentmodecaption": "<string>",
            "ispdcenterd": "<integer>",
            "startdate": "<dateTime>",
            "enddate": "<dateTime>",
            "clientName": "<string>",
            "agencyName": "<string>",
            "dealnumber": "<string>",
            "valuationAmount": "<double>",
            "balanceAmount": "<double>",
            "dealValAmount": "<double>",
            "balanceValAmount": "<double>",
            "utilInRo": "<integer>",
            "totalUtil": "<integer>",
            "totalBookedAmt": "<integer>",
            "totalValAmt": "<integer>",
            "bookedAmt": "<double>",
            "locationcode": "<string>",
            "channelCode": "<string>",
            "baseduration": "<integer>",
            "countbased": "<integer>"
          }
        ],
        "lstXmlDt": [
          {
            "rO_NUM": "<string>",
            "rO_DATE": "<string>",
            "clienT_ID": "<string>",
            "clienT_NAME": "<string>",
            "statioN_ID": "<string>",
            "station": "<string>",
            "program": "<string>",
            "stime": "<string>",
            "etime": "<string>",
            "dur": "<string>",
            "title": "<string>",
            "acT_DT": "<string>",
            "spoT_RATE": "<string>",
            "schD_ID": "<string>",
            "tapE_ID": "<string>",
            "branD_ID": "<string>",
            "brand": "<string>"
          }
        ],
        "duration": "<string>",
        "spots": "<string>",
        "amount": "<string>"
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_SHOW_LINK,
          json: payload,
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {}
          });
    } catch (e) {
      print(e.toString());
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single != null) {
      print(result.files[0]);
      // importfile(result.files[0]);
    } else {
      // User canceled the pic5ker
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
