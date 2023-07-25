import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class ChangeRONumberController extends GetxController {
  var locationList = <DropDownValue>[].obs, channelList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel;
  var locationFN = FocusNode();
  var bookingNoCtr = TextEditingController(), bookingRefNumber = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } else if (btn == "Change") {
      updateRecord();
    }
  }

  clearPage() {
    bookingNoCtr.clear();
    bookingRefNumber.clear();
    selectedLocation = null;
    selectedChannel = null;
    locationList.refresh();
    channelList.refresh();
    locationFN.requestFocus();
  }

  updateRecord() {
    if (selectedLocation == null) {
      LoadingDialog.showErrorDialog("Please select Location");
    } else if (selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select Channel");
    } else if (bookingNoCtr.text.trim().isEmpty) {
      LoadingDialog.showErrorDialog("Please enter Booking No.");
    } else if (bookingRefNumber.text.trim().isEmpty) {
      LoadingDialog.showErrorDialog("Please enter Booking Reference No.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.CHANGE_RO_NUMBER_UPDATE_DATA,
        fun: (resp) {
          closeDialogIfOpen();
          Get.back();
          if (resp != null && resp is Map<String, dynamic> && resp['result'] != null) {
            if (!(resp['result']['isError'] as bool)) {
              LoadingDialog.callDataSaved(
                msg: resp['result']['errorMessage'].toString(),
                callback: () {
                  clearPage();
                },
              );
            } else {
              LoadingDialog.callDataSaved(
                msg: resp['result']['errorMessage'].toString(),
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
          "locationCode": selectedLocation?.key,
          "channelCode": selectedChannel?.key,
          "bookingnumber": bookingNoCtr.text.trim(),
          "referenceNumber": bookingRefNumber.text.trim(),
        },
      );
    }
  }

  handleOnChangedLocation(DropDownValue? val) {
    selectedLocation = val;
    if (val != null) {
      closeDialogIfOpen();
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.CHANGE_RO_NUMBER_ON_LEAVE_LOCATION(val.key.toString()),
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
        api: ApiFactory.CHANGE_RO_NUMBER_ON_LOAD,
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
}
