import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/RoReceived/bindings/ro_received_data.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/HomeController.dart';

class RoReceivedController extends GetxController {
  var locations = <DropDownValue>[].obs;
  var channels = RxList<DropDownValue>([]);

  var revenueType = RxList<DropDownValue>([]);
  var clients = RxList<DropDownValue>([]);
  var agencies = RxList<DropDownValue>([]);
  var brands = RxList<DropDownValue>([]);
  String? roreciveId;

  // var effStartDateFN = FocusNode();

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
      effEndDate = TextEditingController(),
      activityMonth = TextEditingController(),
      roAmount = TextEditingController(text: "0.00"),
      roValAmount = TextEditingController(text: "0.00"),
      fct = TextEditingController(),
      remark = TextEditingController();

  List<String> dataTypes = [
    "Additional",
    "Cancellation",
  ];
  var currentType = "".obs;
  Future<void> getRadioStatus(String name) async {
    switch (name) {
      case "Additional":
        additional.value = true;
        currentType.value = "Additional";
        break;
      case "Cancellation":
        additional.value = false;
        currentType.value = "Cancellation";
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  getInitData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LOAD,
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onLoadRoRecevice")) {
            Map data = rawdata["onLoadRoRecevice"];
            // clients.value = [];
            // for (var client in data["lstClient"]) {
            //   clients.add(DropDownValue(key: client["clientCode"], value: client["clientName"]));
            // }
            locations.value = [];
            for (var location in data["lstLocation"]) {
              locations?.add(DropDownValue(
                  key: location["locationCode"],
                  value: location["locationName"]));
            }
            revenueType.value = [];
            for (var revenue in data["lstRevenueType"]) {
              revenueType.add(DropDownValue(
                  key: revenue["accountCode"], value: revenue["accountName"]));
            }
            activityMonth.text = data["activityMonth"];
            effEndDate.text = DateFormat("dd-MM-yyyy").format(
                DateFormat("yyyy-MM-ddThh:mm:ss")
                    .parse(data['dtpEndDate'] ?? "2023/01/09T00:00:00"));

            update(["main"]);
          }
        });
  }

  getChannel(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api:
            ApiFactory.RO_RECEIVED_LOAD_GET_CHANNEL(locationCode: locationCode),
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onLeaveLocation")) {
            channels.value = [];
            for (var channel in rawdata["onLeaveLocation"]) {
              channels.add(DropDownValue(
                  key: channel["channelCode"], value: channel["channelName"]));
            }
          }
        });
  }

  clientLeave() {
    LoadingDialog.call();

    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LEAVE_CLIENT(
            locationCode: selectedLocation?.key ?? "",
            channelCode: selectedChannel?.key ?? "",
            clientCode: selectedClient?.key ?? ""),
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onLeaveClient")) {
            Map data = rawdata["onLeaveClient"];
            agencies.value = [];
            for (var agency in data["lstAgencies"]) {
              agencies.add(DropDownValue(
                  key: agency["agencyCode"], value: agency["agencyName"]));
            }
            brands.value = [];
            for (var brand in data["lstBrand"]) {
              brands.add(DropDownValue(
                  key: brand["brandCode"], value: brand["brandName"]));
            }
            groupCode = data["groupCode"];
          }
        });
  }

  dateLeave(String date) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_DATE_LEAVE(
            date: DateFormat("yyyy-MM-dd")
                .format(DateFormat("dd-MM-yyyy").parse(date))),
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
    LoadingDialog.call();
    Get.find<ConnectorControl>().DELETEMETHOD(
        api: ApiFactory.RO_RECEIVED_DELETE(
            id: roreciveId ?? "202344",
            remark: remark.text.isEmpty ? "remark" : remark.text),
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onDeleteRecord")) {
            effEndDate.text = DateFormat("dd-MM-yyyy").format(
                DateFormat("yyyy-MM-ddThh:mm:ss").parse(
                    rawdata['onDeleteRecord']['dtpEndDate'] ??
                        "2023/01/09T00:00:00"));
            LoadingDialog.callDataSaved(
                msg: rawdata["onDeleteRecord"]["message"]);
          } else if (rawdata is String) {
            LoadingDialog.callErrorMessage1(msg: rawdata);
          }
        });
  }

  retriveData(recievedCode) {
    LoadingDialog.call();
    roreciveId = recievedCode;
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_RETRIVE(receivedCode: recievedCode),
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("retriveRecords")) {
            Map data = rawdata["retriveRecords"];
            if (data["lstRoReceived"] != null &&
                data["lstRoReceived"] is List &&
                (data["lstRoReceived"] as List).isNotEmpty) {
              roReceiveData =
                  RoReceiveData.fromJson((data["lstRoReceived"] as List).first);
              selectedLocation = locations?.firstWhereOrNull(
                  (dropdown) => dropdown.key == roReceiveData?.locationCode);

              if (data is Map && data.containsKey("lstClientonLeave")) {
                Map cleintdata = data["lstClientonLeave"];
                agencies.value = [];
                for (var agency in cleintdata["lstAgencies"]) {
                  agencies.add(DropDownValue(
                      key: agency["agencyCode"], value: agency["agencyName"]));
                }
                brands.value = [];
                for (var brand in cleintdata["lstBrand"]) {
                  brands.add(DropDownValue(
                      key: brand["brandCode"], value: brand["brandName"]));
                }
                groupCode = cleintdata["groupCode"];
              }
              if (rawdata is Map && data.containsKey("lstChannel")) {
                channels.value = [];
                for (var channel in data["lstChannel"]) {
                  channels.add(DropDownValue(
                      key: channel["channelCode"],
                      value: channel["channelName"]));
                }
              }

              clients.value = [];
              for (var client in data["lstClient"]) {
                clients.add(DropDownValue(
                    key: client["clientCode"], value: client["clientName"]));
              }

              selectedChannel = channels.value.firstWhereOrNull(
                  (dropdown) => dropdown.key == roReceiveData?.channelCode);
              selectedAgency = agencies.value.firstWhereOrNull(
                  (dropdown) => dropdown.key == roReceiveData?.agencyCode);
              selectedBrand = brands.value.firstWhereOrNull(
                  (dropdown) => dropdown.key == roReceiveData?.brandCode);

              selectedRevenue = revenueType.value.firstWhereOrNull(
                  (dropdown) => dropdown.key == roReceiveData?.revenueType);

              roNumber.text = roreciveId ?? "";

              activityMonth.text =
                  (roReceiveData?.activityMonth ?? "").toString();
              additional.value = roReceiveData?.adDCAN ?? false;
              fct.text = (roReceiveData?.fct ?? "").toString();
              remark.text = roReceiveData?.remarks ?? "";
              roAmount.text = (roReceiveData?.roAmount ?? "").toString();
              roValAmount.text = (roReceiveData?.valROAmount ?? "").toString();
              roRecDate.text = DateFormat("dd-MM-yyyy").format(
                  DateFormat("yyyy-MM-dd")
                      .parse(roReceiveData?.roDate?.split("T")[0] ?? ""));
              update(["main"]);
              Get.back();
              Get.back();
            }
          }
        });
  }

  validation() {
    if (selectedLocation?.key == null) {
      LoadingDialog.showErrorDialog("Please select location.");
    } else if (selectedChannel?.key == null) {
      LoadingDialog.showErrorDialog("Please select channel.");
    } else if (selectedClient?.key == null) {
      LoadingDialog.showErrorDialog("Please select client.");
    } else if (selectedAgency?.key == null) {
      LoadingDialog.showErrorDialog("Please select agency.");
    } else if (selectedBrand?.key == null) {
      LoadingDialog.showErrorDialog("Please select brand.");
    } else if (roNumber.text.isEmpty) {
      LoadingDialog.showErrorDialog("Please enter RO Number.");
    } else if (fct.text.isEmpty) {
      LoadingDialog.showErrorDialog("Please enter FCT.");
    } else if (currentType.value == "") {
      LoadingDialog.showErrorDialog("Please select additional / cancellation.");
    } else if (selectedRevenue?.key == null) {
      LoadingDialog.showErrorDialog("Please select revenue type.");
    } else if (fct.text.length > 9) {
      LoadingDialog.showErrorDialog(
          "Error converting data type nvarchar to int.");
    } else {
      save();
    }
  }

  save() {
    LoadingDialog.call();
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
          "roDate": DateFormat("yyyy-MM-dd")
              .format(DateFormat("dd-MM-yyyy").parse(roRecDate.text)),
          "activityMonth": int.tryParse(activityMonth.text),
          "roAmount": num.tryParse(roAmount.text),
          "valROAmount": num.tryParse(roValAmount.text),
          "fct": int.tryParse(fct.text),
          "additional": additional.value,
          "loggedUser": Get.find<MainController>().user?.logincode,
          "remarks": remark.text,
          "startDate": DateFormat("yyyy-MM-dd")
              .format(DateFormat("dd-MM-yyyy").parse(effDate.text)),
          "endDate": DateFormat("yyyy-MM-dd")
              .format(DateFormat("dd-MM-yyyy").parse(effEndDate.text)),
        },
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onSaveRecord")) {
            LoadingDialog.callDataSaved(
                msg: rawdata["onSaveRecord"]["message"],
                callback: () {
                  clear();
                });
          } else if (rawdata is String) {
            LoadingDialog.callErrorMessage1(msg: rawdata);
          }
        });
  }

  startDateLeave() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LOAD,
        fun: (rawdata) {
          Get.back();
          if (rawdata is Map && rawdata.containsKey("onLoadRoRecevice")) {}
        });
  }

  clear() {
    Get.delete<RoReceivedController>();
    Get.find<HomeController>().clearPage1();
    // selectedLocation?.value = null;
    // selectedChannel?.value = null;
    // selectedClient?.value = null;
    // selectedAgency?.value = null;
    // selectedBrand?.value = null;
    // roNumber.clear();
    // roRecDate.clear();
    // effDate.clear();
    // roAmount.text = "0.00";
    // roValAmount.text = "0.00";
    // fct.clear();
    // remark.clear();
    // selectedRevenue?.value = null;
  }

  //  addListeneres() {
  //   effStartDateFN.onKey = (node, event) {
  //     if (event.logicalKey == LogicalKeyboardKey.tab && !event.isShiftPressed) {

  //     }
  //     return KeyEventResult.ignored;
  //   };
  // }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 1)).then((value) {
      getInitData();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
