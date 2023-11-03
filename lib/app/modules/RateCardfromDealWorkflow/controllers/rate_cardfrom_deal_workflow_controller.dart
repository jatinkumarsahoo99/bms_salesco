import 'dart:convert';
import 'dart:developer';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/ExportData.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
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
  TextEditingController pathController = TextEditingController();
  PlutoGridStateManager? stateManager;
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

  RateCardFromDealWorkFlowModel? rateCardFromDealWorkFlowModel =
      RateCardFromDealWorkFlowModel(export: []);
  RateCardFromDealWorkFlowModel gridData =
      RateCardFromDealWorkFlowModel(export: []);
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
    LoadingDialog.call();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx', 'xls'],
      type: FileType.custom,
    );
    closeDialogIfOpen();
    if (result != null && result.files.single != null) {
      // print(">>>>>>filename"+(result.files[0].name.toString()));
      pathController.text = result.files[0].name.toString();

      loadBtn(result);
    } else {
      LoadingDialog.showErrorDialog("Please try again");
      // User canceled the pic5ker
      print(">>>>dataCancel");
    }
  }

  loadBtn(FilePickerResult result) {
    LoadingDialog.call();
    var jsonData = <String, dynamic>{};
    try {
      Uint8List? fileBytes = result.files.first.bytes;
      var excel = Excel.decodeBytes(result.files.first.bytes as List<int>);

      int sheet = 0;
      for (var table in excel.tables.keys) {
        var tableData = <Map<String, dynamic>>[];
        sheet = sheet + 1;
        // Extract headers from the first row
        var headers = excel.tables[table]!
            .row(0)
            .map((cell) => cell?.value.toString())
            .toList();

        print(">>>>>" + headers.toString());

        for (var rowIdx = 1; rowIdx <= excel.tables[table]!.maxRows; rowIdx++) {
          var rowData = <String, dynamic>{};
          var row = excel.tables[table]!.row(rowIdx);
          for (var colIdx = 0; colIdx < row.length; colIdx++) {
            var header = headers[colIdx];
            var cellValue = row[colIdx]?.value.toString();
            rowData[header ?? ""] = cellValue;
          }
          if (rowData.isNotEmpty) {
            tableData.add(rowData);
          }
        }
        jsonData['S${sheet}'] = tableData;
      }
      if (jsonData.containsKey('S1') && jsonData['S1'] != null) {
        gridData = RateCardFromDealWorkFlowModel.fromJson1(jsonData);
        closeDialogIfOpen();
        update(['grid']);
      } else {
        gridData = RateCardFromDealWorkFlowModel(export: []);
        closeDialogIfOpen();
        update(['grid']);
      }
    } catch (e) {
      print(">>>>" + e.toString());
      gridData = RateCardFromDealWorkFlowModel(export: []);
      closeDialogIfOpen();
      update(['grid']);
      LoadingDialog.showErrorDialog(e.toString());
    }
  }

  saveBtn() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "modifiedby": Get.find<MainController>().user?.logincode ?? "",
      "typeRateCards": gridData.export?.map((e) => e.toJson1()).toList()
    };
    try{
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Rate_Card_From_Deal_Workflow_SAVE,
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            print(">>" + map.toString());
            /*if (map is Map &&
              map.containsKey('message') &&
              map['message'] != null) {
            LoadingDialog.callDataSavedMessage(map['message'] ?? "",
                callback: () {
              clearAll();
            });
          }
          else {
            LoadingDialog.showErrorDialog((map ?? "").toString());
          }*/
          });
    }catch(e){
      closeDialogIfOpen();
    }

  }

  clearAll() {
    Get.delete<RateCardfromDealWorkflowController>();
    Get.find<HomeController>().clearPage1();
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  docs() async {
    String documentKey = "";
    if (selectedLocation == null || selectedChannel == null) {
      documentKey = "";
    } else {
      documentKey = "Rate card " +
          (selectedLocation?.key ?? "") +
          (selectedChannel?.key ?? "");
    }

    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearAll();
    } else if (btn == "Save") {
      saveBtn();
    } else if (btn == "Docs") {
      docs();
    }
  }
}
