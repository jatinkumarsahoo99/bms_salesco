import 'dart:convert';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/ExportData.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../SameDayCollection/model/same_day_collection_model.dart';
import '../RateCardFromDealWorkFlowModel.dart';

class RateCardfromDealWorkflowController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var fromTC = TextEditingController();
  List<PermissionModel>? formPermissions;
  var dataTableList = <SameDayCollectionModel>[].obs;
  var checkedAll = false.obs;
  PlutoGridStateManager? manager;
  int lastSelctedIdx = 0;
  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(
        Routes.RATE_CARDFROM_DEAL_WORKFLOW.replaceAll("/", ""));
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

  getOnLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Rate_Card_From_Deal_Workflow_LOAD,
        fun: (map) {
          closeDialogIfOpen();
          locationList.clear();
          if (map is Map &&
              map.containsKey('location') &&
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

  getChannel(String locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Rate_Card_From_Deal_Workflow_GET_Channel +
            "?locationcode=" +
            locationCode,
        fun: (map) {
          closeDialogIfOpen();
          channelList.clear();
          if (map is Map &&
              map.containsKey('channel') &&
              map['channel'] != null &&
              map['channel'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['channel'].forEach((e) {
              dataList.add(new DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
            channelList = dataList;
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

  RateCardFromDealWorkFlowModel? rateCardFromDealWorkFlowModel = RateCardFromDealWorkFlowModel(export: []);
  RateCardFromDealWorkFlowModel? gridData = RateCardFromDealWorkFlowModel(export: []);
  getExportData() {
    LoadingDialog.call();
    Map<String, dynamic> sendData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? ""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
      api: ApiFactory.Rate_Card_From_Deal_Workflow_Export,
      json: sendData,
      fun: (map) {
        Get.back();
        if (map is Map &&
            map.containsKey('export') &&
            map['export'] != null &&
            map['export'].length > 0) {
          rateCardFromDealWorkFlowModel =
              RateCardFromDealWorkFlowModel.fromJson(
                  map as Map<String, dynamic>);
        } else {
          rateCardFromDealWorkFlowModel =
              RateCardFromDealWorkFlowModel(export: []);
        }
      },
    );
  }

  exportBtn() {
    // ExportData().exportExcelFromJsonList();
    if (rateCardFromDealWorkFlowModel!.export!.isNotEmpty) {
      try {
        ExportData().exportExcelFromJsonList1(
            rateCardFromDealWorkFlowModel!.export
                ?.map((e) => e.toJson())
                .toList(),
            "Rate Card &${selectedLocation?.value ?? ""} &${selectedChannel?.value ?? ""}");
      } catch (e) {
        LoadingDialog.showErrorDialog(e.toString());
      }
    } else {
      LoadingDialog.showErrorDialog("We have no data");
    }
  }

  pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null && result.files.single != null) {
      // loadBtn(result.files[0],result);
      Uint8List? fileBytes = result.files.first.bytes;
      var excel = Excel.decodeBytes(result.files.first.bytes as List<int>);

      for (var table in excel.tables.keys) {
        // print(table); //sheet Name
        // print(excel.tables[table]?.maxCols);
        // print(excel.tables[table]?.maxRows);
        for (var row in excel.tables[table]!.rows) {
          print('>>>>>>>>>>>>>>>>'+row.toList().toString());
        }
      }
    } else {
      // User canceled the pic5ker
      print(">>>>dataCancel");
    }
  }

  loadBtn(PlatformFile file,FilePickerResult res) {
    // print("file"+file.path.toString());
    // var bytes = File(file.path!).readAsBytesSync();
    var bytes = file.bytes;
    Uint8List? fileBytes = res.files.first.bytes;
    String fileContent = String.fromCharCodes(fileBytes!);
    // print(fileContent);
    Map<String, dynamic> mapData = jsonDecode(fileContent);
    print(">>>>>>>>>mapData"+mapData.toString());
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
      // saveRecord();
    }
  }
}
