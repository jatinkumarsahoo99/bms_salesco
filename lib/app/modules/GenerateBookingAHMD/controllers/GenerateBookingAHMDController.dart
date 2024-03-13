import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/user_data_settings_model.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';

class GenerateBookingAHMDController extends GetxController {
  final count = 0.obs;
  var channels = RxList<MultiCheckBoxModel>();
  List<DropDownValue>? location;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  TextEditingController frmDt = TextEditingController();
  TextEditingController toDt = TextEditingController();

  List<dynamic>? dataList;

  UserDataSettings? userDataSettings;
  PlutoGridStateManager? gridStateManager;

  @override
  void onInit() {
    fetchUserGridSetting();
    getInit();
    super.onInit();
    print("Called initialise");
  }

  fetchUserGridSetting() async {
    userDataSettings = await Get.find<HomeController>()
        .fetchUserSetting2(formName: "frmGenerateBookingReport");
  }

  getInit() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.GENERATE_BOOKING_REPORT_INIT,
        fun: (map) {
          // Get.back();
          location = [];
          if (map is Map &&
              map.containsKey("location") &&
              map["location"] != null) {
            // location = [];
            map["location"].forEach((e) {
              location?.add(new DropDownValue(
                  key: e["locationCode"], value: e["locationName"]));
            });
          }
          update(["init"]);
        });
  }

  getChannel() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.GENERATE_BOOKING_CHANNEL_LEAVE +
            (selectedLocation?.key ?? ''),
        fun: (map) {
          // Get.back();
          channels.value = [];
          if (map is Map &&
              map.containsKey("channel") &&
              map["channel"] != null) {
            // location = [];
            int i = -1;
            map["channel"].forEach((e) {
              channels.value.add(new MultiCheckBoxModel(
                  new DropDownValue(
                      key: e["channelCode"], value: e["channelName"]),
                  false,
                  ++i));
            });
            update(["init"]);
          }
        });
  }

  void showApiCall() {
    LoadingDialog.call();
    var jsonData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": channels
          .where((p0) => (p0.isSelected ?? false))
          .map((e) => e.val?.key)
          .join(","),
      "scheduleFromDate":
      Utils.dateFormatChange(frmDt.text, "dd-MM-yyyy", "yyyy-MM-dd"),
      "scheduleToDate":
      Utils.dateFormatChange(toDt.text, "dd-MM-yyyy", "yyyy-MM-dd")
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.GENERATE_BOOKING_GET_DETAILS,
        fun: (map) {
          Get.back();
          dataList=null;
          if (map is Map &&
              map.containsKey("retrieve") &&
              map["retrieve"] != null) {
            dataList = map["retrieve"];
          }
          update(["grid"]);
        },
        json: jsonData);
  }
}
