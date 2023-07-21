import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../model/tape_id_campaign_model.dart';

class TapeIDCampaignController extends GetxController {
  List<PermissionModel>? formPermissions;
  var tapeIDTC = TextEditingController(), startDateTC = TextEditingController(), endDateTC = TextEditingController();
  // var activityMonth = "", client = "", agency = "", brand = "", caption = "", duration = "", agencyTapeID = "", createdBy = "";
  String selectedValuUI = "selectedValuUI", activityMonth = "";
  DateTime now = DateTime.now();

  var selectedTab = 0.obs;
  TapeIDCampaignLoadModel? loadModel;
  TapeIdCampaignHistoryModel? history;
  var tapeIdFN = FocusNode();

  @override
  void onReady() {
    super.onReady();
    tapeIdFN.addListener(() {
      if (!tapeIdFN.hasFocus) {
        tapeIdLeave();
      }
    });
  }

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.TAPE_I_D_CAMPAIGN.replaceAll("/", ""));
    super.onInit();
  }

  clearPage() {
    tapeIDTC.clear();
    history = null;
    startDateTC.clear();
    endDateTC.clear();
    activityMonth = "";
    loadModel = null;
    updateUI();
  }

  updateUI() {
    selectedTab.refresh();
    update([selectedValuUI]);
  }

  tapeIdLeave() {
    if (tapeIDTC.text.trim().isNotEmpty) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TAPE_ID_CAMPAIGN_ON_LEAVE(tapeIDTC.text.trim()),
        fun: (resp) {
          Get.back();
          if (resp is Map<String, dynamic> && resp['tapeIdDetails'] != null) {
            activityMonth = DateFormat("yyyyMM").format(DateTime.now());
            loadModel = TapeIDCampaignLoadModel.fromJson(resp);
            if (selectedTab.value == 0) {
              updateUI();
            }
            getHistory();
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          if (resp is Map<String, dynamic> && resp['status'] == "failure") {
            LoadingDialog.showErrorDialog(resp['message'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }

  getHistory() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.TAPE_ID_CAMPAIGN_GET_HISTORY(tapeIDTC.text.trim()),
      fun: (resp) {
        Get.back();
        if (resp is Map<String, dynamic> && resp['historyDetails'] != null) {
          history = TapeIdCampaignHistoryModel.fromJson(resp);
          if (selectedTab.value == 1) {
            updateUI();
          }
        } else {
          LoadingDialog.showErrorDialog(resp.toString());
        }
      },
      failed: (resp) {
        Get.back();
        if (resp is Map<String, dynamic> && resp['status'] == "failure") {
          LoadingDialog.showErrorDialog(resp['message'].toString());
        } else {
          LoadingDialog.showErrorDialog(resp.toString());
        }
      },
    );
  }

  saveRecord() {
    if (loadModel == null || history == null) {
      LoadingDialog.showErrorDialog("Please load data first");
    } else if (loadModel?.tapeIdDetails.locationLst.any((e) => e.selectRow) ?? false) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.TAPE_ID_CAMPAIGN_SAVE_RECORD,
        fun: (resp) {
          Get.back();
          LoadingDialog.callDataSaved(msg: resp.toString());
        },
        json: {
          "exportTapeCode": "",
          "brandCode": loadModel?.tapeIdDetails.brandCode,
          "activityMonth": activityMonth,
          "data": loadModel?.tapeIdDetails.locationLst.map((e) => e.toJson(fromSave: true)).toList() ?? [],
        },
      );
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.TAPE_ID_CAMPAIGN_UPDATE_HISTORY,
        fun: (resp) {
          Get.back();
          LoadingDialog.callDataSaved(msg: resp.toString());
        },
        json: history?.historyDetails.map((e) => e.toJson(fromSave: true)).toList(),
      );
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Save") {
      saveRecord();
    }
  }
}
