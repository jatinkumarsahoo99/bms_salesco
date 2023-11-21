import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class BookingsAgainstPDCController extends GetxController {
  var dataTableList = [].obs;
  DropDownValue? selctedClient, selctedAgency, selectedCheque;
  var agencyList = <DropDownValue>[].obs, chequeList = <DropDownValue>[].obs;
  var activityMonthCTR = TextEditingController(text: '0');
  var activityMonthFN = FocusNode(), chequeFN = FocusNode();
  PlutoGridStateManager? sm;

  @override
  void onReady() {
    super.onReady();
    activityMonthFN.onKey = (node, event) {
      if (event.logicalKey == LogicalKeyboardKey.tab &&
          !event.isShiftPressed &&
          !event.isAltPressed) {
        getChequeNo();
      }
      return KeyEventResult.ignored;
    };
  }

  clearPage() {
    Get.delete<BookingsAgainstPDCController>();
    Get.find<HomeController>().clearPage1();
  }

  handleOnChangeClient(DropDownValue client) {
    selctedClient = client;
    getAgencyList();
  }

  getBookingList() {
    if (selctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else if (selctedAgency == null) {
      LoadingDialog.callInfoMessage("Please select Agency.");
    } else if (selectedCheque == null) {
      LoadingDialog.callInfoMessage("Please select Cheque No.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.BOOKING_AGAINST_PDC_GET_BOOKING_LIST(
            selctedClient!.key!,
            selctedAgency!.key!,
            activityMonthCTR.text,
            selectedCheque!.key!,
          ),
          fun: (resp) {
            Get.back();
            if (resp != null && resp['pdcList'] != null) {
              dataTableList.value = resp['pdcList'];
            } else {
              LoadingDialog.showErrorDialog(resp.toString());
            }
          },
          failed: (resp) {
            Get.back();
            LoadingDialog.showErrorDialog(resp.toString());
          });
    }
  }

  getAgencyList() {
    if (selctedClient == null) {
      LoadingDialog.callInfoMessage("Please select Client");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.BOOKING_AGAINST_PDC_GET_AGENCY(selctedClient!.key!),
          fun: (resp) {
            Get.back();
            if (resp != null && resp['agencyList'] != null) {
              agencyList.clear();
              agencyList.addAll((resp['agencyList'] as List<dynamic>)
                  .map((e) => DropDownValue(
                      key: e['agencyCode'], value: e['agencyName']))
                  .toList());
            } else {
              LoadingDialog.showErrorDialog(resp.toString());
            }
          },
          failed: (resp) {
            Get.back();
            LoadingDialog.showErrorDialog(resp.toString());
          });
    }
  }

  getChequeNo() {
    if (selctedClient == null) {
      // LoadingDialog.callInfoMessage("Please select Client");
    } else if (selctedAgency == null) {
      // LoadingDialog.callInfoMessage("Please select Agency");
    } else {
      // LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.BOOKING_AGAINST_PDC_GET_CHEQUE_NO(
            selctedClient!.key!,
            selctedAgency!.key!,
            activityMonthCTR.text,
          ),
          fun: (resp) {
            Get.back();
            if (resp != null && resp['pdcList'] != null) {
              selectedCheque = null;
              chequeList.clear();
              chequeList.addAll((resp['pdcList'] as List<dynamic>)
                  .map((e) => DropDownValue(
                      key: e['chequeid'].toString(),
                      value: e['chequeno'].toString()))
                  .toList());
              // chequeFN.requestFocus();
            } else {
              LoadingDialog.showErrorDialog(resp.toString());
            }
          },
          failed: (resp) {
            Get.back();
            LoadingDialog.showErrorDialog(resp.toString());
          });
    }
  }
}
