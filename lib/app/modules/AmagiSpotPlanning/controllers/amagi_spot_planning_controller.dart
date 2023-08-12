import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class AmagiSpotPlanningController extends GetxController {


  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxString selectValue = RxString("");

  TextEditingController scheduleDateController = TextEditingController();
  bool isMasterSpots = false;
  bool isChannel = false;
  bool isClient = false;
  bool isData = false;

  fetchAllLoaderData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Amagi_Spot_Planning_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          locationList.clear();
          if (map is Map &&
              map.containsKey('location') &&
              map['location'] != null) {
            map['location'].forEach((e) {
              locationList.add(DropDownValue.fromJsonDynamic(
                  e, "locationCode", "locationName"));
            });
          }
        });
  }

  getChannel(String locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Amagi_Spot_Planning_Get_Channel + locationCode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          channelList.clear();
          if (map is Map &&
              map.containsKey('channel') &&
              map['channel'] != null) {
            map['channel'].forEach((e) {
              channelList.add(new DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
          }
        });
  }

  Future<void> getRadioType(String radioName) async {
    switch (radioName) {
      case "Master Spots":
        isMasterSpots = true;
        isChannel = false;
        isClient = false;
        isData = false;
        break;
      case "Channel":
        isMasterSpots = false;
        isChannel = true;
        isClient = false;
        isData = false;
        break;
      case "Client":
        isMasterSpots = false;
        isChannel = false;
        isClient = true;
        isData = false;
        break;
      case "Data":
        isMasterSpots = false;
        isChannel = false;
        isClient = false;
        isData = true;
        break;
    }
  }

  String convertDate(String date) {
    return (DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd-MM-yyyy').parse(date)));
  }

  Map<String, dynamic> responseData = {'report': []};
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  generateBtn() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationCode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "scheduleDate": convertDate(scheduleDateController.text),
      "isMasterSpots": isMasterSpots,
      "isChannel": isChannel,
      "isClient": isClient,
      "isData": isData
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.Amagi_Spot_Planning_Get_Generate,
        json: postData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey('report') &&
              map['report'] != null) {
            responseData = map as Map<String, dynamic>;
            update(['grid']);
          } else {
            responseData = {'report': []};
            update(['grid']);
          }
        });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchAllLoaderData();
    super.onReady();
  }

  formHandler(String string) {}

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
