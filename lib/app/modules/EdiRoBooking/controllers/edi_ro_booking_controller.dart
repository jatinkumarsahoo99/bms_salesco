import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';

class EdiRoBookingController extends GetxController {
  //TODO: Implement EdiRoBookingController

  final count = 0.obs;
  EdiRoInitData? initData;
  // Selected DropDownValues
  DropDownValue? selectedPromo;
  @override
  void onInit() {
    getInitData();
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
