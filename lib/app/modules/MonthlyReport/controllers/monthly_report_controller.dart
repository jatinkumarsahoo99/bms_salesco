import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class MonthlyReportController extends GetxController {
  var fromDateTC = TextEditingController(), toDateTC = TextEditingController();
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  List<PermissionModel>? formPermissions;
  int lastSelectedIdx = 0;
  var dataTableList = [].obs;
  var selectedRadio = "".obs;
  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1=Rxn([]);
  PlutoGridStateManager? stateManager;
  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    formPermissions =
        Utils.fetchPermissions1(Routes.MONTHLY_REPORT.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  clearPage() {
    lastSelectedIdx = 0;
    dataTableList.clear();
    fromDateTC.clear();
    toDateTC.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
  }

  getOnLoadData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MONTHLY_REPORT_GET_LOCATION,
        fun: (resp) {
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['location'] != null &&
              resp['location'] is List<dynamic>) {
            locationList.clear();
            locationList.value.addAll((resp['location'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['locationCode'].toString(),
                      value: e['locationName'].toString(),
                    ))
                .toList());
            // if (locationList.isNotEmpty) {
            //   selectedLocation = locationList.first;
            //   locationList.refresh();
            // }
            Get.find<ConnectorControl>().GETMETHODCALL(
              api: ApiFactory.MONTHLY_REPORT_GET_CHANNEL,
              fun: (resp2) {
                Get.back();
                if (resp2 != null &&
                    resp2 is Map<String, dynamic> &&
                    resp2['channel'] != null &&
                    resp2['channel'] is List<dynamic>) {
                  channelList.clear();
                  channelList.value.addAll((resp2['channel'] as List<dynamic>)
                      .map((e) => DropDownValue(
                            key: e['channelCode'].toString(),
                            value: e['channelName'].toString(),
                          ))
                      .toList());
                } else {
                  LoadingDialog.showErrorDialog(resp2.toString());
                }
              },
              failed: (resp3) {
                Get.back();
                LoadingDialog.showErrorDialog(resp3.toString());
              },
            );
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        });
  }

  void handleGenerateButton() {
    if (selectedLocation == null || selectedChannel == null) {
      LoadingDialog.showErrorDialog("select location and channel first.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.MONTHLY_REPORT_GET_DATA,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp['report'] != null &&
              resp['report']['bookingLst'] is List<dynamic>) {
            dataTableList.clear();
            if (selectedRadio.value == "Booking") {
              dataTableList.value = resp['report']['bookingLst'];
            } else if (selectedRadio.value == "Cancelation") {
              dataTableList.value = resp['report']['cancellationLsts'];
            } else if (selectedRadio.value == "Reschedule") {
              dataTableList.value = resp['report']['rescheduledLst'];
            }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        json: {
          "locationCode": selectedLocation?.key ?? "",
          "channelCode": selectedChannel?.key ?? "",
          "fromDate": Utils.getRequiredFormatDateInString(
              fromDateTC.text, "yyyy-MM-dd"),
          "toDate":
              Utils.getRequiredFormatDateInString(toDateTC.text, "yyyy-MM-dd"),
          "isBooking": selectedRadio.value == "Booking",
          "isCancellation": selectedRadio.value == "Cancelation",
          "isRescheduled": selectedRadio.value == "Reschedule",
        },
      );
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
