import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoReceivedController extends GetxController {
  var locations = RxList<DropDownValue>([]);
  var channels = RxList<DropDownValue>([]);

  var revenueType = RxList<DropDownValue>([]);
  var clients = RxList<DropDownValue>([]);
  var agencies = RxList<DropDownValue>([]);
  var brands = RxList<DropDownValue>([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedRevenue;
  DropDownValue? selectedBrand;
  String? groupCode;
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
              clients.add(DropDownValue(
                  key: client["clientCode"], value: client["clientName"]));
            }
            locations.value = [];
            for (var location in data["lstLocation"]) {
              locations.add(DropDownValue(
                  key: location["locationCode"],
                  value: location["locationName"]));
            }
            revenueType.value = [];
            for (var revenue in data["lstRevenueType"]) {
              revenueType.add(DropDownValue(
                  key: revenue["accountCode"], value: revenue["accountName"]));
            }
          }
        });
  }

  getChannel(locationCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api:
            ApiFactory.RO_RECEIVED_LOAD_GET_CHANNEL(locationCode: locationCode),
        fun: (rawdata) {
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
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RECEIVED_LEAVE_CLIENT(
            locationCode: selectedLocation?.key ?? "",
            channelCode: selectedChannel?.key ?? "",
            clientCode: selectedClient?.key ?? ""),
        fun: (rawdata) {
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

  save() {
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.RO_RECEIVED_SAVE,
        json: {
          "intID": "0",
          "locationCode": selectedLocation?.key,
          "revenueType": selectedRevenue?.key,
          "channleCode": selectedChannel?.key,
          "clientCode": selectedClient?.key,
          "agencyCode": selectedAgency?.key,
          "brandCode": selectedBrand?.key,
          "roNumber": roNumber.text,
          "roDate": roRecDate.text,
          "activityMonth": activityMonth.text,
          "roAmount": roAmount.text,
          "valROAmount": roValAmount.text,
          "fct": fct.text,
          "additional": true,
          "loggedUser": Get.find<MainController>().user?.logincode,
          "remarks": remark.text
        },
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
