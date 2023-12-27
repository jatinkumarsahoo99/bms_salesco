import 'dart:convert';

import 'package:bms_salesco/app/modules/CommercialMasterAutoId/ComercialMasterAutoIdLoadModel.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../providers/ApiFactory.dart';

class CommercialMasterAutoIdController extends GetxController {
  //TODO: Implement CommercialMasterAutoIdController

  final count = 0.obs;

  PlutoGridStateManager? stateManager;
  Rxn<ComercialMasterAutoIdLoadModel>? loadModel = Rxn<ComercialMasterAutoIdLoadModel>(null);
  List<Map<String,Map<String, double>>>? userGridSetting1;

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  void postUserSetting1(
      {required List<PlutoGridStateManager> listStateManager}) {
    if (listStateManager == null || listStateManager.length > 0) return;
    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      Map<String, dynamic> singleMap = {};
      stateManager?.columns.forEach((element) {
        singleMap[element.field] = element.width;
      });
      String? mapData = jsonEncode(singleMap);
      data.add({
        "formName": Get.find<MainController>().formName ?? "",
        "controlName": (i + 1).toString() + "_table",
        "userSettings": mapData
      });
    }
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_SETTINGS,
        json: {"lstUserSettings": data},
        fun: (map) {});
  }

  postUserSetting() {
    if (stateManager == null) return;
    Map<String, dynamic> singleMap = {};
    stateManager?.columns.forEach((element) {
      singleMap[element.field] = element.width;
    });
    String? mapData = jsonEncode(singleMap);
    // Map<String, dynamic>? mapDataResult = jsonDecode(mapData);

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_SETTINGS,
        json: {
          "lstUserSettings": [
            {
              "formName": Get.find<MainController>().formName ?? "",
              "controlName": "1ST Table",
              "userSettings": mapData
            }
          ]
        },
        fun: (map) {});
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_GET_LOAD(),
        fun: (Map map) {
          loadModel?.value =
              ComercialMasterAutoIdLoadModel.fromJson(map as Map<String, dynamic>);
          update(["listUpdate"]);
        });
  }

  getProviederSelect(String selectProvider) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_PROVIDER_LIST(selectProvider),
        fun: (map) {
          Get.back();
          // print("COMMERCIAL_CREATION_PROVIDER_LIST=>>>" + jsonEncode(map));
          if (map is Map && map.containsKey("newMedia")) {
            if (loadModel?.value != null) {
              // loadModel?.value?.loadData.l
              if (map['newMedia'] != null) {
                List<LstNewMedia> lstNewMedia = <LstNewMedia>[];
                map['newMedia'].forEach((v) {
                  lstNewMedia!.add(new LstNewMedia.fromJson(v));
                });
                loadModel?.value?.loadData?.lstNewMedia = lstNewMedia;
                update(["listUpdate"]);
              }
            }
          }
        });
  }

  @override
  void onInit() {
    fetchUserSetting1();
    getLoad();
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

  void increment() => count.value++;
}
