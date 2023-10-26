import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../CommercialLanguageModel.dart';

class CommercialLanguageSpecificationController extends GetxController {
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> tableList = RxList([]);
  double widthSize = 0.12;
  DropDownValue? selectLocation;
  DropDownValue? selectChannel;
  CommercialLanguageModel? commercialLangModel;
  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  List<PlutoRow> initialIndexRows = [];

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    getLocations();
    fetchUserSetting1();
    super.onInit();
  }

  getLocations() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_LANG_SPEC_LOCATION,
        fun: (Map map) {
          print("Loc json data is>>" + jsonEncode(map));
          locationList.clear();
          map["loadData"].forEach((e) {
            locationList.add(DropDownValue.fromJsonDynamic(
                e, "locationCode", "locationName"));
          });
          update(["updateView"]);
        });
  }

  getChannels(String key) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_LANG_SPEC_CHANNEL(
          key,
        ),
        fun: (Map map) {
          print("Chnl json data is>>" + jsonEncode(map));
          channelList.clear();
          map["lstChannel"].forEach((e) {
            channelList.add(
                DropDownValue.fromJsonDynamic(e, "channelCode", "channelName"));
          });
        });
  }

  getDisplay() {
    if (selectLocation == null) {
      LoadingDialog.callInfoMessage("Please select location");
    } else if (selectChannel == null) {
      LoadingDialog.callInfoMessage("Please select channel");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.COMMERCIAL_LANG_SPEC_DISPLAY(
              selectLocation?.key ?? "ZAZEE00001",
              selectChannel?.key ?? "ZAZEE00001"),
          fun: (Map map) {
            Get.back();
            if (map is Map &&
                map.containsKey("display") &&
                map["display"] != null) {
              commercialLangModel =
                  CommercialLanguageModel.fromJson(map as Map<String, dynamic>);
              update(["listUpdate"]);
            } else {
              LoadingDialog.callInfoMessage(map.toString());
            }
          });
    }
  }

  void save() async {
    if (selectLocation == null) {
      LoadingDialog.callInfoMessage("Please select location");
    } else if (selectChannel == null) {
      LoadingDialog.callInfoMessage("Please select channel");
    } else {
      bool? isDataOk =
          await areListsEqual1(initialIndexRows, stateManager?.checkedRows);
      print("Value is>>>" + isDataOk.toString());
      if ((stateManager?.checkedRows.length ?? 0) == 0) {
        LoadingDialog.callInfoMessage("Please select rows");
      } else if (isDataOk == true) {
        LoadingDialog.callInfoMessage("No changes to save");
      } else {
        LoadingDialog.call();
        var postMap = {
          "locationCode": selectLocation?.key ?? "",
          "channelCode": selectChannel?.key ?? "",
          "lstCommercialLanguage": stateManager?.checkedRows.map((e) {
            return {
              "selectLanguage": true,
              "languageCode": e.cells["languageCode"]?.value
            };
          }).toList()
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.COMMERCIAL_LANG_SPEC_SAVE,
            json: postMap,
            fun: (map) {
              Get.back();
              if (map is Map &&
                  map.containsKey("success") &&
                  map["success"] != null) {
                LoadingDialog.callDataSavedMessage(map["success"],
                    callback: () {
                  Get.delete<CommercialLanguageSpecificationController>();
                  Get.find<HomeController>().clearPage1();
                });
              } else {
                LoadingDialog.callInfoMessage(map.toString());
              }
            });
      }
    }
  }

  /*isEqualData() {
    if (const IterableEquality().equals(
        commercialLangModel?.display?.toSet(),
        commercialLangModel?.backupDisplay?.toSet())) {
      // if (const SetEquality().equals([1,2,3].toSet(),[1,2,3].toSet())) {
      print("Equal");
    } else {
      print("Not equal");
    }
    for (int i = 0; i < (commercialLangModel?.display?.length ?? 0); i++) {
      if (commercialLangModel?.display)
    }
  }*/

  /*Future<> areListsEqual(var list1, var list2) {
    Completer<bool> completer = Completer<bool>();
    if (list1.length != list2.length) {
      completer.complete(false);
    }

    // check if elements are equal
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].cells["selectLanguage"]?.value !=
          list2[i].cells["selectLanguage"]?.value) {
        // return false;
        completer.complete(false);
      }
    }
    if (!completer.isCompleted) {
      completer.complete(true);
    }
    return completer.future;
  }*/

  Future<bool> areListsEqual1(var list1, var list2) async {
    if (list1.length != list2.length) {
      // completer.complete(false);
      return false;
    }

    // check if elements are equal
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].cells["selectLanguage"]?.value !=
          list2[i].cells["selectLanguage"]?.value) {
        // return false;
        // completer.complete(false);
        return false;
      }
    }
    return true;
    // if (!completer.isCompleted) {
    //   completer.complete(true);
    // }
    // return completer.future;
  }
}
