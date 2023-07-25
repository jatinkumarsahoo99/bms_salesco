import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/RoReceived/bindings/ro_received_data.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoReceivedController extends GetxController {
  List<DropDownValue>? locations;
  var channels = RxList<DropDownValue>([]);

  var revenueType = RxList<DropDownValue>([]);
  var clients = RxList<DropDownValue>([]);
  var agencies = RxList<DropDownValue>([]);
  var brands = RxList<DropDownValue>([]);
  String? roreciveId;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedRevenue;
  DropDownValue? selectedBrand;
  String? groupCode;
  RoReceiveData? roReceiveData;
  RxBool additional = RxBool(true);
  TextEditingController roNumber = TextEditingController(),
      roRecDate = TextEditingController(),
      effDate = TextEditingController(),
      activityMonth = TextEditingController(),
      roAmount = TextEditingController(),
      roValAmount = TextEditingController(),
      fct = TextEditingController(),
      remark = TextEditingController();
  @override
  void onInit() {
    getInitData();
    super.onInit();
  }

  getInitData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LOAD,
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLoadRoRecevice")) {
            Map data = rawdata["onLoadRoRecevice"];
            clients.value = [];
            for (var client in data["lstClient"]) {
              clients.add(DropDownValue(key: client["clientCode"], value: client["clientName"]));
            }
            locations = [];
            for (var location in data["lstLocation"]) {
              locations?.add(DropDownValue(key: location["locationCode"], value: location["locationName"]));
            }
            revenueType.value = [];
            for (var revenue in data["lstRevenueType"]) {
              revenueType.add(DropDownValue(key: revenue["accountCode"], value: revenue["accountName"]));
            }
            update(["main"]);
          }
        });
  }

  getChannel(locationCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LOAD_GET_CHANNEL(locationCode: locationCode),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveLocation")) {
            channels.value = [];
            for (var channel in rawdata["onLeaveLocation"]) {
              channels.add(DropDownValue(key: channel["channelCode"], value: channel["channelName"]));
            }
          }
        });
  }

  clientLeave() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LEAVE_CLIENT(
            locationCode: selectedLocation?.key ?? "", channelCode: selectedChannel?.key ?? "", clientCode: selectedClient?.key ?? ""),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveClient")) {
            Map data = rawdata["onLeaveClient"];
            agencies.value = [];
            for (var agency in data["lstAgencies"]) {
              agencies.add(DropDownValue(key: agency["agencyCode"], value: agency["agencyName"]));
            }
            brands.value = [];
            for (var brand in data["lstBrand"]) {
              brands.add(DropDownValue(key: brand["brandCode"], value: brand["brandName"]));
            }
            groupCode = data["groupCode"];
          }
        });
  }

  dateLeave(String date) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_DATE_LEAVE(date: DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(date))),
        fun: (rawdata) {
          // if (rawdata is Map && rawdata.containsKey("onLeaveClient")) {
          //   Map data = rawdata["onLeaveClient"];
          //   agencies.value = [];
          //   for (var agency in data["lstAgencies"]) {
          //     agencies.add(DropDownValue(
          //         key: agency["agencyCode"], value: agency["agencyName"]));
          //   }
          //   brands.value = [];
          //   for (var brand in data["lstBrand"]) {
          //     brands.add(DropDownValue(
          //         key: brand["brandCode"], value: brand["brandName"]));
          //   }
          //   groupCode = data["groupCode"];
          // }
        });
  }

  deleteRoReceive() {
    Get.find<ConnectorControl>().DELETEMETHOD(
        api: ApiFactory.RO_RECEIVED_DELETE(id: roreciveId ?? "202344", remark: remark.text.isEmpty ? "remark" : remark.text),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onDeleteRecord")) {
            LoadingDialog.callDataSaved(msg: rawdata["onDeleteRecord"]["message"]);
          } else if (rawdata is String) {
            LoadingDialog.callErrorMessage1(msg: rawdata);
          }
        });
  }

  retriveData(recievedCode) {
    roreciveId = recievedCode;
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_RETRIVE(receivedCode: recievedCode),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("retriveRecords")) {
            Map data = rawdata["retriveRecords"];
            if (data["lstRoReceived"] != null && data["lstRoReceived"] is List && (data["lstRoReceived"] as List).isNotEmpty) {
              roReceiveData = RoReceiveData.fromJson((data["lstRoReceived"] as List).first);
              selectedLocation = locations?.firstWhereOrNull((dropdown) => dropdown.key == roReceiveData?.locationCode);

              if (data is Map && data.containsKey("lstClientonLeave")) {
                Map cleintdata = data["lstClientonLeave"];
                agencies.value = [];
                for (var agency in cleintdata["lstAgencies"]) {
                  agencies.add(DropDownValue(key: agency["agencyCode"], value: agency["agencyName"]));
                }
                brands.value = [];
                for (var brand in cleintdata["lstBrand"]) {
                  brands.add(DropDownValue(key: brand["brandCode"], value: brand["brandName"]));
                }
                groupCode = cleintdata["groupCode"];
              }
              if (rawdata is Map && data.containsKey("lstChannel")) {
                channels.value = [];
                for (var channel in data["lstChannel"]) {
                  channels.add(DropDownValue(key: channel["channelCode"], value: channel["channelName"]));
                }
              }

              clients.value = [];
              for (var client in data["lstClient"]) {
                clients.add(DropDownValue(key: client["clientCode"], value: client["clientName"]));
              }

              selectedChannel = channels.value.firstWhereOrNull((dropdown) => dropdown.key == roReceiveData?.channelCode);
              selectedAgency = agencies.value.firstWhereOrNull((dropdown) => dropdown.key == roReceiveData?.agencyCode);
              selectedBrand = brands.value.firstWhereOrNull((dropdown) => dropdown.key == roReceiveData?.brandCode);

              selectedRevenue = revenueType.value.firstWhereOrNull((dropdown) => dropdown.key == roReceiveData?.revenueType);

              roNumber.text = roreciveId ?? "";

              activityMonth.text = (roReceiveData?.activityMonth ?? "").toString();
              additional.value = roReceiveData?.adDCAN ?? false;
              fct.text = (roReceiveData?.fct ?? "").toString();
              remark.text = roReceiveData?.remarks ?? "";
              roAmount.text = (roReceiveData?.roAmount ?? "").toString();
              roValAmount.text = (roReceiveData?.valROAmount ?? "").toString();
              roRecDate.text = DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd").parse(roReceiveData?.roDate?.split("T")[0] ?? ""));
              update(["main"]);
              Get.back();
              Get.back();
            }
          }
        });
  }

  save() {
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.RO_RECEIVED_SAVE,
        json: {
          "intID": 0,
          "locationCode": selectedLocation?.key,
          "revenueType": selectedRevenue?.key,
          "channleCode": selectedChannel?.key,
          "clientCode": selectedClient?.key,
          "agencyCode": selectedAgency?.key,
          "brandCode": selectedBrand?.key,
          "roNumber": roNumber.text,
          "roDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(roRecDate.text)),
          "activityMonth": int.tryParse(activityMonth.text),
          "roAmount": num.tryParse(roAmount.text),
          "valROAmount": num.tryParse(roValAmount.text),
          "fct": int.tryParse(fct.text),
          "additional": additional.value,
          "loggedUser": Get.find<MainController>().user?.logincode,
          "remarks": remark.text
        },
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onSaveRecord")) {
            LoadingDialog.callDataSaved(msg: rawdata["onSaveRecord"]["message"]);
          } else if (rawdata is String) {
            LoadingDialog.callErrorMessage1(msg: rawdata);
          }
        });
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
