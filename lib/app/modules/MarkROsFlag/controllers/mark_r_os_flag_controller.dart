import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../model/mark_ros_flag_model.dart';

class MarkROsFlagController extends GetxController {
  var effectiveDateTC = TextEditingController(),
      weekDaysTC = TextEditingController();
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  List<PermissionModel>? formPermissions;
  PlutoGridStateManager? stateManager;
  int lastSelectedIdx = 0;
  var dataTableList = <MarkROSFlagModel>[].obs;
  var bottomControllsEnable = true.obs;
  var buttonsList = ["Save Today", "Save All Days"];
  bool madeChanges = false;

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    formPermissions =
        Utils.fetchPermissions1(Routes.MARK_R_OS_FLAG.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  void saveTodayAndAllData(bool fromSaveToday) {
    if (selectedLocation == null || selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select Location,Channel.");
    } else if (dataTableList.isEmpty) {
      LoadingDialog.showErrorDialog("Please load data first");
    } else if (!madeChanges && !fromSaveToday) {
      LoadingDialog.showErrorDialog("No changes to save");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.MARK_ROS_FLAG_SAVE,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['save']['isError'] != null &&
              !(resp['save']['isError'] as bool)) {
            handleGenerateButton();
            // if (fromSaveToday) {
            //   handleGenerateButton();
            // } else {
            //   LoadingDialog.callDataSaved(
            //     msg: resp['save']['genericMessage'].toString(),
            //     callback: () {
            //       Get.back();
            //       handleGenerateButton();
            //     },
            //   );
            // }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: {
          "locationCode": selectedLocation?.key,
          "channelCode": selectedChannel?.key,
          "effectiveDate": DateFormat("yyyy-MM-dd")
              .format(DateFormat("dd-MM-yyyy").parse(effectiveDateTC.text)),
          "allDays": fromSaveToday ? "Y" : "N",
          "saveTodayAllDays":
              dataTableList.value.map((e) => e.toJson(fromSave: true)).toList(),
        },
      );
    }
  }

  clearPage() {
    lastSelectedIdx = 0;
    stateManager = null;
    dataTableList.clear();
    effectiveDateTC.clear();
    weekDaysTC.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
    madeChanges = false;
  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      closeDialogIfOpen();
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MARK_ROS_FLAG_GET_CHANNEL(val.key.toString()),
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp['channel'] != null &&
              resp['channel'] is List<dynamic>) {
            channelList.clear();
            selectedChannel = null;
            channelList.addAll((resp['channel'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['channelCode'].toString(),
                      value: e['channelName'].toString(),
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          closeDialogIfOpen();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getOnLoadData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MARK_ROS_FLAG_GET_LOCATION,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp['location'] != null &&
              resp['location'] is List<dynamic>) {
            locationList.value.addAll((resp['location'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['locationCode'].toString(),
                      value: e['locationName'].toString(),
                    ))
                .toList());
            // if (locationList.isNotEmpty) {
            //   selectedLocation = locationList.first;
            //   locationList.refresh();
            //   handleOnChangedLocation(selectedLocation);
            // }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          closeDialogIfOpen();
          LoadingDialog.showErrorDialog(resp.toString());
        });
  }

  void handleGenerateButton() {
    if (selectedLocation == null || selectedChannel == null) {
      LoadingDialog.showErrorDialog("select location and channel first.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MARK_ROS_FLAG_GET_DATA(
            selectedLocation?.key ?? "",
            selectedChannel?.key ?? "",
            DateFormat("yyyy-MM-ddT00:00:00")
                .format(DateFormat("dd-MM-yyyy").parse(effectiveDateTC.text))),
        fun: (resp) {
          closeDialogIfOpen();
          madeChanges = false;
          if (resp != null &&
              resp['show'] != null &&
              resp['show'] is List<dynamic>) {
            dataTableList.clear();
            dataTableList.value.addAll((resp['show'] as List<dynamic>)
                .map((e) => MarkROSFlagModel.fromJson(e))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          closeDialogIfOpen();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Save") {
    } else if (btn == "Exit") {
      Get.find<HomeController>().postUserGridSetting1(listStateManager: [
        stateManager,
      ]);
    }
  }
}
