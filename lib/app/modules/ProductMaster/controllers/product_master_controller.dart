import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class ProductMasterController extends GetxController {
  //TODO: Implement ProductMasterController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChanne;
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
  formHandler(String str){

  }
  void increment() => count.value++;
}