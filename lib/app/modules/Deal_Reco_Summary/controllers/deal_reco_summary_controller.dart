import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class DealRecoSummaryController extends GetxController {
  //TODO: Implement DealRecoSummaryController
  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
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
  formHandler(String string) {

  }

  void increment() => count.value++;
}
