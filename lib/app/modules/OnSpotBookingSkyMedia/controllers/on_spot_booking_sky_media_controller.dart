import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class OnSpotBookingSkyMediaController extends GetxController {
  //TODO: Implement OnSpotBookingSkyMediaController

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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  formHandler(String string){}
  void increment() => count.value++;
}
