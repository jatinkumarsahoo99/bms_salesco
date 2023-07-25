import 'dart:convert';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../ComercialAutoLoadModel.dart';

class CommercialCreationAutoController extends GetxController {

  PlutoGridStateManager? stateManager;
  Rxn<ComercialAutoLoadModel>? loadModel= Rxn<ComercialAutoLoadModel>(null);
  @override
  void onInit() {
    getLoad();
    super.onInit();
  }


  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_GET_LOAD(),
        fun: (Map map) {
          print("Location dta>>>" + jsonEncode(map));
          loadModel?.value=ComercialAutoLoadModel.fromJson(map as Map<String,dynamic>);
          update(["listUpdate"]);
        });
  }


  void save() {
    /*if (selectLocation == null) {
      LoadingDialog.callInfoMessage("Please select location");
    } else if (selectChannel == null) {
      LoadingDialog.callInfoMessage("Please select location");
    } else if (stateManager == null) {
      LoadingDialog.callInfoMessage("Table not available");
    } else {
      LoadingDialog.call();
      var postMap = {
        "locationCode": selectLocation?.key,
        "channelcode": selectChannel?.key,
        "dseriesSpecs": stateManager?.rows.map((e) => e.toJsonIntConvert(intConverterKeys: ["startPosition","endPosition"],boolList:["isLastSegment"])).toList()
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.DSERIES_SPECIFICATION_SAVE,
          json: postMap,
          fun: (map) {
            Get.back();
            if (map is Map && map.containsKey("save") && map["save"].toString().contains("successfully")) {
              LoadingDialog.callDataSavedMessage("Data successfully");
            }else{
              LoadingDialog.callInfoMessage(map.toString());
            }
          });
    }*/
  }

}
