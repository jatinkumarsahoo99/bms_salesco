import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class DealvsRODataReportController extends GetxController {
  TextEditingController fromdDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  var locations = RxList<DropDownValue>();

  List<String> dataTypes = [
    "Dealwise",
    "ROWise",
    "DealvsRO",
  ];

  var currentType = "Dealwise".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getLocations();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLocations() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_VS_RO_DATA_REPORT_DATAINITIAL,
        fun: (Map map) {
          locations.clear();
          map["location"].forEach((e) {
            locations.add(DropDownValue.fromJson1(e));
          });
        });
  }
}
