import 'dart:math';

import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../model/pdc_cheques_model.dart';

class PDCChequesController extends GetxController {
  var selectedTab = 0.obs;
  var locationChannelList = <LocationChannelModel>[].obs,
      chequeGroupingList = [].obs;
  var pdcTypeList = <DropDownValue>[].obs, agencyList = <DropDownValue>[].obs;
  int locationChannelLastSelectedIdx = 0;
  DropDownValue? selectedPdcType, selecctedClient, selectedAgency;
  PlutoGridStateManager? locationChannelSM;
  var bankTC = TextEditingController(),
      recdOnDateTC = TextEditingController(),
      recdByTC = TextEditingController(),
      ccdVerifyDateTC = TextEditingController(),
      ccdVerifyByTC = TextEditingController(),
      chequeNoTC = TextEditingController(),
      chequeDateTC = TextEditingController(),
      approvedTillDateTC = TextEditingController(),
      remarksTC = TextEditingController(),
      checkAmtTC = TextEditingController(text: '0.00'),
      tdsAmtTC = TextEditingController(text: '0.00'),
      saveTaxTC = TextEditingController(text: '0.00'),
      revChqNoTC = TextEditingController(),
      revChqAmtTC = TextEditingController(text: '0.00'),
      revBankTC = TextEditingController(),
      activityMonthTC = TextEditingController();
  var saveTaxAmt = "".obs, newBookAmt = "".obs;
  var isDummy = false.obs;
  var clientFN = FocusNode();
  @override
  void onInit() {
    activityMonthTC.text = "${DateTime.now().year}${DateTime.now().month}";
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
          if (resp != null && resp['agencyModels'] != null) {
            agencyList.clear();
            agencyList.addAll((resp['agencyModels'] as List<dynamic>)
                .map(
                  (e) => DropDownValue(
                      key: e['agencycode'], value: e['agencyname'].toString()),
                )
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
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
          Future.delayed(Duration(seconds: 1)).then((value) {
            clientFN.requestFocus();
          });
        }
      },
    );
  }

  calculateTotal() {
    num netAmout = (num.tryParse(checkAmtTC.text) ?? 0) +
        (num.tryParse(tdsAmtTC.text) ?? 0);

    num netRO =
        (netAmout * 100 / (100 + (num.tryParse(saveTaxTC.text) ?? 0))).ceil();
    saveTaxAmt.value = (netAmout - netRO).toString();
    newBookAmt.value = netRO.toString();
  }

  saveData() {
    if (locationChannelList.isEmpty) {
      LoadingDialog.callInfoMessage("Data Table can't be blank");
    } else if (selecctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client");
    } else if (selectedAgency == null) {
      LoadingDialog.callInfoMessage("Please select Agency");
    } else if (selectedPdcType == null) {
      LoadingDialog.callInfoMessage("Please select PDC");
    } else {
      LoadingDialog.call();
      var payload = {
        "chequeId": 0,
        "clientCode": selecctedClient?.key,
        "chequeNo": chequeNoTC.text,
        "chequeDate": DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(chequeDateTC.text)),
        "chequeAmount": num.tryParse(newBookAmt.value) ?? 0,
        "bankName": bankTC.text,
        "chequeReceivedBy": recdByTC.text,
        "chequeReceivedOn": DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(recdOnDateTC.text)),
        "ccdVerifiedBy": ccdVerifyByTC.text,
        "ccdVerifiedOn": DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(ccdVerifyDateTC.text)),
        "pdcTypeId": num.tryParse(selectedPdcType?.key ?? '0'),
        "remarks": remarksTC.text,
        "isDummy": isDummy.value,
        "approvedTill": DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(approvedTillDateTC.text)),
        "agencycode": selectedAgency?.key,
        "chequeAmountGross": checkAmtTC.text,
        "serviceTaxPercent": num.tryParse(saveTaxTC.text),
        "serviceTaxAmount": num.tryParse(saveTaxAmt.value),
        "tdsAmount": num.tryParse(tdsAmtTC.text),
        "revisedChequeNumber": num.tryParse(revChqNoTC.text),
        "revisedChequeAmount": num.tryParse(revChqAmtTC.text),
        "revisedChequeBank": revBankTC.text,
        "channalLocationCodes": locationChannelList
            .where((e) => (e.selectRow ?? false))
            .toList()
            .map((e) => e.toJson(fromSave: true))
            .toList()
      };
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PDC_CHEQUES_SAVE,
        json: payload,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp['save'] != null &&
              resp['save'].toString().toLowerCase().contains('successfully')) {
            LoadingDialog.callDataSaved(msg: resp['save'].toString());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }
}
