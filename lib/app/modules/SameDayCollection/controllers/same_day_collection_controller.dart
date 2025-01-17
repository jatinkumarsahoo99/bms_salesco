import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../model/same_day_collection_model.dart';

class SameDayCollectionController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var fromTC = TextEditingController();
  List<PermissionModel>? formPermissions;
  var dataTableList = <SameDayCollectionModel>[].obs;
  var checkedAll = false.obs;
  var isControllsEnable = true.obs;
  PlutoGridStateManager? manager;
  int lastSelctedIdx = 0;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    formPermissions =
        Utils.fetchPermissions1(Routes.SAME_DAY_COLLECTION.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  clearPage() {
    isControllsEnable.value = true;
    fromTC.clear();
    dataTableList.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
    lastSelctedIdx = 0;
    manager = null;
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  saveRecord() {
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select Location");
    } else if (selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select Channel");
    } else if (dataTableList.isEmpty) {
      LoadingDialog.showErrorDialog("Please load data first.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.SAME_DAY_COLLECTION_SAVE_DATA,
        fun: (resp) {
          Get.back();
          if (resp is Map<String, dynamic> && resp['save'] != null) {
            if (!(resp['save']['isError'] as bool)) {
              LoadingDialog.callDataSaved(
                msg: resp['save']['genericMessage'].toString(),
                callback: () {
                  clearPage();
                },
              );
            } else {
              LoadingDialog.showErrorDialog(
                  resp['save']['errorMessage'].toString());
            }
          } else if (resp is Map<String, dynamic> &&
              resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: dataTableList
            .map((element) => element.toJson(fromSame: true))
            .toList(),
      );
    }
  }

  showData() {
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select Location");
    } else if (selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select Channel");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.SAME_DAY_COLLECTION_SHOW_DATA(
              selectedLocation?.key ?? "", selectedChannel?.key ?? ""),
          fun: (resp) {
            closeDialogIfOpen();
            if (resp != null &&
                resp is Map<String, dynamic> &&
                resp['show'] != null) {
              dataTableList.clear();
              dataTableList.addAll((resp['show'] as List<dynamic>)
                  .map((e) => SameDayCollectionModel.fromJson(e))
                  .toList());
              isControllsEnable.value = false;
            } else {
              if (resp is Map<String, dynamic> && resp['status'] == "failure") {
                LoadingDialog.showErrorDialog(resp['message'].toString());
              } else {
                LoadingDialog.showErrorDialog(resp.toString());
              }
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
  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      closeDialogIfOpen();
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SAME_DAY_COLLECTION_ON_LEAVE_LOCATION(
            val.key.toString()),
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp is Map<String, dynamic> &&
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
          if (resp is Map<String, dynamic> && resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }

  getOnLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.SAME_DAY_COLLECTION_ON_LOAD,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp is Map<String, dynamic> &&
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
            if (resp is Map<String, dynamic> && resp['status'] == "failure") {
              LoadingDialog.showErrorDialog(resp['message'].toString());
            } else {
              LoadingDialog.showErrorDialog(resp.toString());
            }
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

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Save") {
      saveRecord();
    } else if (btn == "Exit") {
      Get.find<HomeController>()
          .postUserGridSetting1(listStateManager: [manager]);
    }
  }

  void handleCheckAndUncheck() {
    checkedAll.value = !checkedAll.value;
    if (dataTableList.isNotEmpty) {
      for (var i = 0; i < manager!.refRows.length; i++) {
        dataTableList.value[manager!.refRows[i].sortIdx].cancel =
            checkedAll.value;
        manager!.changeCellValue(
          manager!.refRows[i].cells['cancel']!,
          checkedAll.value.toString(),
          callOnChangedEvent: false,
          force: true,
        );
      }
    }
  }
}
