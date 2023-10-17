import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';

class ProgramWiseRevenueReportController extends GetxController {
  TextEditingController fromdDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  List<String> bookingTypes = [
    "Detail",
    "Summery",
  ];

  RxnString bookingType = RxnString();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var listCheckBox = [
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee-Bihar-HD"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee TV"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zing"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Marathi"), false),
    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Bojpuri"), false),
  ];
}
