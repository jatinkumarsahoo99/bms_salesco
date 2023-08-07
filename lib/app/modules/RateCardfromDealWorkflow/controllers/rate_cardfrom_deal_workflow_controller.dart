import 'package:bms_salesco/app/data/DropDownValue.dart';
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

  getOnLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Rate_Card_From_Deal_Workflow_LOAD,
        fun: (map) {
          closeDialogIfOpen();
          locationList.clear();
          if(map is Map && map.containsKey('location') &&
              map['location'] != null && map['location'].length >0){
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
        api: ApiFactory.Rate_Card_From_Deal_Workflow_GET_Channel+"?locationcode="+locationCode,
        fun: (map) {
          closeDialogIfOpen();
          channelList.clear();
          if(map is Map && map.containsKey('channel') &&
              map['channel'] != null && map['channel'].length >0){
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
}
