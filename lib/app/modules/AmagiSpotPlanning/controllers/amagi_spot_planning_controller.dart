import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class AmagiSpotPlanningController extends GetxController {
  //TODO: Implement AmagiSpotPlanningController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxString selectValue=RxString("");

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  formHandler(String string) {

  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
