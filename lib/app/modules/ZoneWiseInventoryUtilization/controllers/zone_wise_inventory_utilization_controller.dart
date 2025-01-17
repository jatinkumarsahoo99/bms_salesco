import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../SameDayCollection/model/same_day_collection_model.dart';
import '../ZoneWiseUtilizationResponseModel.dart';

class ZoneWiseInventoryUtilizationController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var fromTC = TextEditingController();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

  List<PermissionModel>? formPermissions;
  var dataTableList = <SameDayCollectionModel>[].obs;
  var checkedAll = false.obs;
  PlutoGridStateManager? manager;
  int lastSelctedIdx = 0;
  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(
        Routes.ZONE_WISE_INVENTORY_UTILIZATION.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  clearPage() {
    fromTC.clear();
    dataTableList.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
    lastSelctedIdx = 0;
    manager = null;
    zoneWiseUtilizationResponseModel = ZoneWiseUtilizationResponseModel(generate: []);
  }

  clearAll() {
    Get.delete<ZoneWiseInventoryUtilizationController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  getOnLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ZoneWiseInventory_LOAD,
        fun: (map) {
          closeDialogIfOpen();
          locationList.clear();
          if (map is Map &&
              map.containsKey("location") &&
              map['location'] != null &&
              map['location'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['location'].forEach((e) {
              dataList.add(new DropDownValue.fromJsonDynamic(
                  e, "locationCode", "locationName"));
            });
            locationList = dataList;
          }
        },
        failed: (resp) {
          closeDialogIfOpen();
          if (resp is Map<String, dynamic> && resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        });
  }

  getChannel(String location) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ZoneWiseInventory_GET_CHANNEL +
            "?Locationcode=" +
            location,
        fun: (map) {
          closeDialogIfOpen();
          channelList.clear();
          if (map is Map &&
              map.containsKey("channel") &&
              map['channel'] != null &&
              map['channel'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['channel'].forEach((e) {
              dataList.add(new DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
            channelList = dataList;
            selectedChannel = null;
          }
        },
        failed: (resp) {
          closeDialogIfOpen();
          if (resp is Map<String, dynamic> && resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        });
  }

  String convertDateFromat(String date) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(DateFormat('dd-MM-yyyy').parse(date));
  }

  ZoneWiseUtilizationResponseModel? zoneWiseUtilizationResponseModel =
  ZoneWiseUtilizationResponseModel(generate: []);

  callGenerate() {
    print("function call");
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "ZAZEE00001",
      "fromdate": convertDateFromat(fromDateController.text) ?? "",
      "todate": convertDateFromat(toDateController.text) ?? "",
      "fromtime": fromTimeController.text ?? "10:00:00:00",
      "totime": toTimeController.text ?? "12:00:00:00"
    };
    print(">>>map" + postData.toString());
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.ZoneWiseInventory_GENERATE,
      json: postData,
      fun: (map) {
        closeDialogIfOpen();
        if (map is Map &&
            map.containsKey('generate') &&
            map['generate'] != null &&
            map['generate'].length > 0) {
          zoneWiseUtilizationResponseModel =
              ZoneWiseUtilizationResponseModel.fromJson(
                  map as Map<String, dynamic>);
          // zoneWiseUtilizationResponseModel?.refresh();
          update(['grid']);
        } else {
          zoneWiseUtilizationResponseModel =
              ZoneWiseUtilizationResponseModel(generate: []);
          update(['grid']);
        }
      },
    );
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearAll();
    } else if (btn == "Exit") {
      Get.find<HomeController>()
          .postUserGridSetting1(listStateManager: [stateManager]);
    }
  }
}
