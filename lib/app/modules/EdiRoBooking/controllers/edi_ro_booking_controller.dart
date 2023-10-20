import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/FormButton.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';

class EdiRoBookingController extends GetxController {
  //TODO: Implement EdiRoBookingController

  final count = 0.obs;
  var infoTableList = [].obs;
  var drgabbleDialog = Rxn<Widget>();
  EdiRoInitData? initData;
  var fileNames = RxList<DropDownValue>();
  var loactions = RxList<DropDownValue>();
  var positions = RxList<DropDownValue>();
  var executives = RxList<DropDownValue>();
  var strRoRefNo = RxList<DropDownValue>();
  var client = RxList<DropDownValue>();
  var agency = RxList<DropDownValue>();
  var brand = RxList<DropDownValue>();

  // Selected DropDownValues
  DropDownValue? selectedFile;
  DropDownValue? selectedLoactions;
  DropDownValue? selectedPositions;
  DropDownValue? selectedExecutives;
  DropDownValue? selectedRoRefNo;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedBrand;

  TextEditingController effectiveDate = TextEditingController();

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  RxBool isEnable = RxBool(true);

  @override
  void onInit() {
    getInitData();
    fetchUserSetting1();
    super.onInit();
  }

  getInitData() {
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_INIT,
          fun: (map) {
            // initData = EdiRoInitData.fromJson(map["onLoadInfo"]);
            fileNames.clear();
            map["onLoadInfo"]['softListMyFiles'].forEach((e) {
              fileNames
                  .add(DropDownValue(key: '', value: e['convertedFileName']));
            });
            loactions.clear();
            map["onLoadInfo"]['lstLocation'].forEach((e) {
              loactions.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            positions.clear();
            map["onLoadInfo"]['lstSpotPosType'].forEach((e) {
              positions.add(DropDownValue(
                  key: e['spotPositionTypeCode'],
                  value: e['spotPositionTypeName']));
            });
            executives.clear();
            map["onLoadInfo"]['executives'].forEach((e) {
              executives.add(DropDownValue(
                  key: e['personnelCode'], value: e['personnelName']));
            });

            update(["initData"]);
          });
    } catch (e) {
      print(e.toString());
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  effectiveDateLeave() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_FILE_LEAVE(
              selectedFile?.value,
              DateFormat("yyyy-MM-dd")
                  .format(DateFormat("dd-MM-yyyy").parse(effectiveDate.text))),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFileNameLeave'] != null &&
                map.containsKey('infoFileNameLeave')) {
              isEnable.value = false;
              strRoRefNo.clear();
              //RO Ref No.
              map["infoFileNameLeave"]['strRoRefNo'].forEach((e) {
                strRoRefNo.add(DropDownValue(key: '', value: e));
                selectedRoRefNo = DropDownValue(key: '', value: e);
              });
              //Location
              selectedLoactions = loactions.firstWhereOrNull((element) {
                var result = element.key ==
                    map['infoFileNameLeave']['headerData']['locationCode'];
                return result;
              });
              //Client
              map["infoFileNameLeave"]['headerData']['lstClients'].forEach((e) {
                client.add(DropDownValue(
                    key: e['clientCode'], value: e['clientName']));
              });
              selectedClient = client.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['clientcode'];
                  return result;
                },
              );
              //Agency
              map["infoFileNameLeave"]['headerData']['lstAgencies']
                  .forEach((e) {
                agency.add(DropDownValue(
                    key: e['agencyCode'], value: e['agencyName']));
              });
              selectedAgency = agency.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['agencyCode'];
                  return result;
                },
              );
              //Brand
              map["infoFileNameLeave"]['headerData']['lstBrands'].forEach((e) {
                brand.add(
                    DropDownValue(key: e['brandcode'], value: e['brandname']));
              });
              update(["initData"]);
            } else {
              LoadingDialog.showErrorDialog('No data found.');
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
