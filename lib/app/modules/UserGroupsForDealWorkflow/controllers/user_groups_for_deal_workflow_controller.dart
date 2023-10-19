import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
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
  DisPlayGroupModel? disPlayGroupModel =
      DisPlayGroupModel(displayGroup: DisplayGroup(employees: []));



  TextEditingController groupTextController = new TextEditingController();
  FocusNode groupNode = FocusNode();
  bool isListenerActive = false;

  void addBtnClick() {
    if (selectedEmployee == null) {
      LoadingDialog.showErrorDialog("Please select employee");
    } else {
      print(">>>>>>>>>>>>>>add click");
      if(disPlayGroupModel?.displayGroup?.employees != null &&
          (disPlayGroupModel?.displayGroup?.employees?.length??0) >0 ){
        disPlayGroupModel?.displayGroup?.employees?.add( Employees(
            employees: selectedEmployee?.value,
            personnelno: selectedEmployee?.key));
      }else{
        disPlayGroupModel =   DisPlayGroupModel(displayGroup: DisplayGroup(employees: [Employees(
            employees: selectedEmployee?.value,
            personnelno: selectedEmployee?.key)]));
      }


      print(">>>>>>>>>>>>data"+(disPlayGroupModel?.toJson()).toString());
      update(['grid']);
    }
  }

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
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

  getDisPlay(String text) {
    LoadingDialog.call();
    isListenerActive = false;
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.USER_GROUPS_FOR_DEAL_WORKFLOW_GET_DISPLAY_GROUP + text,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          isListenerActive = false;
          disPlayGroupModel =
              DisPlayGroupModel(displayGroup: DisplayGroup(employees: []));
          if (map is Map &&
              map.containsKey("displayGroup") &&
              map['displayGroup'] != null &&
              map['displayGroup'].length > 0) {
            disPlayGroupModel =
                DisPlayGroupModel.fromJson(map as Map<String, dynamic>);
            update(['grid']);
          } else {
            disPlayGroupModel =
                DisPlayGroupModel(displayGroup: DisplayGroup(employees: []));
            update(['grid']);
          }
        });
  }

  @override
  void onInit() {
    groupNode.addListener(() {
      if (!groupNode.hasFocus && isListenerActive) {
        getDisPlay(groupTextController.text);
      }
      if (groupNode.hasFocus) {
        isListenerActive = true;
      }
    });
    fetchUserSetting1();
    super.onInit();
  }

  saveDealWorkFlow() {
    if ((disPlayGroupModel?.displayGroup?.employees?.length ?? 0) == 0) {
      LoadingDialog.showErrorDialog("Please add some employee");
    }
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "groupid": disPlayGroupModel?.displayGroup?.groupId ?? "0",
      "groupname": groupTextController.text ?? "",
      "listdt": disPlayGroupModel?.displayGroup?.employees
          ?.map((e) => e.toJson1())
          .toList()
    };
    // print(">>>>>postData>>>"+(postData).toString());
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_GROUPS_FOR_DEAL_WORKFLOW_SAVE,
        json: postData,
        fun: (map) {
          Get.back();
          print(">>>>>" + map.toString());
          if (map is Map && map.containsKey('save') && map['save'] != null) {
            LoadingDialog.callDataSavedMessage(
                map['save']['errorMessage'] ?? "",callback: (){
                  clearAll();
            });
          } else {
            LoadingDialog.showErrorDialog(
                (map ?? "Something went wrong").toString());
          }
        });
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
    if (string == "Search") {
      search();
    } else if (string == "Clear") {
      clearAll();
    } else if (string == "Save") {
      saveDealWorkFlow();
    } else if (string == "Exit") {
      Get.find<HomeController>()
          .postUserGridSetting1(listStateManager: [stateManager]);
    }
  }

  void increment() => count.value++;
}
