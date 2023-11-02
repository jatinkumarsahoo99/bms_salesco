import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../AsrunDetailsReport/AsrunDetailsReportModel.dart';
import '../../AsrunDetailsReport/ChannelListModel.dart';
import '../AuditStatusCancel.dart';
import '../AuditStatusGenerateToList.dart';
import '../AuditStatusReportModel.dart';

class AuditStatusReportController extends GetxController {
  //TODO: Implement AuditStatusReportController

  RxBool isEnable = RxBool(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);

  // RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  // RxString selectValue=RxString("Rechedule");

  List<ChannelListModel> channelList = [];
  RxBool checked = RxBool(false);

  TextEditingController frmDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController search = TextEditingController();

  TextEditingController dateController = TextEditingController();

  // AsrunDetailsReportModel ?asrunDetailsReportModel;

  AuditStatusReportModel? auditStatusReportModel;
  AuditStatusGenerateToList? auditStatusGenerateToList;
  PlutoGridStateManager? stateManager1;
  PlutoGridStateManager? stateManager2;
  PlutoGridStateManager? stateManager3;
  List<Map<String, Map<String, double>>>? userGridSetting1;

  ScrollController scrollController1 = ScrollController();

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  int? selectChannlIndex;

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.AUDIT_STATUS_REPORT_LOAD,
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
                channelList.add(new ChannelListModel(
                    ischecked: false,
                    channelName: e['channelName'],
                    channelCode: e['channelCode']));
              });
              update(['updateChannel']);
            }
          }
        });
  }

  clearAll() {
    Get.delete<AuditStatusReportController>();
    Get.find<HomeController>().clearPage1();
  }

  fetchGetGenerateAuditStatus() {
    List<ChannelListModel> channelListFilter = [];
    channelListFilter =
        channelList.where((element) => element.ischecked == true).toList();
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select location");
    } else if (channelListFilter.isEmpty) {
      LoadingDialog.showErrorDialog("Please select some channel");
    } else if (dateController.text == null || dateController.text == "") {
      LoadingDialog.showErrorDialog("Please select from date");
    } else {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "lstChannelList": channelListFilter.map((e) => e.toJson()).toList(),
        "locationcode": selectedLocation!.key ?? "",
        // "channelCode": selectLocation!.key??"",
        "date": DateFormat('yyyy-MM-ddTHH:mm:ss')
            .format(DateFormat("dd-MM-yyyy").parse(dateController.text))
      };
      // print(">>>>>postData>>>"+(postData).toString());
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AUDIT_STATUS_REPORT_GENERATE_AUDIT,
          json: postData,
          fun: (map) {
            Get.back();
            // print("map>>>"+ jsonEncode(map).toString());
            if (map is Map &&
                map.containsKey('audit') &&
                map['audit'] != null &&
                map['audit'].length > 0) {
              auditStatusCancel = null;
              auditStatusGenerateToList = null;
              auditStatusReportModel =
                  AuditStatusReportModel.fromJson(map as Map<String, dynamic>);
              update(['grid']);
            } else {
              auditStatusReportModel = null;
              auditStatusGenerateToList=null;
              auditStatusCancel=null;
              update(['grid']);
            }
          });
    }
  }

  AuditStatusCancel? auditStatusCancel;

  fetchGetGenerateAuditStatusCancel() {
    List<ChannelListModel> channelListFilter = [];
    channelListFilter =
        channelList.where((element) => element.ischecked == true).toList();
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select location");
    } else if (channelListFilter.isEmpty) {
      LoadingDialog.showErrorDialog("Please select some channel");
    } else if (dateController.text == null || dateController.text == "") {
      LoadingDialog.showErrorDialog("Please select from date");
    } else {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "lstChannelList": channelListFilter.map((e) => e.toJson()).toList(),
        "locationcode": selectedLocation!.key ?? "",
        // "channelCode": selectLocation!.key??"",
        "date": DateFormat('yyyy-MM-ddTHH:mm:ss')
            .format(DateFormat("dd-MM-yyyy").parse(dateController.text))
      };
      // print(">>>>>postData>>>"+(postData).toString());
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AUDIT_STATUS_REPORT_GENERATE_AUDIT_CANCEl,
          json: postData,
          fun: (map) {
            Get.back();
            // print("map>>>"+ jsonEncode(map).toString());
            if (map is Map &&
                map.containsKey('cancel') &&
                map['cancel'] != null &&
                map['cancel'].length > 0) {
              auditStatusReportModel = null;
              auditStatusGenerateToList = null;
              auditStatusCancel =
                  AuditStatusCancel.fromJson(map as Map<String, dynamic>);
              update(['grid']);
            } else {
              // auditStatusCancel = null;
              auditStatusReportModel = null;
              auditStatusGenerateToList=null;
              auditStatusCancel=null;
              update(['grid']);
            }
          });
    }
  }

  fetchGetGenerateTOList() {
    List<ChannelListModel> channelListFilter = [];
    channelListFilter =
        channelList.where((element) => element.ischecked == true).toList();
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select location");
    } else if (channelListFilter.isEmpty) {
      LoadingDialog.showErrorDialog("Please select some channel");
    } else if (frmDate.text == null || frmDate.text == "") {
      LoadingDialog.showErrorDialog("Please select from date");
    } else if (toDate.text == null || toDate.text == "") {
      LoadingDialog.showErrorDialog("Please select to date");
    } else {
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "lstChannelList": channelListFilter.map((e) => e.toJson()).toList(),
        "locationcode": selectedLocation!.key ?? "",
        // "channelCode": selectLocation!.key??"",
        "fromdate": DateFormat('yyyy-MM-ddTHH:mm:ss')
            .format(DateFormat("dd-MM-yyyy").parse(frmDate.text)),
        "todate": DateFormat('yyyy-MM-ddTHH:mm:ss')
            .format(DateFormat("dd-MM-yyyy").parse(toDate.text)),
      };
      print(">>>>>postData>>>" + (postData).toString());
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AUDIT_STATUS_REPORT_GENERATE_TOLIST,
          json: postData,
          fun: (map) {
            Get.back();
            print("map>>>" + jsonEncode(map).toString());
            if (map is Map &&
                map.containsKey('toList') &&
                map['toList'] != null &&
                map['toList'].length > 0) {
              auditStatusReportModel = null;
              auditStatusCancel = null;

              auditStatusGenerateToList = AuditStatusGenerateToList.fromJson(
                  map as Map<String, dynamic>);
              update(['grid']);
            } else {
              // auditStatusGenerateToList = null;
              auditStatusReportModel = null;
              auditStatusGenerateToList=null;
              auditStatusCancel=null;
              update(['grid']);
            }
          });
    }
  }

  @override
  void onInit() {
    fetchUserSetting1();
    fetchAllLoaderData();
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
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [stateManager1, stateManager2],
          tableNamesList: ['tbl1', 'tbl2']);
    }
  }

  void increment() => count.value++;

  void searchInSecondaryChannel() {
    if (search.text == "") {
      selectChannlIndex = null;
      _animateToIndex(0);
    } else {
      selectChannlIndex = channelList.indexWhere((element) {
        return element.channelName.toString().toLowerCase() ==
            search.text.toLowerCase();
      });

      if (selectChannlIndex == null || selectChannlIndex == -1) {
        selectChannlIndex = channelList.indexWhere((element) {
          return element.channelName
              .toString()
              .toLowerCase()
              .contains(search.text.toLowerCase());
        });
      }
      _animateToIndex(selectChannlIndex!);
    }
    update(["updateChannel"]);
  }

  void _animateToIndex(int index) {
    print("Search index is:${index.toString()}");
    scrollController1.animateTo(
      index * 30,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
