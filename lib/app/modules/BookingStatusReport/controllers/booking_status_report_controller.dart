import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class BookingStatusReportController extends GetxController {
  TextEditingController fromdDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  List<String> bookingTypes = [
    "Detail",
    "Summery",
  ];
  List<PermissionModel>? formPermissions;

  RxnString bookingType = RxnString();
  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(
        Routes.BOOKING_STATUS_REPORT.replaceAll("/", ""));
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

  formHandler(String btnName) {
    if (btnName == "Clear") {
      // clearPage();
    } else if (btnName == "Save") {
      // saveValidate();
    } else if (btnName == "Search") {
      // Get.to(
      //   const SearchPage(
      //     key: Key("Filler Master"),
      //     screenName: "Filler Master",
      //     appBarName: "Filler Master",
      //     strViewName: "bms_view_fillermaster",
      //     isAppBarReq: true,
      //   ),
      // );
    }
  }
}
