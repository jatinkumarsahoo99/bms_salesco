import 'dart:convert';

import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../PopulateEntityModel.dart';

class EDIMappingController extends GetxController {
  //TODO: Implement EDIMappingController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxString selectValue = RxString("Client");
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedChannel;

  var clientTempList = [].obs;
  var agencyTempList = [].obs;
  var channelTempList = [].obs;
  var isClientTemp = false.obs;
  var isAgencyTemp = false.obs;
  var isChannelTemp = false.obs;

  bool isClient = true;
  bool isAgency = false;
  bool isChannel = false;
  String radioName = "Client";

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  checkRadio(String val) {
    if (val == "Client") {
      isClient = true;
      isAgency = false;
      isChannel = false;
      selectedAgency = null;
      selectedChannel = null;
      radioName = "Client";

      callPopulateEntity();
      // update(['top']);
    } else if (val == "Agency") {
      isClient = false;
      isAgency = true;
      isChannel = false;
      selectedClient = null;
      selectedChannel = null;
      radioName = "Agency";
      callPopulateEntity();
      // update(['top']);
    } else {
      isClient = false;
      isAgency = false;
      isChannel = true;
      selectedClient = null;
      selectedAgency = null;
      radioName = "Channel";
      callPopulateEntity();
      // update(['top']);
    }
  }

  PopulateEntityModel? populateEntityModel;
  int selectedIndex = 0;

  callPopulateEntity() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "rdbClient": isClient,
      "rdbAgency": isAgency,
      "rdbChannel": isChannel
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.EDI_MAPPING_POPULATE_ENTITY,
        json: postData,
        fun: (map) {
          Get.back();
          selectedIndex = 0;
          // print(">>>>>>"+ jsonEncode(map).toString());
          if (map is Map &&
              map.containsKey("populateEntity") &&
              map['populateEntity'] != null) {
            populateEntityModel =
                PopulateEntityModel.fromJson(map as Map<String, dynamic>);
            clientTempList
                .addAll(populateEntityModel!.populateEntity!.clientMaster!);
            agencyTempList
                .addAll(populateEntityModel!.populateEntity!.agencyMaster!);
            clientTempList.refresh();
            agencyTempList.refresh();
            update(['top']);
          } else {
            update(['top']);
            populateEntityModel = null;
          }
        });
  }

  callPopulateEntityOnLoad() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "rdbClient": isClient,
      "rdbAgency": isAgency,
      "rdbChannel": isChannel
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.EDI_MAPPING_POPULATE_ENTITY,
        json: postData,
        fun: (map) {
          Get.back();
          print(">>>>>>" + jsonEncode(map).toString());
          if (map is Map &&
              map.containsKey("populateEntity") &&
              map['populateEntity'] != null) {
            populateEntityModel =
                PopulateEntityModel.fromJson(map as Map<String, dynamic>);
            clientTempList
                .addAll(populateEntityModel!.populateEntity!.clientMaster!);
            agencyTempList
                .addAll(populateEntityModel!.populateEntity!.agencyMaster!);
            print("============");
            print(agencyTempList);
            update(['grid']);
          } else {
            update(['grid']);
            populateEntityModel = null;
          }
        });
  }

  save() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {};
    if (selectValue.value == "Client") {
      postData = {
        "entityName": selectValue.value,
        "bmsclientcode": selectedClient!.key,
        "softclient": isClientTemp.value
            ? clientTempList[selectedIndex].toString() ?? ""
            : clientTempList[selectedIndex].softClient.toString() ?? "",
      };
    } else if (selectValue.value == "Agency") {
      postData = {
        "entityName": selectValue.value,
        "bmsclientcode": selectedAgency!.key,
        "softclient": isAgencyTemp.value
            ? agencyTempList[selectedIndex].toString() ?? ""
            : agencyTempList[selectedIndex].softAgency.toString() ?? "",
      };
    } else {
      postData = {
        "entityName": selectValue.value,
        "bmsclientcode": selectedChannel!.key,
        "softclient": populateEntityModel
                ?.populateEntity?.channelMaster?[selectedIndex].SoftChannel ??
            "",
      };
    }

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EDI_MAPPING_UPDATE_SOFT_CLIENT,
        json: postData,
        fun: (map) {
          Get.back();
          if (map != null) {
            LoadingDialog.callDataSaved(
                msg: map['save'],
                callback: () {
                  clear();
                });
          }
        });
  }

  clear() {
    isClientTemp.value = false;
    isAgencyTemp.value = false;
    selectValue.value = "Client";
    selectedClient = null;
    selectedAgency = null;
    selectedChannel = null;
    clientTempList.clear();
    agencyTempList.clear();
    checkRadio("Client");
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    callPopulateEntityOnLoad();
  }

  @override
  void onClose() {
    super.onClose();
  }

  formHandler(String string) {
    if (string == "Clear") {
      clear();
      // Get.delete<EDIMappingController>();
      // Get.find<HomeController>().clearPage1();
    } else if (string == "Save") {
      save();
    }
  }

  void increment() => count.value++;
}
