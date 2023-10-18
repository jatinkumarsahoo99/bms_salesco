import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../bindings/booking_status_report_data.dart';

class BookingStatusReportController extends GetxController {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  List<String> bookingTypes = [
    "Detail",
    "Summery",
  ];
  List<PermissionModel>? formPermissions;
  var locations = RxList<MultiCheckBoxModel>();
  var channels = RxList<MultiCheckBoxModel>();
  var zone = RxList<MultiCheckBoxModel>();
  var clients = RxList<MultiCheckBoxModel>();
  var agency = RxList<MultiCheckBoxModel>();
  var revenue = RxList<MultiCheckBoxModel>();

  List<DropDownValue> selectLocation = [];
  List<DropDownValue> selectChannel = [];
  List<DropDownValue> selectZone = [];
  List<DropDownValue> selectClient = [];
  List<DropDownValue> selectAgency = [];
  List<DropDownValue> selectRevenue = [];

  RxnString bookingType = RxnString();

  var dataTableList = [].obs;
  List<BookingStatusReportData>? bookigData;

  var isRType = "".obs;

  Future<void> getRadioStatus(String name) async {
    switch (name) {
      case "Detail":
        isRType.value = "D";
        break;
      case "Summery":
        isRType.value = "S";
        break;
    }
  }

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(
        Routes.BOOKING_STATUS_REPORT.replaceAll("/", ""));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getLoadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var listCheckBox = [
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee-Bihar-HD"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee TV"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zing"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Marathi"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Bojpuri"), false),
  ];

  getLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.BOOKING_STATUS_REPORT_GET_LOAD_DATA,
        fun: (Map map) {
          Get.back();
          locations.clear();
          channels.clear();
          zone.clear();
          clients.clear();
          agency.clear();
          revenue.clear();
          map["loadData"]["location"].forEach((e) {
            locations
                .add(MultiCheckBoxModel(DropDownValue.fromJson1(e), false));
          });
          map["loadData"]["channel"].forEach((e) {
            channels.add(MultiCheckBoxModel(
                DropDownValue(key: e["channelcode"], value: e["channelname"]),
                false));
          });
          map["loadData"]["zoneMaster"].forEach((e) {
            zone.add(MultiCheckBoxModel(
                DropDownValue(key: e["zonecode"], value: e["zonename"]),
                false));
          });
          map["loadData"]["clientMaster"].forEach((e) {
            clients.add(MultiCheckBoxModel(
                DropDownValue(key: e["clientcode"], value: e["clientname"]),
                false));
          });
          map["loadData"]["agencymaster"].forEach((e) {
            agency.add(MultiCheckBoxModel(
                DropDownValue(key: e["agencycode"], value: e["agencyname"]),
                false));
          });
          map["loadData"]["salesbook"].forEach((e) {
            revenue.add(MultiCheckBoxModel(
                DropDownValue(key: e["accountcode"], value: e["accountname"]),
                false));
          });
        });
  }

  genrate() {
    selectLocation.clear();
    selectChannel.clear();
    selectZone.clear();
    selectClient.clear();
    selectAgency.clear();
    selectRevenue.clear();
    for (var element in locations) {
      if (element.isSelected ?? false) {
        selectLocation.add(element.val!);
      }
    }
    for (var element in channels) {
      if (element.isSelected ?? false) {
        selectChannel.add(element.val!);
      }
    }
    for (var element in clients) {
      if (element.isSelected ?? false) {
        selectClient.add(element.val!);
      }
    }
    for (var element in zone) {
      if (element.isSelected ?? false) {
        selectZone.add(element.val!);
      }
    }
    for (var element in agency) {
      if (element.isSelected ?? false) {
        selectAgency.add(element.val!);
      }
    }
    for (var element in revenue) {
      if (element.isSelected ?? false) {
        selectRevenue.add(element.val!);
      }
    }
    getReport();
  }

  getReport() {
    LoadingDialog.call();
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    var payload = {
      "location": selectLocation
          .map(
            (e) => {
              "locationCode": e.key,
              "locationName": e.value,
            },
          )
          .toList(),
      "channel": selectChannel
          .map((e) => {
                "channelcode": e.key,
                "channelname": e.value,
              })
          .toList(),
      "zoneMaster": selectZone
          .map((e) => {
                "zonecode": e.key,
                "zonename": e.value,
              })
          .toList(),
      "clientMaster": selectClient
          .map((e) => {
                "clientcode": e.key,
                "clientname": e.value,
              })
          .toList(),
      "agencymaster": selectAgency
          .map((e) => {"agencycode": e.key, "agencyname": e.value})
          .toList(),
      "salesbook": selectRevenue
          .map((e) => {"accountcode": e.key, "accountname": e.value})
          .toList(),
      "fromDate": DateFormat("yyyy-MM-dd").format(startDate),
      "toDate": DateFormat("yyyy-MM-dd").format(endDate),
      "rType": isRType.toString(),
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.BOOKING_STATUS_REPORT_GET_REPORT,
        json: payload,
        fun: (map) {
          Get.back();
          print(map);
          if (map != null &&
              map['loadData'] != null &&
              map.containsKey('loadData') &&
              (map['loadData'] as List<dynamic>).isNotEmpty) {
            dataTableList.clear();
            dataTableList.value.addAll((map['loadData']));
          } else {
            LoadingDialog.showErrorDialog('No data found.');
          }
        });
  }

  clearPage() {
    // locations.clear();
    // channels.clear();
    // zone.clear();
    // clients.clear();
    // agency.clear();
    // revenue.clear();
    // selectLocation.clear();
    // selectChannel.clear();
    // selectZone.clear();
    // selectClient.clear();
    // selectAgency.clear();
    // selectRevenue.clear();
    // fromDate.clear();
    // toDate.clear();
    // dataTableList.clear();
    Get.delete<BookingStatusReportController>();
    Get.find<HomeController>().clearPage1();
  }
}
