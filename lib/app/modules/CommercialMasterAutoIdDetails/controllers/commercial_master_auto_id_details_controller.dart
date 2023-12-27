import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/NoDataFoundPage.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/Aes.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../CommercialMasterAutoId/ComercialMasterAutoIdLoadModel.dart';
import '../CommercialMasterDetailsModel.dart';

class CommercialMasterAutoIdDetailsController extends GetxController {
  //TODO: Implement CommercialMasterAutoIdDetailsController


  TextEditingController agencyId_ = TextEditingController();
  TextEditingController tapeId_ = TextEditingController();
  TextEditingController som_ = TextEditingController();
  TextEditingController eom_ = TextEditingController();

  TextEditingController caption_ = TextEditingController();
  TextEditingController endDate_ = TextEditingController();
  RxString duration = RxString("00:00:00:00");
  RxString client = RxString("");
  RxString brand = RxString("");
  RxString tapeType = RxString("");
  RxString temitory = RxString("");
  RxString language = RxString("");
  RxString censorship = RxString("");
  RxString revenue = RxString("");
  RxString secType = RxString("");
  RxString location = RxString("");
  RxString duration1 = RxString("");
  RxString providers = RxString("");
  RxString ACID = RxString("");
  RxString htmlBody = RxString("");
  final count = 0.obs;
  FocusNode eomFocus = FocusNode();
  RxList<DropDownValue> secTypeList = RxList([]);

  Rxn<DropDownValue>? selectClient = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectBrand = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectLanguage = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectLocation = Rxn<DropDownValue>();

  // DropDownValue? selectCensorship;
  // DropDownValue? selectRevenue;
  // DropDownValue? selectSectype;
  Rxn<DropDownValue>? selectCensorship = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectRevenue = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectSectype = Rxn<DropDownValue>();

  Rxn<ComercialMasterAutoIdLoadModel>? loadModel = Rxn<ComercialMasterAutoIdLoadModel>(null);
  CommercialMasterDetailsModel? commercialDetails;
  FocusNode clientFocus=FocusNode();

  // final count = 0.obs;

  @override
  void onInit() {
    if ((!Get.isRegistered<MainController>()) ||
        Get.find<MainController>().user == null) {
      Get.to(NoDataFoundPage());
    }
    getLoad();
    getDataFromACID();
    super.onInit();
    eomFocus.addListener(() {
      if (!eomFocus.hasFocus) {}
    });
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


  calculateSegDur() {
    num diff = (Utils.oldBMSConvertToSecondsValue(value: eom_.text) -
        Utils.oldBMSConvertToSecondsValue(value: som_.text));
    print(">>>>" + diff.toString());
    if (diff.isNegative) {
      // Snack.call("TC Out should not less than TC In");
      LoadingDialog.showErrorDialog("EOM should not less than SOM");
    } else {
      duration.value = Utils.convertToTimeFromDouble(value: diff);
    }
  }

  getLoad() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_GET_LOAD(),
        fun: (Map map) {
          loadModel?.value =
              ComercialMasterAutoIdLoadModel.fromJson(map as Map<String, dynamic>);
        });
  }

  getRevenueLeave(String revType) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_REVENUE_TYPE_SELECT(revType),
        fun: (map) {
          print("Response>>>>" + jsonEncode(map));
          if (map is Map &&
              map.containsKey("lstsectype") &&
              map["lstsectype"] != null) {
            secTypeList.value.clear();
            map["lstsectype"].forEach((e) {
              secTypeList.value.add(new DropDownValue(
                  key: e["eventCode"].toString(), value: e["eventName"]));
            });

            if (secTypeList.value != null &&
                secTypeList.value.length > 0 &&
                secTypeList.value.length == 1) {
              selectSectype?.value = secTypeList.value[0];
            }else{
              selectSectype?.value=null;
            }
          }
        });
  }

  getDataFromACID() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_SHOW_ACID(
            Aes.decrypt(Get.parameters["acId"] ?? "") ?? ""),
        fun: (Map map) {
          commercialDetails =
              CommercialMasterDetailsModel.fromJson(map as Map<String, dynamic>);
          caption_.text = commercialDetails?.lstShowACID![0].commercialCaption ?? "";
          client.value = commercialDetails?.lstShowACID![0].clientName ?? "";
          tapeType.value = commercialDetails?.lstShowACID![0].tapeType ?? "";
          temitory.value = commercialDetails?.lstShowACID![0].territory ?? "";
          revenue.value = commercialDetails?.lstShowACID![0].revenue ?? "";
          censorship.value = commercialDetails?.lstShowACID![0].censorship ?? "";
          location.value = commercialDetails?.lstShowACID![0].locationName ?? "";
          brand.value = commercialDetails?.lstShowACID![0].brand ?? "";
          secType.value = commercialDetails?.lstShowACID![0].secType ?? "";
          language.value =
              commercialDetails?.lstShowACID![0].languageName ?? "";
          duration1.value =
              (commercialDetails?.lstShowACID![0].commercialDuration ?? "").toString();
          providers.value = commercialDetails?.lstShowACID![0].provider ?? "";
          ACID.value = commercialDetails?.lstShowACID![0].acid.toString() ?? "";
          som_.text = commercialDetails?.lstShowACID![0].txtSOM ?? "";
          eom_.text = Utils.convertToTimeFromDouble(
              value: num.tryParse(commercialDetails
                  ?.lstShowACID![0].txtEOMDurationInSeconds
                  .toString() ??
                  "0") ??
                  0);
          duration.value = Utils.convertToTimeFromDouble(
              value: num.tryParse(commercialDetails
                  ?.lstShowACID![0].txtDurationInSeconds
                  .toString() ??
                  "0") ??
                  0);
          tapeId_.text = commercialDetails?.lstShowACID![0].tapeid ?? "";
          tapeId_.text = Aes.decrypt((Get.parameters["exportTapeCode"] ?? "").toString())??"";
          // agencyId_.text = commercialDetails?.lstShowACID![0].agencyId ?? "";
          selectLanguage?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].languagecode ?? "",
              value:
              commercialDetails?.lstShowACID![0].languageName ?? "");

          selectLocation?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].locationCode ?? "",
              value:
              commercialDetails?.lstShowACID![0].locationName ?? "");

          selectCensorship?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].censorshipCode ?? "",
              value:
              commercialDetails?.lstShowACID![0].censorship ?? "");

          selectRevenue?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].revenueCode ?? "",
              value:
              commercialDetails?.lstShowACID![0].revenue ?? "");


          selectSectype?.value = DropDownValue(
              key: (commercialDetails?.lstShowACID![0].secTypeCode ?? "").toString(),
              value:
              commercialDetails?.lstShowACID![0].secType ?? "");

          // htmlBody.value = commercialDetails?.lstShowACID![0].mailBody ?? "";
          selectClient?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].clientCode,
              value: commercialDetails?.lstShowACID![0].clientName);

          selectBrand?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].brandcode,
              value: commercialDetails?.lstShowACID![0].brandName);

          // getRevenueLeave(commercialDetails?.lstShowACID![0].revenueCode ?? "");

          clientFocus.requestFocus();

          /* selectClientFromApi(
              commercialDetails?.lstShowACID![0].clientCode ?? "");
          selectBrandFromApi(
              commercialDetails?.lstShowACID![0].clientCode ?? "");*/
        });
  }

  selectClientFromApi(String client) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_SELECT_CLIENT(client),
        fun: (Map map) {
          if (map.containsKey("lstClientMaster")) {
            if (map["lstClientMaster"] != null) {
              selectClient?.value = DropDownValue(
                  key: map["lstClientMaster"][0]["clientcode"],
                  value: map["lstClientMaster"][0]["Clientname"]);
              clientFocus.requestFocus();
            }
          }
        });
  }

  selectBrandFromApi(String client) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_MASTER_BRAND_LIST(client) +
            (commercialDetails?.lstShowACID![0].brand ?? ""),
        fun: (Map map) {
          if (map.containsKey("lstbrandmaster")) {
            if (map["lstbrandmaster"] != null) {
              selectBrand?.value = DropDownValue(
                  key: map["lstbrandmaster"][0]["Brandcode"],
                  value: map["lstbrandmaster"][0]["Brandname"]);
            }
          }
        });
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void save() {
    if (selectCensorship == null) {
      LoadingDialog.callInfoMessage("Please select censorship");
    } else if (selectRevenue == null) {
      LoadingDialog.callInfoMessage("Please select revenue");
    } else if (selectBrand?.value == null) {
      LoadingDialog.callInfoMessage("Please select brand");
    } else if (selectClient?.value == null) {
      LoadingDialog.callInfoMessage("Please select client");
    } else if (selectLanguage?.value == null) {
      LoadingDialog.callInfoMessage("Please select client");
    } else {
      try {
        LoadingDialog.call();
        var postMap = {
          "commercialCaption": caption_.text,
          "commercialDuration":
          Utils.oldBMSConvertToSecondsValue(value: duration.value)
              .toString() ??
              "",
          "exportTapeCode": tapeId_.text,
          "brandCode": selectBrand?.value?.key ?? "",
          "som": som_.text,
          "modifiedBy": "",
          "killDate": DateFormat("dd-MM-yyyy")
              .format((DateFormat("d-M-yyyy").parse(endDate_.text))),
          "houseID": tapeId_.text,
          "segmentNumber": 1,
          "despatchDate": DateFormat("dd-MM-yyyy").format(DateTime.now()),
          "recievedOn": DateFormat("dd-MM-yyyy").format(DateTime.now()),
          "eventtypecode": selectRevenue?.value?.key ?? "",
          "eventsubtype": selectSectype?.value?.key ?? "",
          // "agencytapeid": commercialDetails?.lstShowACID![0].agencyId,
          "languagecode": selectLanguage?.value?.key ?? "",
          // "clockid": commercialDetails?.lstShowACID![0].agencyId,
          "eom": eom_.text,
          "ExportTapeCaption": caption_.text,
          "censorshipCode": selectCensorship?.value?.key ?? "",
          "acid": commercialDetails?.lstShowACID![0].acid.toString(),
          "segmentNumber": 0,

          // "despatchDate": "string",
          // "eventtypecode": "string",
          // "eventsubtype": "string",

          "agencytapeid": "",
          // "languagecode": sele,
          "clockid": commercialDetails?.lstShowACID![0].clockId ?? "",
          // "eom": commercialDetails?.lstShowACID![0].acid??"",
          // "censorshipCode": "string",
          // "acid": "string",
          "brandName": selectBrand?.value?.value ?? "",
          "languageName": selectLanguage?.value?.value ?? "",
          "censorshipName": selectCensorship?.value?.value ?? "",
          "revenuetype": selectRevenue?.value?.value ?? "",
          "sectype": selectSectype?.value?.value ?? "",
          "locationCode": selectLocation?.value?.key ?? "",
          "location": selectLocation?.value?.value ?? "",
          "providerName": commercialDetails?.lstShowACID![0].provider ?? "",
          "tapeType": commercialDetails?.lstShowACID![0].tapeType ?? "",
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.COMMERCIAL_MASTER_SAVE(),
            json: postMap,
            fun: (map) {
              // Get.back();
              closeDialogIfOpen();
              if (map is Map &&
                  map.containsKey("lstsectype") &&
                  map["lstsectype"] != null) {
                if (tapeId_.text.toString().trim() ==
                    map["lstsectype"].toString().trim()) {
                  LoadingDialog.callDataSavedMessage(
                      "Data Saved Successfully with TapeID :${tapeId_.text}",
                      callback: () {
                        clear();
                      });
                } else if (map["lstsectype"].toString().trim() != "") {
                  LoadingDialog.callDataSavedMessage(
                      "Data Saved Successfully with TapeID :${tapeId_.text}",
                      callback: () {
                        clear();
                      });
                }
              } else {
                LoadingDialog.callInfoMessage(map.toString());
              }
            });
      }catch(e){
        closeDialogIfOpen();
        LoadingDialog.callInfoMessage("Something went wrong");
      }
    }
  }

  clear(){
    selectClient?.value = null;
    selectBrand?.value = null;
    selectLanguage?.value = null;
    selectCensorship?.value = null;
    selectRevenue?.value = null;
    selectLocation?.value = null;
    agencyId_.text = "";
    tapeId_.text = "";
    som_.text = "00:00:00:00";
    eom_.text = "00:00:00:00";
    duration.value = "00:00:00:00";
    endDate_.text = "";
    caption_.text = "";
    update(["update"]);
  }

}
