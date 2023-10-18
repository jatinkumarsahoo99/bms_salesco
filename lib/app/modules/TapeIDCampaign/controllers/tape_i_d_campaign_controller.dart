import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/HomeController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../model/tape_id_campaign_model.dart';

class TapeIDCampaignController extends GetxController {
  List<PermissionModel>? formPermissions;
  var tapeIDTC = TextEditingController(),
      startDateTC = TextEditingController(),
      endDateTC = TextEditingController();
  // var activityMonth = "", client = "", agency = "", brand = "", caption = "", duration = "", agencyTapeID = "", createdBy = "";
  String selectedValuUI = "selectedValuUI";
  var activityMonth = "".obs;
  DateTime now = DateTime.now();
  PlutoGridStateManager? locationChannelManager, historyManager;
  int lastLocationChannelEditIdx = 0, historyEditIdx = 0;

  var selectedTab = 0.obs;
  TapeIDCampaignLoadModel? loadModel;
  TapeIdCampaignHistoryModel? history;
  var tapeIdFN = FocusNode();

  var startDate =
      DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
  var endDate = DateTime.now();

  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onReady() {
    super.onReady();
    tapeIdFN.addListener(() {
      if (!tapeIdFN.hasFocus) {
        tapeIdLeave();
      }
    });
    startDateTC.addListener(() {});
  }

  @override
  void onInit() {
    endDate = DateTime(startDate.year, startDate.month + 1, 0);
    print(endDate.toString());
    formPermissions =
        Utils.fetchPermissions1(Routes.TAPE_I_D_CAMPAIGN.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  clearPage() {
    locationChannelManager = null;
    historyManager = null;
    tapeIDTC.clear();
    history = null;
    startDateTC.clear();
    lastLocationChannelEditIdx = 0;
    historyEditIdx = 0;
    endDateTC.clear();
    // activityMonth.obs = "";
    loadModel = null;
    tapeIdFN.requestFocus();
    updateUI();
  }

  updateUI() {
    selectedTab.refresh();
    update([selectedValuUI]);
  }

  generateActivityMonth() {
    if (startDateTC.text.contains("-")) {
      var tempSplit = startDateTC.text.split("-");
      activityMonth.value = "${tempSplit[2]}${tempSplit[1]}";
    }
  }

  tapeIdLeave() {
    if (tapeIDTC.text.trim().isNotEmpty) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.TAPE_ID_CAMPAIGN_ON_LEAVE(tapeIDTC.text.trim()),
        fun: (resp) {
          Get.back();
          if (resp is Map<String, dynamic> && resp['tapeIdDetails'] != null) {
            loadModel = TapeIDCampaignLoadModel.fromJson(resp);
            // activityMonth = DateFormat("yyyyMM").format(DateTime.now());
            generateActivityMonth();
            if (loadModel?.tapeIdDetails.agencyName == null) {
              loadModel = null;
              LoadingDialog.showErrorDialog("Tape id not found.");
            } else {
              if (selectedTab.value == 0) {
                updateUI();
              }
              getHistory();
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
    } else if (loadModel?.tapeIdDetails.locationLst
            ?.any((e) => e.selectRow ?? false) ??
        false) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.TAPE_ID_CAMPAIGN_SAVE_RECORD,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['saveTape'] != null) {
            if (!(resp['saveTape']['isError'] as bool)) {
              LoadingDialog.callDataSaved(
                msg: resp['saveTape']['genericMessage'].toString(),
                callback: () {
                  clearPage();
                },
              );
            } else {
              LoadingDialog.callDataSaved(
                msg: resp['saveTape']['errorMessage'].toString(),
                callback: () {
                  clearPage();
                },
              );
            }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: {
          "exportTapeCode": tapeIDTC.text,
          "brandCode": loadModel?.tapeIdDetails.brandCode,
          "activityMonth": activityMonth.value,
          "tapeSaveLst": loadModel?.tapeIdDetails.locationLst
                  ?.where((element) => element.selectRow ?? false)
                  .toList()
                  .map((e) => e.toJson(fromSave: true))
                  .toList() ??
              [],
        },
      );
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.TAPE_ID_CAMPAIGN_UPDATE_HISTORY,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['tapeIdHistoryUpdate'] != null) {
            if (!(resp['tapeIdHistoryUpdate']['isError'] as bool)) {
              LoadingDialog.callDataSaved(
                  msg:
                      resp['tapeIdHistoryUpdate']['genericMessage'].toString());
            } else {
              LoadingDialog.showErrorDialog(
                  resp['tapeIdHistoryUpdate']['errorMessage'].toString());
            }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: history?.historyDetails
            .map((e) => e.toJson(fromSave: true))
            .toList(),
      );
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Save") {
      saveRecord();
    } else if (btn == "Exit") {
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [historyManager, locationChannelManager],
          tableNamesList: ['tbl1', 'tbl2']);
    } else if (btn == "Search") {
      Get.to(SearchPage(
          key: Key("Tape ID Campaign"),
          screenName: "Tape ID Campaign",
          appBarName: "Tape ID Campaign",
          strViewName: "BMS_vListTapeIDCampaign",
          isAppBarReq: true));
    }
  }
}
