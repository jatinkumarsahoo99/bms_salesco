import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class MarkROsFlagController extends GetxController {
  var effectiveDateTC = TextEditingController(),
      weekDaysTC = TextEditingController(),
      dialogCounter = TextEditingController(text: "0"),
      counterTC = TextEditingController(text: "0");
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel, selectedProgram;
  var locationFN = FocusNode();
  List<PermissionModel>? formPermissions;
  PlutoGridStateManager? stateManager;
  int lastSelectedIdx = 0;
  var dataTableList = [].obs;
  // var count = 0.obs;
  var bottomControllsEnable = true.obs;
  var buttonsList = ["Save Today", "Save All Days"];
  var programs = <DropDownValue>[].obs;
  bool madeChanges = false;

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.MAKE_GOOD_REPORT.replaceAll("/", ""));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  saveSpecial(String fromDate, String toDate, String fromTime, String toTime, List<bool> weekdays, String updateType) {
    if (fromDate == toDate) {
      LoadingDialog.showErrorDialog("Special to Date cannot be less than Special From Date.");
    }
    //  else if ((Utils.convertToSecond(value: toTime) - Utils.convertToSecond(value: fromTime)) <= 0) {
    //   LoadingDialog.showErrorDialog("Please enter Duration.");
    // }
    else if ((num.tryParse(dialogCounter.text) ?? 0) <= 0) {
      LoadingDialog.showErrorDialog("Please enter Duration.");
    }
    // else if (selectedProgram == null) {
    //   LoadingDialog.showErrorDialog("Please select Program.");
    // }
    else if (updateType.isEmpty) {
      LoadingDialog.showErrorDialog("Select Default or Add or Fixed for update.");
    } else {
      int upType = 0;
      if (updateType == "Default") {
        upType = 0;
      } else if (updateType == "Add") {
        upType = 1;
      } else if (updateType == "Fixed") {
        upType = 2;
      }
      // LoadingDialog.call();
      // Get.find<ConnectorControl>().POSTMETHOD(
      //   api: ApiFactory.MANAGE_CHANNEL_INV_SAVE_SPECIAL,
      //   fun: (resp) {
      //     Get.back();
      //     if (resp != null && resp is Map<String, dynamic> && resp['isError'] != null && !(resp['isError'] as bool)) {
      //       LoadingDialog.callDataSaved(
      //         msg: resp['genericMessage'].toString(),
      //         callback: () {
      //           Get.back();
      //           Get.back();
      //           closeDialogIfOpen();
      //           handleGenerateButton();
      //         },
      //       );
      //     } else {
      //       LoadingDialog.showErrorDialog(resp.toString());
      //     }
      //   },
      //   json: {
      //     "updateType": upType,
      //     "locationcode": selectedLocation?.key ?? "",
      //     "channelcode": selectedChannel?.key ?? "",
      //     "duration": (num.tryParse(dialogCounter.text) ?? 0),
      //     "fromDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(fromDate)),
      //     "toDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(toDate)),
      //     "fromTime": fromTime,
      //     "toTime": toTime,
      //     "programCode": selectedProgram?.key ?? "",
      //     "sun": weekdays[1] ? 1 : 0,
      //     "mon": weekdays[2] ? 1 : 0,
      //     "tue": weekdays[3] ? 1 : 0,
      //     "wed": weekdays[4] ? 1 : 0,
      //     "thu": weekdays[5] ? 1 : 0,
      //     "fri": weekdays[6] ? 1 : 0,
      //     "sat": weekdays[7] ? 1 : 0,
      //   },
      // );
    }
  }

  getPrograms(String from, String to, String weekDays) {
    // LoadingDialog.call();
    // Get.find<ConnectorControl>().POSTMETHOD(
    //   api: ApiFactory.MANAGE_CHANNEL_INV_PROGRAM_SEARCH,
    //   fun: (resp) {
    //     closeDialogIfOpen();
    //     if (resp != null && resp is List<dynamic>) {
    //       programs.clear();
    //       programs.addAll((resp).map((e) => DropDownValue(key: e['programcode'].toString(), value: e['programname'].toString())).toList());
    //     }
    //   },
    //   json: {
    //     "locationcode": selectedLocation?.key,
    //     "channelcode": selectedChannel?.key,
    //     "fromDate": DateFormat("dd-MMM-yyyy").format(DateFormat("dd-MM-yyyy").parse(from)),
    //     "toDate": DateFormat("dd-MMM-yyyy").format(DateFormat("dd-MM-yyyy").parse(to)),
    //     "daysInCommaSep": weekDays,
    //   },
    // );
  }

  handleOnDefaultClick() {
    if ((num.tryParse(counterTC.text) ?? 0) <= 0) {
      LoadingDialog.showErrorDialog("Enter commercial duration.");
    } else if (dataTableList.isNotEmpty) {
      madeChanges = true;
      for (var i = 0; i < dataTableList.length; i++) {
        if (dataTableList[i].episodeDuration != null) {
          dataTableList[i].commDuration = (dataTableList[i].episodeDuration ?? 0) * (num.tryParse(counterTC.text) ?? 0) / 30;
        }
      }
      dataTableList.refresh();
    }
  }

  void saveTodayAndAllData(bool fromSaveToday) {
    if (selectedLocation == null || selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select Location,Channel.");
    } else if (!madeChanges) {
      LoadingDialog.showErrorDialog("No changes to save");
    } else {
      stateManager!.setCurrentCell(stateManager!.getRowByIdx(lastSelectedIdx)?.cells['telecastDate'], lastSelectedIdx);
      // LoadingDialog.call();
      // Get.find<ConnectorControl>().POSTMETHOD(
      //   api: ApiFactory.MANAGE_CHANNEL_INV_SAVE_TODAY_ALL_DATA,
      //   fun: (resp) {
      //     closeDialogIfOpen();
      //     // LoadingDialog.callDataSaved(msg: resp.toString());
      //     if (resp != null && resp is Map<String, dynamic> && resp['isError'] != null && !(resp['isError'] as bool)) {
      //       LoadingDialog.callDataSaved(
      //         msg: resp['genericMessage'].toString(),
      //         callback: () {
      //           Get.back();
      //           closeDialogIfOpen();
      //           handleGenerateButton();
      //         },
      //       );
      //     } else {
      //       LoadingDialog.showErrorDialog(resp.toString());
      //     }
      //   },
      //   json: {
      //     "locationCode": selectedLocation?.key,
      //     "channelCode": selectedChannel?.key,
      //     "effectiveDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(effectiveDateTC.text)),
      //     "loginCode": Get.find<MainController>().user?.logincode ?? "",
      //     "allDays": fromSaveToday ? "N" : "Y",
      //     "saveTodayDataRequest": dataTableList.value.map((e) => e.toJson(fromSave: true)).toList(),
      //   },
      // );
    }
  }

  clearPage() {
    lastSelectedIdx = 0;
    stateManager = null;
    selectedProgram = null;
    dataTableList.clear();
    effectiveDateTC.clear();
    weekDaysTC.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
    programs.clear();
    // count.value = 0;
    dialogCounter.text = "0";
    counterTC.text = "0";
    madeChanges = false;
  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      // closeDialogIfOpen();
      // LoadingDialog.call();
      // Get.find<ConnectorControl>().GETMETHODCALL(
      //   api: ApiFactory.MANAGE_CHANNEL_INV_LEAVE_LOCATION(val.key.toString(), Get.find<MainController>().user?.logincode ?? ""),
      //   fun: (resp) {
      //     closeDialogIfOpen();
      //     if (resp != null && resp is List<dynamic>) {
      //       channelList.clear();
      //       selectedChannel = null;
      //       channelList.addAll((resp)
      //           .map((e) => DropDownValue(
      //                 key: e['channelCode'].toString(),
      //                 value: e['channelName'].toString(),
      //               ))
      //           .toList());
      //     } else {
      //       LoadingDialog.showErrorDialog(resp.toString());
      //     }
      //   },
      //   failed: (resp) {
      //     closeDialogIfOpen();
      //     LoadingDialog.showErrorDialog(resp.toString());
      //   },
      // );
    }
  }

  getOnLoadData() {
    // Get.find<ConnectorControl>().GETMETHODCALL(
    //     api: ApiFactory.MANAGE_CHANNEL_INV_ON_LOAD,
    //     fun: (resp) {
    //       closeDialogIfOpen();
    //       if (resp != null && resp is List<dynamic>) {
    //         locationList.value.addAll((resp)
    //             .map((e) => DropDownValue(
    //                   key: e['locationCode'].toString(),
    //                   value: e['locationName'].toString(),
    //                 ))
    //             .toList());
    //         if (locationList.isNotEmpty) {
    //           selectedLocation = locationList.first;
    //           locationList.refresh();
    //         }
    //       } else {
    //         LoadingDialog.showErrorDialog(resp.toString());
    //       }
    //     },
    //     failed: (resp) {
    //       closeDialogIfOpen();
    //       LoadingDialog.showErrorDialog(resp.toString());
    //     });
  }

  void handleGenerateButton() {
    if (selectedLocation == null || selectedChannel == null) {
      LoadingDialog.showErrorDialog("select location and channel first.");
    } else {
      //   LoadingDialog.call();
      //   Get.find<ConnectorControl>().GETMETHODCALL(
      //       api: ApiFactory.MANAGE_CHANNEL_INV_DISPLAY_DATA(selectedLocation?.key ?? "", selectedChannel?.key ?? "",
      //           DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(effectiveDateTC.text))),
      //       fun: (resp) {
      //         closeDialogIfOpen();
      //         madeChanges = false;
      //         if (resp != null && resp is List<dynamic>) {
      //           dataTableList.clear();
      //           dataTableList.addAll((resp).map((e) => ManageChannelInventory.fromJson(e)).toList());
      //         } else {
      //           LoadingDialog.showErrorDialog(resp.toString());
      //         }
      //       },
      //       failed: (resp) {
      //         closeDialogIfOpen();
      //         LoadingDialog.showErrorDialog(resp.toString());
      //       });
      // }
    }

    closeDialogIfOpen() {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }

    formHandler(btn) {
      if (btn == "Clear") {
        clearPage();
      } else if (btn == "Save") {}
    }
  }

  handleBottonButtonsTap(String buttonsList) {}

  formHandler(btn) {}
}