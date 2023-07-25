import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../SameDayCollection/model/same_day_collection_model.dart';

class RescheduleImportController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var fromTC = TextEditingController();
  List<PermissionModel>? formPermissions;
  var dataTableList = <dynamic>[].obs;
  var checkedAll = false.obs;
  PlutoGridStateManager? manager;
  int lastSelctedIdx = 0;
  var fileName = "".obs;
  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.RATE_CARDFROM_DEAL_WORKFLOW.replaceAll("/", ""));
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
              LoadingDialog.showErrorDialog(resp['save']['errorMessage'].toString());
            }
          } else if (resp is Map<String, dynamic> && resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: dataTableList.map((element) => element.toJson(fromSame: true)).toList(),
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
          api: ApiFactory.SAME_DAY_COLLECTION_SHOW_DATA(selectedLocation?.key ?? "", selectedChannel?.key ?? ""),
          fun: (resp) {
            closeDialogIfOpen();
            if (resp != null && resp is Map<String, dynamic> && resp['show'] != null) {
              dataTableList.clear();
              dataTableList.addAll((resp['show'] as List<dynamic>).map((e) => SameDayCollectionModel.fromJson(e)).toList());
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
        api: ApiFactory.SAME_DAY_COLLECTION_ON_LEAVE_LOCATION(val.key.toString()),
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null && resp is Map<String, dynamic> && resp['channel'] != null && resp['channel'] is List<dynamic>) {
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
          if (resp != null && resp is Map<String, dynamic> && resp['location'] != null && resp['location'] is List<dynamic>) {
            locationList.value.addAll((resp['location'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['locationCode'].toString(),
                      value: e['locationName'].toString(),
                    ))
                .toList());
            if (locationList.isNotEmpty) {
              selectedLocation = locationList.first;
              locationList.refresh();
              handleOnChangedLocation(selectedLocation);
            }
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
    }
  }

  void handleCheckAndUncheck() {
    checkedAll.value = !checkedAll.value;
    if (dataTableList.isNotEmpty) {
      dataTableList.value = dataTableList.value.map((e) {
        e.cancel = checkedAll.value;
        return e;
      }).toList();
      dataTableList.refresh();
    }
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );
    if (result != null && result.files.isNotEmpty) {
      var excel = Excel.decodeBytes(result.files[0].bytes!.toList());
      var tempList = <Map<dynamic, dynamic>>[];
      for (var sheetName in excel.tables.keys) {
        for (var row in (excel.tables[sheetName]!.rows)) {
          // row ko iterate
          var data = <dynamic, dynamic>{};
          for (var i = 0; i < row.length; i++) {
            /// row key cells
            data[excel.tables[sheetName]!.rows.first[i]?.value.toString()] = row[i]?.value.toString();
          }
          tempList.add(data);
        }
      }

      print(tempList);
      tempList.removeAt(0);
      dataTableList.value = tempList;
      fileName.value = result.files[0].name;
    }
  }
}
