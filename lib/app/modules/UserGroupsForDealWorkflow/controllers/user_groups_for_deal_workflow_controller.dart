import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../CommonSearch/views/common_search_view.dart';
import '../DisPlayGroupModel.dart';

class UserGroupsForDealWorkflowController extends GetxController {
  //TODO: Implement UserGroupsForDealWorkflowController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedEmployee;
  DropDownValue? selectedChannel;
  DisPlayGroupModel? disPlayGroupModel;
  TextEditingController groupTextController = new TextEditingController();

  void addBtnClick(){

  }

  void search() {
    // Get.delete<TransformationController>();
    Get.to(SearchPage(
        key: Key("User Group For Deal WorkFlow"),
        screenName: "User Group For Deal WorkFlow",
        appBarName: "User Group For Deal WorkFlow",
        strViewName: "View_dp_usergroups",
        isAppBarReq: true));
  }
  clearAll() {
    Get.delete<UserGroupsForDealWorkflowController>();
    Get.find<HomeController>().clearPage1();
  }
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
    if(string == "Search"){
      search();
    }else if(string == "Clear"){
      clearAll();
    }
  }
  void increment() => count.value++;
}
