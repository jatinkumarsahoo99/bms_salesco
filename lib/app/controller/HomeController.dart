import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

// import 'package:bms_programming/app/providers/ApiFactory.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../data/DrawerModel.dart';
import '../providers/Aes.dart';
import '../providers/ApiFactory.dart';
import '../routes/app_pages.dart';
import 'ConnectorControl.dart';
import 'MainController.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  SubChild? selectChild;
  var selectChild1 = Rxn<SubChild>();
  List? buttons;

  bool isMoviePlannerPopupShown = false;

  @override
  void onInit() {
    getbuttondata();
    super.onInit();
  }

  getbuttondata() async {
    String value = await rootBundle.loadString('assets/json/buttons.json');
    buttons = json.decode(value);
    update(["buttons"]);
  }

  clearPage1() {
    String extractName = (html.window.location.href.split("?")[0])
        .split(ApiFactory.SPLIT_CLEAR_PAGE)[1];
    print("Extract name>>>>" + extractName);
    var uri = Uri.dataFromString(
        html.window.location.href); //converts string to a uri
    Map<String, String> params = uri.queryParameters;
    print("Params are>>>>" + params.toString());
    if (RoutesList.listRoutes.contains("/" + extractName)) {
      if (extractName == "frmDailyFPC") {
        html.window.location.reload();
      } else {
        String personalNo =
            Aes.encrypt(Get.find<MainController>().user?.personnelNo ?? "") ??
                "";
        String loginCode =
            (Aes.encrypt(Get.find<MainController>().user?.logincode ?? "") ??
                "");
        String formName =
            (Aes.encrypt(Get.find<MainController>().formName ?? "") ?? "");
        Get.offAndToNamed("/" + extractName, parameters: {
          "loginCode": loginCode,
          "personalNo": personalNo,
          "formName": formName
        });
      }
    }
  }

  void postUserGridSetting1(
      {required List<PlutoGridStateManager?>? listStateManager,
      List<String?>? tableNamesList}) {
    if (listStateManager == null || listStateManager.isEmpty) return;

    if (tableNamesList != null && tableNamesList.isNotEmpty) {
      tableNamesList.removeWhere((element) => element == null);
    }
    if (tableNamesList != null &&
        tableNamesList.isNotEmpty &&
        (tableNamesList.length != listStateManager.length)) return;

    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      if (listStateManager[i] != null) {
        Map<String, dynamic> singleMap = {};
        listStateManager[i]?.columns.forEach((element) {
          singleMap[element.field] = element.width;
        });
        String? mapData = jsonEncode(singleMap);
        data.add({
          "formName":
              Get.find<MainController>().formName.replaceAll(" ", "") ?? "",
          "controlName":
              tableNamesList == null ? "${i + 1}_table" : tableNamesList[i],
          "userSettings": mapData
        });
      } else {
        continue;
      }
    }

    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.USER_SETTINGS,
        json: {"lstUserSettings": data},
        fun: (map) {});
  }

  Future<List<Map<String, Map<String, double>>>>? fetchUserSetting1() {
    Completer<List<Map<String, Map<String, double>>>> completer =
        Completer<List<Map<String, Map<String, double>>>>();
    List<Map<String, Map<String, double>>> data = [];
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api:
              "${ApiFactory.FETCH_USER_SETTING}?formName=${Get.find<MainController>().formName.replaceAll(" ", "")}",
          fun: (map) {
            if (map is Map &&
                map.containsKey("userSetting") &&
                map["userSetting"] != null) {
              map["userSetting"].forEach((e) {
                Map<String, Map<String, double>> userGridSettingMain = {};
                Map<String, double> userGridSetting = {};
                jsonDecode(e["userSettings"]).forEach((key, value) {
                  userGridSetting[key] = value;
                });
                userGridSettingMain[e["controlName"] ?? ""] = userGridSetting;
                // data.add(userGridSetting);
                data.add(userGridSettingMain);
              });
              completer.complete(data);
              // return data;
            } else {
              completer.complete(data);
              // return null;
            }
          });
    } catch (e) {
      completer.complete(data);
    }
    return completer.future;
  }

  Map<String, double> getGridWidthByKey(
      {String? key,
      required List<Map<String, Map<String, double>>>? userGridSettingList}) {
    Map<String, double> gridWidths = {};
    try {
      if (key != null && key != "") {
        if ((userGridSettingList?.length ?? 0) > 0) {
          for (int i = 0; i < (userGridSettingList?.length ?? 0); i++) {
            if (userGridSettingList?[i] != null) {
              if (((userGridSettingList?[i].keys.toList()) ?? [])
                  .contains(key ?? "")) {
                gridWidths =
                    userGridSettingList?[i][key] as Map<String, double>;
                break;
              } else {
                continue;
              }
            } else {
              continue;
            }
          }
          return gridWidths;
        } else {
          // print(">>>>>>>>>>>>>elsegridWidths" + gridWidths.toString());
          return gridWidths;
        }
      } else {
        if ((userGridSettingList?.length ?? 0) > 1) {

          for (int i = 0; i < (userGridSettingList?.length ?? 0); i++) {
            if (userGridSettingList?[i] != null) {
              if (((userGridSettingList?[i].keys.toList()) ?? [])
                  .contains("1_table")) {
                gridWidths =
                    userGridSettingList?[i]["1_table"] as Map<String, double>;
                break;
              } else {
                continue;
              }
            } else {
              continue;
            }
          }

          if (userGridSettingList?[0] != null && gridWidths.isEmpty) {
            gridWidths = (userGridSettingList?[0].values.first) ?? {};
          }
          // print(">>>>>>>>>>>>>ifgridWidths" + gridWidths.toString());
          return gridWidths;
        }else if((userGridSettingList?.length ?? 0) == 1){
          if (userGridSettingList?[0] != null) {
            gridWidths = (userGridSettingList?[0].values.first) ?? {};
          }
          // print(">>>>>>>>>>>>>ifgridWidths" + gridWidths.toString());
          return gridWidths;
        } else {
          return gridWidths;
        }
      }
    } catch (e) {
      print(">>>>>>>>>>>>" + e.toString());
      return gridWidths;
    }
  }

  void postUserGridSetting(
      {required List<PlutoGridStateManager> listStateManager}) {
    if (listStateManager.length > 0) return;
    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      Map<String, dynamic> singleMap = {};
      listStateManager[0].columns.forEach((element) {
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

  Future<List<Map<String, double>>>? fetchUserSetting() {
    List<Map<String, double>> data = [];
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.FETCH_USER_SETTING +
            "?formName=${Get.find<MainController>().formName}",
        fun: (map) {
          print("Data is>>" + jsonEncode(map));
          if (map is Map &&
              map.containsKey("userSetting") &&
              map["userSetting"] != null) {
            map["userSetting"].forEach((e) {
              Map<String, double> userGridSetting = {};
              jsonDecode(e["userSettings"]).forEach((key, value) {
                print("Data key is>>" +
                    key.toString() +
                    " value is>>>" +
                    value.toString());
                userGridSetting[key] = value;
              });
              data.add(userGridSetting);
            });
            return data;
          } else {
            return null;
          }
        });
  }
}
