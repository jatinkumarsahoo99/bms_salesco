import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class EDIMappingController extends GetxController {
  //TODO: Implement EDIMappingController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxString selectValue=RxString("");
  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedProduct;
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
