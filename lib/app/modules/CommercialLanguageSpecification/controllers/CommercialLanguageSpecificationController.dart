import 'dart:convert';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
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

  @override
  void onInit() {
    getLocations();
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
    }  else {
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

  void save() {
    if (selectLocation == null) {
      LoadingDialog.callInfoMessage("Please select location");
    } else if (selectChannel == null) {
      LoadingDialog.callInfoMessage("Please select channel");
    } else {
      if ((stateManager?.checkedRows.length ?? 0) == 0) {
        LoadingDialog.callInfoMessage("Please select rows");
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
                  map.containsKey("lstsectype") &&
                  map["lstsectype"] != null) {
                LoadingDialog.callDataSavedMessage("Data successfully");
              } else {
                LoadingDialog.callInfoMessage(map.toString());
              }
            });
      }
    }
  }
}
