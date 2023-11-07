import 'dart:math';

import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
import '../model/pdc_cheques_model.dart';

class PDCChequesController extends GetxController {
  var selectedTab = 0.obs;
  Offset? initPosition;
  Rxn<Widget?> dialogWidget = Rxn();
  var locationChannelList = <LocationChannelModel>[].obs,
      chequeGroupingList = <ChequeGroupingModel>[].obs;
  var pdcTypeList = <DropDownValue>[].obs, agencyList = <DropDownValue>[].obs;
  int locationChannelLastSelectedIdx = 0, chequeGroupingLastSelectedIdx = 0;
  DropDownValue? selectedPdcType, selecctedClient, selectedAgency;
  PlutoGridStateManager? locationChannelSM, chequeGroupingSM;
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
  var clientFN = FocusNode(), activityMonthFN = FocusNode();
  int chequeID = 0;
  double widthRation = .15;

  @override
  void onReady() {
    super.onReady();
    LoadingDialog.call();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      activityMonthTC.text = "${DateTime.now().year}${DateTime.now().month}";
      activityMonthFN.onKey = (node, event) {
        if (!event.isShiftPressed &&
            !event.isAltPressed &&
            event.logicalKey == LogicalKeyboardKey.tab) {
          Get.focusScope?.nextFocus();
          getChequeBookingData(chequeId: chequeID);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
      getOnLoadData();
    });
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
        Get.back();
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
        "chequeId": chequeID,
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
              resp is Map<String, dynamic> &&
              resp.containsKey("save") &&
              resp['save'] != null &&
              resp['save'].toString().toLowerCase().contains('successfully')) {
            LoadingDialog.callDataSaved(
                msg: resp['save'].toString(),
                callback: () {
                  clearPage();
                });
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }

  getChequeBookingData({int chequeId = 0}) {
    if (selecctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client");
    } else if (selectedAgency == null) {
      LoadingDialog.callInfoMessage("Please select Agency");
    } else {
      // LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PDC_CHEQUES_GET_CHEQUE_GROUPING,
        json: {
          "clientCode": selecctedClient?.key,
          "agencyCode": selectedAgency?.key,
          "activityPeriod": activityMonthTC.text,
          "chequeId": "$chequeId"
        },
        fun: (resp) {
          // Get.back();
          if (resp != null && resp['pDCGroups'] != null) {
            chequeGroupingList.clear();
            chequeGroupingList.addAll(
              (resp['pDCGroups'] as List<dynamic>)
                  .map((e) => ChequeGroupingModel.fromJson(e))
                  .toList(),
            );
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }

  saveChequeBookingData() {
    if (selecctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client");
    } else if (selectedAgency == null) {
      LoadingDialog.callInfoMessage("Please select Agency");
    } else if (chequeGroupingList.isEmpty) {
      LoadingDialog.callInfoMessage("Data can't be empty.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PDC_CHEQUES_SAVE_CHEQUE_GROUPING,
        json: {
          "chequeIds": chequeGroupingList
              .where((e) => e.selectRow ?? false)
              .toList()
              .map((e2) => e2.toJson(fromSave: true))
              .toList(),
        },
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp.toString().toLowerCase().contains("successfully")) {
            LoadingDialog.callDataSaved(
                msg: resp['pDCGroups'].toString(),
                callback: () {
                  clearPage();
                });
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
      );
    }
  }

  clearPage() {
    Get.delete<PDCChequesController>();
    Get.find<HomeController>().clearPage1();
  }

  getRetriveData({int chequeId = 0}) {
    chequeID = chequeId;
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.PDC_CHEQUES_GET_RETRIVE_DATA(chequeId.toString()),
      fun: (resp) {
        Get.back();
        if (resp != null && resp['retrieve'] != null) {
          PDCRetriveModel retriveData =
              PDCRetriveModel.fromJson(resp['retrieve'][0]);

          /// CLIENT
          selecctedClient = DropDownValue(
              key: retriveData.clientCode, value: retriveData.clientName);
          update(['client']);

          /// BANK
          bankTC.text = retriveData.bankName ?? '';

          ///RECD ON (DATE)
          if (retriveData.chequeReceivedOn != null &&
              (retriveData.chequeReceivedOn?.contains("T") ?? false)) {
            recdOnDateTC.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddThh:mm:ss')
                    .parse(retriveData.chequeReceivedOn!));
          }

          ///RECD BY
          recdByTC.text = retriveData.chequeReceivedBy ?? "";

          ///CCD VERIFY DATE (DATE)
          if (retriveData.ccdVerifiedOn != null &&
              (retriveData.ccdVerifiedOn?.contains("T") ?? false)) {
            ccdVerifyDateTC.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddThh:mm:ss')
                    .parse(retriveData.ccdVerifiedOn!));
          }

          ///RECD BY
          ccdVerifyByTC.text = retriveData.ccdVerifiedBy ?? "";

          /// PDC
          selectedPdcType = DropDownValue(
              key: retriveData.pdcTypeId.toString(),
              value: retriveData.pdcTypeName);
          pdcTypeList.refresh();

          /// AGENCY
          selectedAgency = DropDownValue(
              key: retriveData.agencyCode, value: retriveData.agencyName);
          agencyList.refresh();

          /// CHEQUE NO
          chequeNoTC.text = retriveData.chequeNo ?? "";

          ///CHEQUE DATE (DATE)
          if (retriveData.chequeDate != null &&
              (retriveData.chequeDate?.contains("T") ?? false)) {
            chequeDateTC.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddThh:mm:ss')
                    .parse(retriveData.chequeDate!));
          }

          /// IS DUMMY
          isDummy.value = retriveData.isDummy ?? false;

          ///APPROVED TILL (DATE)
          if (retriveData.approvedTill != null &&
              (retriveData.chequeDate?.contains("T") ?? false)) {
            approvedTillDateTC.text = DateFormat('dd-MM-yyyy').format(
                DateFormat('yyyy-MM-ddThh:mm:ss')
                    .parse(retriveData.approvedTill!));
          }

          /// RE-MARKS
          remarksTC.text = retriveData.remarks ?? "";

          /// CHEQUE AMT
          checkAmtTC.text = (retriveData.chequeAmountGross ?? "").toString();

          /// TDS AMT
          tdsAmtTC.text = (retriveData.tdsAmount ?? "").toString();

          /// SVC TAX
          saveTaxTC.text = (retriveData.serviceTaxPercent ?? "").toString();

          /// SVC TAX AMT

          saveTaxAmt.value = (retriveData.serviceTaxAmount ?? "").toString();

          /// NET BOOK AMT
          newBookAmt.value = (retriveData.chequeAmount ?? "").toString();

          /// 1st Tab List
          locationChannelList.value = retriveData.locationChannelModel ?? [];
          // calculateTotal();
          getChequeBookingData(chequeId: chequeId);
        } else {
          LoadingDialog.showErrorDialog(resp.toString());
        }
      },
    );
  }

  docs() async {
    String documentKey = "";
    if (chequeID == 0) {
      documentKey = "";
    } else {
      documentKey = "ChequeID $chequeID";
    }
    if (documentKey == "") return;

    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }
}
