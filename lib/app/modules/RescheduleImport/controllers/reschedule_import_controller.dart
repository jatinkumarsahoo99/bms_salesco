import 'dart:convert';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../SameDayCollection/model/same_day_collection_model.dart';
import '../RescheduleImportModel.dart';

class RescheduleImportController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var channelFN = FocusNode();
  var fromTC = TextEditingController();
  List<PermissionModel>? formPermissions;
  var dataTableList = <dynamic>[].obs;
  var checkedAll = false.obs;
  PlutoGridStateManager? manager;
  int lastSelctedIdx = 0;
  var fileName = "".obs;
  FilePickerResult? result;
  RescheduleImportModel? rescheduleImportModel =
  RescheduleImportModel(lstreimport: []);
  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(
        Routes.RATE_CARDFROM_DEAL_WORKFLOW.replaceAll("/", ""));
    super.onInit();
  }
  

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  saveRecord() {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.Reschedule_Import_ReImport,
        fun: (map) {
          closeDialogIfOpen();
          if(map is Map && map.containsKey('message') && map['message'] != null ){
            clearAll();
            LoadingDialog.callDataSavedMessage(map['message']);

          }else{
            LoadingDialog.showErrorDialog(map.toString());
          }
        },
        json: rescheduleImportModel?.toJson(),
      );
  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      closeDialogIfOpen();
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Reschedule_Import_Get_Channel + (val.key ?? ""),
        fun: (resp) {
          closeDialogIfOpen();
          channelList.clear();
          if (resp is Map &&
              resp.containsKey("channel") &&
              resp['channel'] != null &&
              resp['channel'].length > 0) {
            resp['channel'].forEach((e) {
              channelList.add(DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
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
        api: ApiFactory.Reschedule_Import_LOAD,
        fun: (resp) {
          closeDialogIfOpen();
          locationList.clear();
          if (resp is Map &&
              resp.containsKey('location') &&
              resp['location'] != null &&
              resp['location'].length > 0) {
            resp['location'].forEach((e) {
              locationList.add(new DropDownValue.fromJsonDynamic(
                  e, "locationCode", "locationName"));
            });
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
      clearAll();
    }
  }

  void handleCheckAndUncheck() {}
  clearAll() {
    Get.delete<RescheduleImportController>();
    Get.find<HomeController>().clearPage1();
  }


  Future<void> selectFile() async {
    LoadingDialog.call();
    result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );
    fileName.value = result?.files[0].name ?? "";
    closeDialogIfOpen();
  }

  showBtn() {
    try {
      if (result != null && result!.files.isNotEmpty) {
        var excel = Excel.decodeBytes(result!.files[0].bytes!.toList());
        var tempList = <Map<String, dynamic>>[];
        for (var sheetName in excel.tables.keys) {
          for (var row in (excel.tables[sheetName]!.rows)) {
            // row ko iterate
            var data = <String, dynamic>{};
            for (var i = 0; i < row.length; i++) {
              /// row key cells
              data[(excel.tables[sheetName]!.rows.first[i]?.value).toString()] =
                  row[i]?.value.toString();
            }
            tempList.add(data);
          }
        }

        tempList.removeAt(0);
        // print(jsonEncode(tempList));
        Map<String, dynamic> postData = {
          "lstreimport": tempList,
          "locationCode": selectedLocation?.key ?? "",
          "channelCode": selectedChannel?.key ?? ""
        };
        rescheduleImportModel = RescheduleImportModel.fromJson(postData);
        print(">>>>>>tojson" + rescheduleImportModel!.toJson().toString());
        dataTableList.value = tempList;
      } else {
        LoadingDialog.showErrorDialog("Please select file");
      }
    } catch (e) {
      print(">>>>>"+e.toString());
      LoadingDialog.showErrorDialog(e.toString());
    }
  }
}
