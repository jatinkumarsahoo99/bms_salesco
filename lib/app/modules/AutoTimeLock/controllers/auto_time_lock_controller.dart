import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../model/auto_lock_time_model.dart';

class AutoTimeLockController extends GetxController {
  var locationList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation;
  var locationFN = FocusNode();
  List<PermissionModel>? formPermissions;
  PlutoGridStateManager? stateManager;
  int lastSelectedIdx = 0;
  var dataTableList = <AutoTimeLockModel>[].obs;
  Rx<bool> enable = Rx<bool>(true);

  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    dataTableList.refresh();
  }

  @override
  void onInit() {
    formPermissions =
        Utils.fetchPermissions1(Routes.AUTO_TIME_LOCK.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  void saveData() {
    if (selectedLocation == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (dataTableList.isEmpty) {
      LoadingDialog.callInfoMessage("No records to save.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.MANAGE_CHANNEL_LOCKS_SAVE,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['show'] != null &&
              !(resp['show']['isError'] as bool)) {
            LoadingDialog.callDataSaved(
              msg: resp['show']['genericMessage'].toString(),
              callback: () {
                Get.back();
                clearPage();
              },
            );
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: {
          "locationCode": selectedLocation?.key ?? "",
          "saveLists":
              dataTableList.value.map((e) => e.toJson(fromSave: true)).toList(),
        },
      );
    }
  }

  clearPage() {
    if(selectedLocation == null){
      LoadingDialog.showErrorDialog("Please select location");
    }else{
      lastSelectedIdx = 0;
      stateManager = null;
      dataTableList.clear();
      selectedLocation = null;
      enable.value = true;
      enable.refresh();
      locationList.refresh();
      locationFN.requestFocus();
    }

  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MANAGE_CHANNEL_LOCKS_GET_DATA(val.key.toString()),
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['show'] != null) {
            enable.value = false;
            enable.refresh();
            dataTableList.clear();
            dataTableList.value = (resp['show'] as List<dynamic>)
                .map((e) => AutoTimeLockModel.fromJson(e))
                .toList();

          } else {
            enable.value = true;
            enable.refresh();
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          enable.value = true;
          enable.refresh();
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getOnLoadData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MANAGE_CHANNEL_LOCKS_GET_LOCATION,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['location'] != null) {
            locationList.clear();
            locationList.value.addAll((resp['location'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['locationCode'].toString(),
                      value: e['locationName'].toString(),
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        });
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Save") {
      saveData();
    } else if (btn == "Exit") {
      Get.find<HomeController>()
          .postUserGridSetting1(listStateManager: [stateManager]);
    }
  }
}
