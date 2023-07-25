import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../AsrunDetailsReport/ChannelListModel.dart';

class AmagiSpotsReplacementController extends GetxController {
  //TODO: Implement AmagiSpotsReplacementController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  // RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  List<ChannelListModel> channelList = [];
  RxBool checked = RxBool(false);

  TextEditingController frmDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
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

  clearAll(){
    Get.delete<AmagiSpotsReplacementController>();
    Get.find<HomeController>().clearPage1();
  }
  formHandler(String string) {
    if (string == "Clear") {
      clearAll();
    }
  }
  void increment() => count.value++;
}
