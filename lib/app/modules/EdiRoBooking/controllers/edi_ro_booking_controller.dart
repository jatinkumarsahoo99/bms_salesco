import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class EdiRoBookingController extends GetxController {
  //TODO: Implement EdiRoBookingController

  final count = 0.obs;
  EdiRoInitData? initData;
  // Selected DropDownValues
  DropDownValue? selectedFile;
  DropDownValue? selectedPromo;
  TextEditingController effectiveDate = TextEditingController();

  PlutoGridStateManager? stateManager;
  List<Map<String,Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    getInitData();
    fetchUserSetting1();
    super.onInit();
  }

  getInitData() {
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_INIT,
          fun: (rawdata) {
            initData = EdiRoInitData.fromJson(rawdata["onLoadInfo"]);
            update(["initData"]);
          });
    } catch (e) {
      print(e.toString());
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  effectiveDateLeave() {
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_FILE_LEAVE(selectedFile?.key, DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(effectiveDate.text))),
          fun: (rawdata) {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
