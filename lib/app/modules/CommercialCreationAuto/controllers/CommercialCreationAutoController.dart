import 'dart:convert';

import 'package:bms_salesco/widgets/LoadingDialog.dart';
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
          loadModel?.value=ComercialAutoLoadModel.fromJson(map as Map<String,dynamic>);
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
          if(map is Map && map.containsKey("newMedia")){
            if(loadModel?.value!=null){
              // loadModel?.value?.loadData.l
              if (map['newMedia'] != null) {
                List<LstNewMedia> lstNewMedia = <LstNewMedia>[];
                map['newMedia'].forEach((v) {
                  lstNewMedia!.add(new LstNewMedia.fromJson(v));
                });
                loadModel?.value?.loadData?.lstNewMedia=lstNewMedia;
                update(["listUpdate"]);
              }
            }
          }
        });
  }




}
