import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class OneSpotBookingSkyMediaController extends GetxController {
  //TODO: Implement OnSpotBookingSkyMediaController

  bool isEnable = true;
  final count = 0.obs;
  var clientDetails = RxList<DropDownValue>();
  Rx<bool> inactiveGroup = Rx<bool>(true);

  FocusNode locationNode = FocusNode();
  FocusNode channelNode = FocusNode();
  FocusNode bookingRegNode = FocusNode();
  FocusNode amountNode = FocusNode();

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> brandList = RxList([]);
  RxList<DropDownValue> payrouteList = RxList([]);
  RxList<DropDownValue> executiveList = RxList([]);

  Rxn<DropDownValue>? selectedClientDetails = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedLocation = Rxn<DropDownValue>(null);
  // Rx<DropDownValue>? selectedLocation =null ;
  Rxn<DropDownValue>? selectedChannel = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedAgency = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedBrandList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedPayrouteList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedExecutiveList = Rxn<DropDownValue>(null);

  TextEditingController bookingDateController = new TextEditingController();
  TextEditingController effectiveDateController = new TextEditingController();
  TextEditingController txtController = new TextEditingController();
  TextEditingController bookingRegController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ONE_SPOT_BOOKING_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('oneSpotBookingOnLoad') &&
              map['oneSpotBookingOnLoad'] != null) {
            locationList.clear();
            channelList.clear();
            if (map['oneSpotBookingOnLoad'].containsKey('lstlocationmaster') &&
                map['oneSpotBookingOnLoad']['lstlocationmaster'] != null &&
                map['oneSpotBookingOnLoad']['lstlocationmaster'].length > 0) {
              map['oneSpotBookingOnLoad']['lstlocationmaster'].forEach((e) {
                locationList.add(new DropDownValue.fromJsonDynamic(
                    e, "locationCode", "locationName"));
              });
            }
            if (map['oneSpotBookingOnLoad'].containsKey('lstchannelmaster') &&
                map['oneSpotBookingOnLoad']['lstchannelmaster'] != null &&
                map['oneSpotBookingOnLoad']['lstchannelmaster'].length > 0) {
              map['oneSpotBookingOnLoad']['lstchannelmaster'].forEach((e) {
                channelList.add(new DropDownValue.fromJsonDynamic(
                    e, "channelcode", "channelname"));
              });
            }
          } else {
            locationList.clear();
            channelList.clear();
          }
        });
  }

  // effectiveDateLeave() {
  //   if (selectedChannel != null && selectedChannel?.value != "ZEE ONE") {
  //     txtController.text = DateFormat('yyMM9000').format(
  //             DateFormat("dd-MM-yyyy").parse(effectiveDateController.text)) +
  //         "U";
  //   } else {
  //     txtController.text = DateFormat('yyMM9000').format(
  //             DateFormat("dd-MM-yyyy").parse(effectiveDateController.text)) +
  //         "Y";
  //   }
  // }

  effectiveDateLeave() {
    LoadingDialog.call();
    var bookingNo = DateFormat('yyyyMM')
        .format(DateFormat("dd-MM-yyyy").parse(effectiveDateController.text));
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ONE_SPOT_GET_TO_NUMBER(
            bookingNo ?? "",
            Get.find<MainController>().user?.logincode ?? "",
            selectedLocation?.value?.key ?? "",
            selectedChannel?.value?.key ?? ""),
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("oneSpotBookingTONumber") &&
              map['oneSpotBookingTONumber'] != null) {
            Get.back();

            txtController.text = map['oneSpotBookingTONumber'] ?? "";
          }
        });
  }

  onChannelLeave(String channelCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ONE_SPOT_BOOKING_CHANNEL_LEAVE +
            (selectedLocation?.value?.key ?? "") +
            "&channelcode=" +
            channelCode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();

          if (map is Map &&
              map.containsKey("onLeaveChannel") &&
              map['onLeaveChannel'] != null) {
            if (map['onLeaveChannel'].containsKey('lstclientmaster') &&
                map['onLeaveChannel']['lstclientmaster'] != null &&
                map['onLeaveChannel']['lstclientmaster'].length > 0) {
              // clientList.add(new DropDownValue.fromJsonDynamic(e,"clientcode","clientname") );
              selectedClient?.value = DropDownValue(
                  value: map['onLeaveChannel']['lstclientmaster'][0]
                      ['clientname'],
                  key: map['onLeaveChannel']['lstclientmaster'][0]
                      ['clientcode']);
            } else {
              selectedClient = Rxn<DropDownValue>(null);
            }
            if (map['onLeaveChannel'].containsKey('lstagencymaster') &&
                map['onLeaveChannel']['lstagencymaster'] != null &&
                map['onLeaveChannel']['lstagencymaster'].length > 0) {
              // agencyList.add(new DropDownValue.fromJsonDynamic(e,"clientcode","clientname") );
              selectedAgency?.value = DropDownValue(
                  key: map['onLeaveChannel']['lstagencymaster'][0]
                      ['agencycode'],
                  value: map['onLeaveChannel']['lstagencymaster'][0]
                      ['agencyname']);
            } else {
              selectedAgency = Rxn<DropDownValue>(null);
            }
            if (map['onLeaveChannel'].containsKey('lstbrandmaster') &&
                map['onLeaveChannel']['lstbrandmaster'] != null &&
                map['onLeaveChannel']['lstbrandmaster'].length > 0) {
              // agencyList.add(new DropDownValue.fromJsonDynamic(e,"clientcode","clientname") );
              selectedBrandList?.value = DropDownValue(
                  key: map['onLeaveChannel']['lstbrandmaster'][0]['brandcode'],
                  value: map['onLeaveChannel']['lstbrandmaster'][0]
                      ['brandname']);
            } else {
              selectedBrandList = Rxn<DropDownValue>(null);
            }
            if (map['onLeaveChannel'].containsKey('lstpayroutemaster') &&
                map['onLeaveChannel']['lstpayroutemaster'] != null &&
                map['onLeaveChannel']['lstpayroutemaster'].length > 0) {
              // agencyList.add(new DropDownValue.fromJsonDynamic(e,"clientcode","clientname") );
              selectedPayrouteList?.value = DropDownValue(
                  key: map['onLeaveChannel']['lstpayroutemaster'][0]
                      ['payRouteCode'],
                  value: map['onLeaveChannel']['lstpayroutemaster'][0]
                      ['payRouteName']);
            } else {
              selectedPayrouteList = Rxn<DropDownValue>(null);
            }
            if (map['onLeaveChannel'].containsKey('lstPersonnelMaster') &&
                map['onLeaveChannel']['lstPersonnelMaster'] != null &&
                map['onLeaveChannel']['lstPersonnelMaster'].length > 0) {
              // agencyList.add(new DropDownValue.fromJsonDynamic(e,"clientcode","clientname") );
              selectedExecutiveList?.value = DropDownValue(
                  key: map['onLeaveChannel']['lstPersonnelMaster'][0]
                      ['personnelCode'],
                  value: map['onLeaveChannel']['lstPersonnelMaster'][0]
                      ['personnelName']);
            } else {
              selectedExecutiveList = Rxn<DropDownValue>(null);
            }
            inactiveGroup.value = false;
            inactiveGroup.refresh();
            selectedExecutiveList?.refresh();
            selectedPayrouteList?.refresh();
            selectedBrandList?.refresh();
            selectedAgency?.refresh();
            selectedClient?.refresh();
          }
        });
  }

  saveBtnClick() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.value?.key ?? "",
      "channelcode": selectedChannel?.value?.key ?? "",
      "bookingdate": DateFormat('yyyy-MM-ddTHH:mm:ss').format(
              DateFormat('dd-MM-yyyy').parse(bookingDateController.text)) ??
          "2023-07-25T09:07:49.424Z",
      "effectivedate": DateFormat('yyyy-MM-ddTHH:mm:ss').format(
              DateFormat('dd-MM-yyyy').parse(effectiveDateController.text)) ??
          "2023-07-25T09:07:49.424Z",
      "bookingnumber": txtController.text ?? "",
      "clientcode": selectedClient?.value?.key ?? "",
      "agencycode": selectedAgency?.value?.key ?? "",
      "brandcode": selectedBrandList?.value?.key ?? "",
      "refno": bookingRegController.text ?? "",
      "amount": int.tryParse(
          (amountController.text != null && amountController.text != "")
              ? amountController.text
              : "0"),
      "payroutecode": selectedPayrouteList?.value?.key ?? "",
      "executivecode": selectedExecutiveList?.value?.key ?? "",
      "loggeduser": Get.find<MainController>().user?.logincode ?? ""
    };
    // print(">>>>>postData>>>"+(postData).toString());
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.ONE_SPOT_BOOKING_SAVE,
        json: postData,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("saveOSBooking") &&
              map['saveOSBooking'] != null &&
              map['saveOSBooking'].containsKey('meassage') &&
              map['saveOSBooking']['meassage'] != null) {
            LoadingDialog.callDataSavedMessage(
                map['saveOSBooking']['meassage'] ?? "", callback: () {
              clearAll();
            });
          } else {
            LoadingDialog.showErrorDialog(
                (map ?? "Something went wrong").toString());
          }
        });
  }

  @override
  void onInit() {
    fetchAllLoaderData();
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

  clearAll() {
    Get.delete<OneSpotBookingSkyMediaController>();
    Get.find<HomeController>().clearPage1();
  }

  formHandler(String string) {
    if (string == "Save") {
      saveBtnClick();
    } else if (string == "Clear") {
      clearAll();
    }
  }

  void increment() => count.value++;
}
