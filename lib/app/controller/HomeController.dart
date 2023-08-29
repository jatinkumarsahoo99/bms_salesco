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
    String extractName = (html.window.location.href.split("?")[0]).split(ApiFactory.SPLIT_CLEAR_PAGE)[1];
    print("Extract name>>>>" + extractName);
    var uri = Uri.dataFromString(html.window.location.href); //converts string to a uri
    Map<String, String> params = uri.queryParameters;
    print("Params are>>>>" + params.toString());
    if (RoutesList.listRoutes.contains("/" + extractName)) {
      if (extractName == "frmDailyFPC") {
        html.window.location.reload();
      } else {
        String personalNo = Aes.encrypt(Get.find<MainController>().user?.personnelNo ?? "") ?? "";
        String loginCode = (Aes.encrypt(Get.find<MainController>().user?.logincode ?? "") ?? "");
        String formName = (Aes.encrypt(Get.find<MainController>().formName ?? "") ?? "");
        Get.offAndToNamed("/" + extractName, parameters: {"loginCode": loginCode, "personalNo": personalNo, "formName": formName});
      }
    }
  }

  void postUserGridSetting(
      {required List<PlutoGridStateManager> listStateManager}) {
    if (listStateManager == null || listStateManager.isEmpty) return;
    List data = [];
    for (int i = 0; i < listStateManager.length; i++) {
      Map<String, dynamic> singleMap = {};
      listStateManager[i].columns.forEach((element) {
        singleMap[element.field] = element.width;
      });
      String? mapData = jsonEncode(singleMap);
      data.add({
        "formName": Get.find<MainController>().formName.trim() ?? "",
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
    List<Map<String, double>> data=[];
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.FETCH_USER_SETTING +
            "?formName=${Get.find<MainController>().formName.trim()}",
        fun: (map) {
          print("Data is>>" + jsonEncode(map));
          if (map is Map &&
              map.containsKey("userSetting") &&
              map["userSetting"] != null) {

            map["userSetting"].forEach((e){
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
          }else{
            return null;
          }
        });
  }
}
