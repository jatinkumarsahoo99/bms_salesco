import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class DealvsRODataReportController extends GetxController {
  var fromDate = TextEditingController(), toDate = TextEditingController();
  var locations = RxList<DropDownValue>();
  var channels = RxList<DropDownValue>();
  var clients = RxList<DropDownValue>();
  var dealsNo = RxList<DropDownValue>();

  var fDate = "";
  var tDate = "";

  var channelFN = FocusNode(),
      clintFN = FocusNode(),
      locationFN = FocusNode(),
      dealFN = FocusNode();

  List<String> dataTypes = [
    "Dealwise",
    "ROWise",
    "DealvsRO",
  ];

  var currentType = "Dealwise".obs;
  //input controllers
  // DropDownValue? selectLocation;
  // DropDownValue? selectChannel;
  // DropDownValue? selectClient;
  // DropDownValue? selectDealsNo;
  Rxn<DropDownValue> selectLocation = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectChannel = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectClient = Rxn<DropDownValue>();
  Rxn<DropDownValue> selectDealsNo = Rxn<DropDownValue>();

  bool isDealWise = true;
  bool isROWise = false;
  bool isDealvsRO = false;
  var isDealMSG = "".obs;

  Future<void> getRadioStatus(String name) async {
    switch (name) {
      case "Dealwise":
        isDealWise = true;
        isROWise = false;
        isDealvsRO = false;
        break;
      case "ROWise":
        isDealWise = false;
        isROWise = true;
        isDealvsRO = false;
        break;
      case "DealvsRO":
        isDealWise = false;
        isROWise = false;
        isDealvsRO = true;
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 1)).then((value) {
      getLocations();
    });
    // addListeneres();
  }

  getLocations() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_VS_RO_DATA_REPORT_DATAINITIAL,
        fun: (Map map) {
          Get.back();
          locations.clear();
          map["onLoadInfo"]["lstLocation"].forEach((e) {
            locations.add(DropDownValue.fromJson1(e));
          });
          fromDate.text = DateFormat("dd-MM-yyyy").format(
              DateFormat("MM/dd/yyyy hh:mm:ss").parse(map["onLoadInfo"]
                      ["getFromToDate"]["formDate"] ??
                  "10/01/2023 00:00:00"));
          print(fromDate.text);

          toDate.text = DateFormat("dd-MM-yyyy").format(
              DateFormat("MM/dd/yyyy hh:mm:ss").parse(map["onLoadInfo"]
                      ["getFromToDate"]["toDate"] ??
                  "10/01/2023 00:00:00"));
          print(toDate.text);
          fDate = fromDate.text;
          tDate = toDate.text;
          // update(['rootUI']);
        });
  }

  getChannels(locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_VS_RO_DATA_REPORT_GET_CHANNEL(locationCode),
        fun: (Map map) {
          Get.back();
          if (map != null &&
              map is Map<String, dynamic> &&
              map['channelList'] != null) {
            channels.clear();
            map["channelList"].forEach((e) {
              channels.add(DropDownValue(
                  key: e["channelCode"], value: e["channelName"]));
            });
          } else {}
        });
  }

  getClients(locationCode, channelCode) {
    LoadingDialog.call();

    var startDate = DateFormat("yyyy-MM-dd")
        .format(DateFormat("dd-MM-yyyy").parse(fromDate.text ?? "10/01/2023"));
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_VS_RO_DATA_REPORT_GET_CLIENT(
            locationCode, channelCode, startDate.toString()),
        fun: (Map map) {
          Get.back();
          if (map != null &&
              map is Map<String, dynamic> &&
              map['getDealList'] != null &&
              map.containsKey('getDealList') &&
              map['getDealList'].isNotEmpty) {
            clients.clear();
            map["getDealList"].forEach((e) {
              clients.add(
                  DropDownValue(key: e["clientCode"], value: e["clientName"]));
            });
          } else {
            LoadingDialog.showErrorDialog(
                'No active Client found for the current selection.');
          }
        });
  }

  getDeals(
    locationCode,
    channelCode,
    clintCode,
  ) {
    LoadingDialog.call();
    selectDealsNo.value = null;
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_VS_RO_DATA_REPORT_GET_DEAL(
            locationCode,
            channelCode,
            clintCode,
            DateFormat("yyyy-MM-ddT00:00:00").format(startDate),
            DateFormat("yyyy-MM-ddT00:00:00").format(endDate)),
        fun: (Map map) {
          Get.back();
          if (map != null &&
              map['getDeals'] != null &&
              map.containsKey('getDeals') &&
              map['getDeals'].isNotEmpty) {
            dealsNo.clear();
            dealsNo.value.addAll((map["getDeals"] as List<dynamic>)
                .map((e) => DropDownValue(value: e["dealNumber"]))
                .toList());
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   clintFN.nextFocus();
            // });
          } else {
            LoadingDialog.showErrorDialog(
                'No active Deal number found for the current selection.');
          }
        });
  }

  var dataTableList = [].obs;

  retrieveData() {
    isDealMSG.value = '';
    if (selectLocation.value?.key == null ||
        selectChannel.value?.key == null ||
        selectDealsNo.value?.value == null) {
      LoadingDialog.showErrorDialog(
          'Location,channel and deal no. is must to select.');
    } else {
      var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
      var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
      print(isDealWise);
      print(isROWise);
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.DEAL_VS_RO_DATA_REPORT_GENERATE_REPORT(
              selectLocation.value?.key.toString() ?? "",
              selectChannel.value?.key.toString() ?? "",
              isDealWise.toString(),
              isROWise.toString(),
              DateFormat("yyyy-MM-ddT00:00:00").format(startDate),
              DateFormat("yyyy-MM-ddT00:00:00").format(endDate),
              selectDealsNo.value!.value.toString()),
          fun: (Map map) {
            Get.back();
            if (map != null &&
                map['getReportData'] != null &&
                map.containsKey('getReportData') &&
                (map['getReportData']["result"] as List<dynamic>).isNotEmpty) {
              dataTableList.clear();
              dataTableList.value = map['getReportData']['result'];
              if (isDealWise) {
                isDealMSG.value = 'Deal wise data showing.';
              } else if (isROWise) {
                isDealMSG.value = 'RO wise data showing.';
              } else {
                isDealMSG.value = 'DealvsRo wise data showing.';
              }
            } else {
              LoadingDialog.showErrorDialog('No data found.');
            }
          },
          failed: (resp) {
            Get.back();
            dataTableList.clear();
            LoadingDialog.showErrorDialog(resp.toString());
          });
    }
  }

  // addListeneres() {
  //   channelFN.onKey = (node, event) {
  //     if (event.logicalKey == LogicalKeyboardKey.tab && !event.isShiftPressed) {
  //       getClients(selectLocation.value!.key, selectChannel.value!.key);
  //     }
  //     return KeyEventResult.ignored;
  //   };

  //   clintFN.onKey = (node, event) {
  //     if (event.logicalKey == LogicalKeyboardKey.tab && !event.isShiftPressed) {
  //       getDeals(selectLocation.value!.key, selectChannel.value!.key,
  //           selectClient.value!.key);
  //     }
  //     return KeyEventResult.ignored;
  //   };
  // }

  clear() {
    selectLocation.value = null;
    selectChannel.value = null;
    selectClient.value = null;
    selectDealsNo.value = null;
    fromDate.text = fDate;
    toDate.text = tDate;
  }
}
