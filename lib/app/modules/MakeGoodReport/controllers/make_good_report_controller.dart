import 'package:bms_salesco/app/modules/MakeGoodReport/model/make_good_report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class MakeGoodReportController extends GetxController {
  var fromDateTC = TextEditingController(), toDateTC = TextEditingController();
  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      clientList = <DropDownValue>[].obs,
      agencyList = <DropDownValue>[].obs,
      brandList = <DropDownValue>[].obs;
  DropDownValue? selectedLocation, selectedChannel, selectedClient, selectedAgency, selectedBrand;
  var locationFN = FocusNode(), clientFN = FocusNode();
  List<PermissionModel>? formPermissions;
  var dataTableList = <dynamic>[].obs;
  var controllsEnable = true.obs;
  PlutoGridStateManager? stateManager;
  Rxn<List<Map<String,Map<String, double>>>>? userGridSetting1 = Rxn<List<Map<String,Map<String, double>>>>(null);

  fetchUserSetting1() async {
    userGridSetting1?.value = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.MAKE_GOOD_REPORT.replaceAll("/", ""));
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  getClient() {
    if (selectedLocation != null && selectedChannel != null) {
      clientFN.requestFocus();
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MAKE_GOOD_REPORT_GET_CLIENT(
          Uri.encodeQueryComponent(selectedLocation?.value ?? ""),
          Uri.encodeQueryComponent(selectedChannel?.value ?? ""),
          Utils.getRequiredFormatDateInString(fromDateTC.text, "yyyy-MM-dd"),
          Utils.getRequiredFormatDateInString(toDateTC.text, "yyyy-MM-dd"),
        ),
        fun: (resp2) {
          Get.back();
          if (resp2 != null && resp2 is Map<String, dynamic> && resp2['clients'] != null && resp2['clients'] is List<dynamic>) {
            clientList.clear();
            clientList.value.addAll(
              (resp2['clients'] as List<dynamic>)
                  .map((e) => DropDownValue(
                        key: e['clientCode'].toString(),
                        value: e['clientName'].toString(),
                      ))
                  .toList(),
            );
          } else {
            LoadingDialog.showErrorDialog(resp2.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getAgency() {
    if (selectedLocation != null && selectedChannel != null && selectedClient != null) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MAKE_GOOD_REPORT_GET_AGENCY(
          Uri.encodeQueryComponent(selectedLocation?.value ?? ""),
          Uri.encodeQueryComponent(selectedChannel?.value ?? ""),
          Uri.encodeQueryComponent(selectedClient?.value ?? ""),
        ),
        fun: (resp2) {
          Get.back();
          if (resp2 != null && resp2 is Map<String, dynamic> && resp2['agency'] != null && resp2['agency'] is List<dynamic>) {
            agencyList.clear();
            agencyList.value.addAll(
              (resp2['agency'] as List<dynamic>)
                  .map((e) => DropDownValue(
                        key: e['agencycode'].toString(),
                        value: e['agencyname'].toString(),
                      ))
                  .toList(),
            );
          } else {
            LoadingDialog.showErrorDialog(resp2.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getBrand() {
    if (selectedLocation != null && selectedChannel != null && selectedClient != null && selectedAgency != null) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.MAKE_GOOD_REPORT_GET_BRAND,
        fun: (resp2) {
          Get.back();
          if (resp2 != null && resp2 is Map<String, dynamic> && resp2['brand'] != null && resp2['brand'] is List<dynamic>) {
            brandList.clear();
            brandList.value.addAll(
              (resp2['brand'] as List<dynamic>)
                  .map((e) => DropDownValue(
                        key: e['brandCode'].toString(),
                        value: e['brandName'].toString(),
                      ))
                  .toList(),
            );
          } else {
            LoadingDialog.showErrorDialog(resp2.toString());
          }
        },
        json: {
          "locationName": selectedLocation?.value ?? "",
          "channelName": selectedChannel?.value ?? "",
          "fromdate": Utils.getRequiredFormatDateInString(fromDateTC.text, "yyyy-MM-dd"),
          "todate": Utils.getRequiredFormatDateInString(toDateTC.text, "yyyy-MM-dd"),
          "clientName": selectedClient?.value,
          "agencyName": selectedAgency?.value,
        },
      );
    }
  }

  clearPage() {
    selectedLocation = null;
    selectedChannel = null;
    selectedAgency = null;
    selectedClient = null;
    selectedBrand = null;
    brandList.refresh();
    agencyList.refresh();
    clientList.refresh();
    locationList.refresh();
    channelList.refresh();
    dataTableList.clear();
    locationFN.requestFocus();
    dataTableList.clear();
    fromDateTC.clear();
    toDateTC.clear();
    controllsEnable.value = true;
  }

  getOnLoadData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.MAKE_GOOD_REPORT_GET_LOCATION,
        fun: (resp) {
          if (resp != null && resp is Map<String, dynamic> && resp['location'] != null && resp['location'] is List<dynamic>) {
            locationList.clear();
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
            Get.find<ConnectorControl>().GETMETHODCALL(
              api: ApiFactory.MAKE_GOOD_REPORT_GET_CHANNEL,
              fun: (resp2) {
                Get.back();
                if (resp2 != null && resp2 is Map<String, dynamic> && resp2['channel'] != null && resp2['channel'] is List<dynamic>) {
                  channelList.clear();
                  channelList.value.addAll((resp2['channel'] as List<dynamic>)
                      .map((e) => DropDownValue(
                            key: e['channelcode'].toString(),
                            value: e['channelname'].toString(),
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

  generateReport() {
    if (selectedLocation != null && selectedChannel != null && selectedClient != null && selectedAgency != null && selectedBrand != null) {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.MAKE_GOOD_REPORT_GET_GENERATE,
        fun: (resp2) {
          Get.back();
          if (resp2 != null &&
              resp2 is Map<String, dynamic> &&
              resp2['generate'] != null &&
              ((resp2['generate']['generateAllClient'] is List<dynamic>) || (resp2['generate']['generateSpecificReport'] is List<dynamic>))) {
            dataTableList.clear();
            print(controllsEnable.value);
            if (!controllsEnable.value) {
              // dataTableList.value = (resp2['generate']['generateAllClient'] as List<dynamic>).map((e) => MakeGoodReportModel.fromJson(e)).toList();
              dataTableList.value = (resp2['generate']['generateAllClient'] as List<dynamic>);
            } else {
              dataTableList.value =
                  // (resp2['generate']['generateSpecificReport'] as List<dynamic>).map((e) => MakeGoodReportModel.fromJson(e)).toList();
                  (resp2['generate']['generateSpecificReport'] as List<dynamic>);
            }
            // print(dataTableList.value);
          } else {
            LoadingDialog.showErrorDialog(resp2.toString());
          }
        },
        json: {
          "locationName": selectedLocation?.value ?? "",
          "channelName": selectedChannel?.value ?? "",
          "fromDate": Utils.getRequiredFormatDateInString(fromDateTC.text, "yyyy-MM-dd"),
          "toDate": Utils.getRequiredFormatDateInString(toDateTC.text, "yyyy-MM-dd"),
          "clientName": selectedClient?.value,
          "agencyName": selectedAgency?.value,
          "brandName": selectedBrand?.value,
          "isAllClient": !controllsEnable.value,
        },
      );
    }
  }

  formHandler(btn) {
    if (btn == "Clear") {
      clearPage();
    } if(btn == "Exit"){
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager,
          ]);
    }
  }
}
