import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../model/pdc_cheques_model.dart';

class PDCChequesController extends GetxController {
  var selectedTab = 0.obs;
  var locationChannelList = <LocationChannelModel>[].obs,
      chequeGroupingList = [].obs;
  var pdcTypeList = <DropDownValue>[].obs;
  int locationChannelLastSelectedIdx = 0;
  DropDownValue? selectedPdcType, selecctedClient;
  PlutoGridStateManager? locationChannelSM;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  handleOnChangeClient(DropDownValue client) {
    selecctedClient = client;
    getAgency();
  }

  getAgency() {
    if (selecctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PDC_CHEQUES_GET_AGENCY(selecctedClient!.key!),
        fun: (resp) {
          Get.back();
        },
      );
    }
  }

  getOnLoadData({int chequeId = 0}) {
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.PDC_CHEQUES_ON_LOAD(chequeId),
      fun: (resp) {
        if (resp != null && resp['onLoad'] != null) {
          if (resp['onLoad']['locationChannelModel'] != null) {
            locationChannelList.value = [];
            locationChannelList.value.addAll(
                ((resp['onLoad']['locationChannelModel'] ?? [])
                        as List<dynamic>)
                    .map((e) => LocationChannelModel.fromJson(e))
                    .toList());
          }
          if (resp['onLoad']['pdcTypeModel'] != null) {
            pdcTypeList.addAll((resp['onLoad']['pdcTypeModel'] as List<dynamic>)
                .map(
                  (e) => DropDownValue(
                      key: e['pdcTypeId'].toString(), value: e['pdcType']),
                )
                .toList());
          }
        }
      },
    );
  }
}
