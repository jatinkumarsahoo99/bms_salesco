import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
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

  // TextEditingController duration_ = TextEditingController();
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

  Rxn<DropDownValue>? selectClient = Rxn<DropDownValue>();
  DropDownValue? selectBrand;
  Rxn<DropDownValue>? selectLanguage = Rxn<DropDownValue>();
  DropDownValue? selectCensorship;
  DropDownValue? selectRevenue;
  DropDownValue? selectSectype;
  Rxn<ComercialAutoLoadModel>? loadModel = Rxn<ComercialAutoLoadModel>(null);
  CommercialDetailsModel? commercialDetails;

  @override
  void onInit() {
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
        fun: (Map map) {
          print("Response>>>>"+jsonEncode(map));
          loadModel?.value =
              ComercialAutoLoadModel.fromJson(map as Map<String, dynamic>);
        });
  }

  getDataFromACID() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_SHOW_ACID("58"),
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
          htmlBody.value=commercialDetails?.lstShowACID![0].mailBody ?? "";
          selectClientFromApi(commercialDetails?.lstShowACID![0].advertiser ?? "");
        });
  }

  selectClientFromApi(String client) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMMERCIAL_CREATION_CLIENT_LIST() + client,
        fun: (Map map) {
          if (map.containsKey("lstClientMaster")) {
            selectClient?.value = DropDownValue(
                key: map["lstClientMaster"][0]["clientcode"],
                value: map["lstClientMaster"][0]["Clientname"]);
          }
        });
  }
}
