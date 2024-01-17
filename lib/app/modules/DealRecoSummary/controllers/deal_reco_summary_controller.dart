import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../DealRecoSummaryModel.dart';

class DealRecoSummaryController extends GetxController {
  //TODO: Implement DealRecoSummaryController
  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> dealNoList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  Rxn<DropDownValue>? selectedAgency = Rxn<DropDownValue>(null);
  DropDownValue? selectedDealNo;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController utilAsOnDateController = TextEditingController();

  FocusNode dealNoFocusNode = FocusNode();
  bool isFocusActive = false;

  FocusNode locationNode = FocusNode();
  FocusNode channelNode = FocusNode();
  FocusNode clientNode = FocusNode();
  FocusNode agencyNode = FocusNode();
  FocusNode zoneNode = FocusNode();
  FocusNode executiveNamNode = FocusNode();

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_RECO_SUMMARY_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('pageload') &&
              map['pageload'] != null) {
            locationList.clear();
            channelList.clear();
            if (map['pageload'].containsKey('locations') &&
                map['pageload']['locations'] != null &&
                map['pageload']['locations'].length > 0) {
              map['pageload']['locations'].forEach((e) {
                locationList.add(DropDownValue.fromJsonDynamic(
                    e, "locationCode", "locationName"));
              });
            }
            if (map['pageload'].containsKey('channels') &&
                map['pageload']['channels'] != null &&
                map['pageload']['channels'].length > 0) {
              map['pageload']['channels'].forEach((e) {
                channelList.add(DropDownValue.fromJsonDynamic(
                    e, "channelCode", "channelName"));
              });
            }
          }
        });
  }

  fetchClient(String locationName) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_CLIENT + locationName,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          clientList.clear();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('client') &&
              map['client'] != null &&
              map['client'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['client'].forEach((e) {
              dataList.add(
                  DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
            });
            clientList = dataList;
          }
        });
  }

  fetchAgency() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "LocationName": selectedLocation?.value ?? "",
      "ChannelName": ((selectedChannel?.value) ?? ""),
      "ClientName": ((selectedClient?.value) ?? ""),
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_AGENCY,
        json: postData,
        fun: (map) {
          Get.back();
          agencyList.clear();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('agency') &&
              map['agency'] != null &&
              map['agency'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['agency'].forEach((e) {
              dataList.add(
                  DropDownValue.fromJsonDynamic(e, "agencycode", "agencyname"));
            });
            agencyList = dataList;
            if (agencyList.isNotEmpty) {
              selectedAgency?.value = DropDownValue(
                  value: (agencyList[0].value ?? "").toString(),
                  key: (agencyList[0].key ?? "").toString());
              selectedAgency?.refresh();
            }
          }
        });
  }

  leaveDealNo() {
    Map<String, dynamic> postData = {
      "locationname": selectedLocation?.value ?? "",
      "channelname": ((selectedChannel?.value) ?? ""),
      "dealnumber": ((selectedDealNo?.value) ?? ""),
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_DEAL_LEAVE,
        json: postData,
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('dealleave') &&
              map['dealleave'] != null &&
              map['dealleave'].length > 0) {
            fromDateController.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddTHH:mm:ss')
                    .parse(map['dealleave'][0]['fromdate']));
            toDateController.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddTHH:mm:ss')
                    .parse(map['dealleave'][0]['todate']));
            utilAsOnDateController.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddTHH:mm:ss')
                    .parse(map['dealleave'][0]['todate']));
          }
        });
  }

  fetchADealNo() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "LocationName": selectedLocation?.value ?? "",
      "ChannelName": ((selectedChannel?.value) ?? ""),
      "ClientName": ((selectedClient?.value) ?? ""),
      // "ClientName": "PROCTER%26GAMBLH%26HMUM",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_DEAL,
        json: postData,
        fun: (map) {
          Get.back();
          // print(">>>>>>"+map.toString());
          dealNoList.clear();
          if (map is Map &&
              map.containsKey('deal') &&
              map['deal'] != null &&
              map['deal'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['deal'].forEach((e) {
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "dealnumber1", "dealNumber"));
            });
            dealNoList = dataList;
          }
        });
  }

  DealRecoSummaryModel? dealRecoSummaryModel;

  callGenerate() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": (selectedChannel?.key) ?? "",
      "dealnumber": (selectedDealNo?.value) ?? "",
      "FROMDATE": DateFormat('dd-MMM-yyyy').format(
              DateFormat('dd-MM-yyyy').parse(fromDateController.text)) ??
          "",
      "TODATE": DateFormat('dd-MMM-yyyy')
              .format(DateFormat('dd-MM-yyyy').parse(toDateController.text)) ??
          "",
      // "ClientName": "PROCTER%26GAMBLH%26HMUM",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GENERATE,
        json: postData,
        fun: (map) {
          Get.back();

          if (map is Map &&
              map.containsKey('genrate') &&
              map['genrate'] != null &&
              map['genrate'].length > 0) {
            dealRecoSummaryModel =
                DealRecoSummaryModel.fromJson(map as Map<String, dynamic>);
            num seconds = 0;
            num amount = 0;
            num utiliseTime = 0;
            num booked = 0;
            num bookedValAmount = 0;
            num balanceAmount = 0;
            num dealValAmount = 0;
            num balanceValAmount = 0;
            dealRecoSummaryModel?.gentare?.forEach((element) {
              seconds = (element.seconds ?? 0) + seconds;
              amount = (element.amount ?? 0) + amount;
              utiliseTime = (element.utilisedTime ?? 0) + utiliseTime;
              booked = (element.booked ?? 0) + booked;
              bookedValAmount = (element.bookedValAmount ?? 0) + bookedValAmount;
              balanceAmount = (element.balanceAmount ?? 0) + balanceAmount;
              dealValAmount = (element.dealvalamount ?? 0) + dealValAmount;
              balanceValAmount =
                  (element.balanceValAmount ?? 0) + balanceValAmount;
            });
            Gentare gentare = Gentare();
            gentare.endTime = "Total";
            gentare.seconds = seconds.toInt();
            gentare.amount = amount.toInt();
            gentare.utilisedTime = utiliseTime.toInt();
            gentare.booked = booked.toInt();
            gentare.bookedValAmount = bookedValAmount.toInt();
            gentare.dealvalamount = dealValAmount.toInt();
            gentare.balanceValAmount = balanceValAmount.toInt();
            gentare.balanceAmount = balanceAmount.toInt();
            dealRecoSummaryModel?.gentare?.add(gentare);
            print(">>>>>>" + (dealRecoSummaryModel?.toJson()).toString());
            update(['grid']);
          } else {
            dealRecoSummaryModel = null;
            update(['grid']);
          }
        });
  }

  @override
  void onInit() {
    fetchAllLoaderData();
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(String string) {
    if (string == "Exit") {
      Get.find<HomeController>()
          .postUserGridSetting1(listStateManager: [stateManager]);
    }
  }
}
