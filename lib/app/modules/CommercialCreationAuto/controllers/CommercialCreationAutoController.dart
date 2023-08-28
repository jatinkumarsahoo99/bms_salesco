import 'dart:convert';

import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../ComercialAutoLoadModel.dart';

class CommercialCreationAutoController extends GetxController {
  PlutoGridStateManager? stateManager;
  Rxn<ComercialAutoLoadModel>? loadModel = Rxn<ComercialAutoLoadModel>(null);
  Map<String, double> userGridSetting = {};
  List<Map<String, double>>? userGridSetting1 = [];

  @override
  void onInit() {
    fetchUserSetting1();
    // fetchUserSetting();
    getLoad();
    super.onInit();
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_GET_LOAD(),
        fun: (Map map) {
          loadModel?.value =
              ComercialAutoLoadModel.fromJson(map as Map<String, dynamic>);
          update(["listUpdate"]);
        });
  }

  getProviederSelect(String selectProvider) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_PROVIDER_LIST(selectProvider),
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

  fetchUserSetting() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.FETCH_USER_SETTING +
            "?formName=${Get.find<MainController>().formName}",
        fun: (map) {
          print("Data is>>" + jsonEncode(map));
          if (map is Map &&
              map.containsKey("userSetting") &&
              map["userSetting"] != null) {
            jsonDecode(map["userSetting"][0]["userSettings"])
                .forEach((key, value) {
              print("Data key is>>" +
                  key.toString() +
                  " value is>>>" +
                  value.toString());
              userGridSetting[key] = value;
            });
          }
        });
  }

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting();
    print("Hi Test");
  }
}
