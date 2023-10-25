import 'dart:convert';

import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/widgets/NoDataFoundPage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/Aes.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../CommercialCreationAuto/ComercialAutoLoadModel.dart';
import '../CommercialDetailsModel.dart';

class CommercialCreationAutoDetailsController extends GetxController {
  //TODO: Implement CommercialCreationAutoDetailsController
  TextEditingController agencyId_ = TextEditingController();
  TextEditingController tapeId_ = TextEditingController();
  TextEditingController som_ = TextEditingController();
  TextEditingController eom_ = TextEditingController();

  TextEditingController caption_ = TextEditingController();
  TextEditingController endDate_ = TextEditingController();
  RxString duration = RxString("00:00:00:00");
  RxString client = RxString("");
  RxString brand = RxString("");
  RxString language = RxString("");
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

  // DropDownValue? selectCensorship;
  // DropDownValue? selectRevenue;
  // DropDownValue? selectSectype;
  Rxn<DropDownValue>? selectCensorship = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectRevenue = Rxn<DropDownValue>();
  Rxn<DropDownValue>? selectSectype = Rxn<DropDownValue>();

  Rxn<ComercialAutoLoadModel>? loadModel = Rxn<ComercialAutoLoadModel>(null);
  CommercialDetailsModel? commercialDetails;

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
  }

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
        api: ApiFactory.COMMERCIAL_CREATION_GET_LOAD(),
        fun: (Map map) {
          loadModel?.value =
              ComercialAutoLoadModel.fromJson(map as Map<String, dynamic>);
        });
  }

  getRevenueLeave(String revType) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_REVENUE_TYPE_SELECT(revType),
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
          }
        });
  }

  getDataFromACID() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_SHOW_ACID(
            Aes.decrypt(Get.parameters["acId"] ?? "") ?? "322"),
        fun: (Map map) {
          commercialDetails =
              CommercialDetailsModel.fromJson(map as Map<String, dynamic>);
          caption_.text = commercialDetails?.lstShowACID![0].myCaption ?? "";
          client.value = commercialDetails?.lstShowACID![0].advertiser ?? "";
          brand.value = commercialDetails?.lstShowACID![0].brand ?? "";
          language.value =
              commercialDetails?.lstShowACID![0].commerciallanguage ?? "";
          duration1.value =
              commercialDetails?.lstShowACID![0].commercialDuration ?? "";
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
          agencyId_.text = commercialDetails?.lstShowACID![0].agencyId ?? "";
          selectLanguage?.value = DropDownValue(
              key: commercialDetails?.lstShowACID![0].languageCode ?? "",
              value:
                  commercialDetails?.lstShowACID![0].commerciallanguage ?? "");
          htmlBody.value = commercialDetails?.lstShowACID![0].mailBody ?? "";
          selectClientFromApi(
              commercialDetails?.lstShowACID![0].clientCode ?? "");
          selectBrandFromApi(
              commercialDetails?.lstShowACID![0].clientCode ?? "");
        });
  }

  selectClientFromApi(String client) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_SELECT_CLIENT(client),
        fun: (Map map) {
          if (map.containsKey("lstClientMaster")) {
            if (map["lstClientMaster"] != null) {
              selectClient?.value = DropDownValue(
                  key: map["lstClientMaster"][0]["clientcode"],
                  value: map["lstClientMaster"][0]["Clientname"]);
            }
          }
        });
  }

  selectBrandFromApi(String client) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_BRAND_LIST(client) +
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
        "RecievedOn": DateFormat("dd-MM-yyyy").format(DateTime.now()),
        "eventtypecode": selectRevenue?.value?.key ?? "",
        "eventsubtype": selectSectype?.value?.key ?? "",
        "agencytapeid": commercialDetails?.lstShowACID![0].agencyId,
        "languagecode": selectLanguage?.value?.key ?? "",
        "clockid": commercialDetails?.lstShowACID![0].agencyId,
        "eom": eom_.text,
        "ExportTapeCaption": caption_.text,
        "censorshipCode": selectCensorship?.value?.key ?? "",
        "acid": commercialDetails?.lstShowACID![0].acid.toString()
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.COMMERCIAL_CREATION_SAVE(),
          json: postMap,
          fun: (map) {
            Get.back();
            if (map is Map &&
                map.containsKey("lstsectype") &&
                map["lstsectype"] != null) {
              LoadingDialog.callDataSavedMessage("Data Saved Successfully");
            } else {
              LoadingDialog.callInfoMessage(map.toString());
            }
          });
    }
  }
}
