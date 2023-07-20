import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class UpdateExecutiveController extends GetxController {
  //TODO: Implement UpdateExecutiveController

  bool isEnable = true;
  final count = 0.obs;
  var clientDetails = RxList<DropDownValue>();
  DropDownValue? selectedClientDetails;
  DropDownValue? selectedClient;
  DropDownValue? selectedProduct;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  @override
  void onInit() {
    super.onInit();
  }
  formHandler(String string){}
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
