import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class GeoProgramUpdateController extends GetxController {
  //TODO: Implement GeoProgramUpdateController
  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  TextEditingController formDateController = new TextEditingController();
  TextEditingController toDateController = new TextEditingController();

  final count = 0.obs;

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.GEO_PROGRAM_UPDATE_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          locationList.clear();
          channelList.clear();
          if (map is Map &&
              map.containsKey('geoProgramUpdateOnload') &&
              map['geoProgramUpdateOnload'] != null) {
            if (map['geoProgramUpdateOnload']['lstLocation'] != null &&
                map['geoProgramUpdateOnload']['lstLocation'].length > 0) {
              map['geoProgramUpdateOnload']['lstLocation'].forEach((e) {
                locationList.add(DropDownValue.fromJsonDynamic(
                    e, "locationCode", "locationName"));
              });
            }
            if (map['geoProgramUpdateOnload']['lstChannel'] != null &&
                map['geoProgramUpdateOnload']['lstChannel'].length > 0) {
              map['geoProgramUpdateOnload']['lstChannel'].forEach((e) {
                channelList.add(DropDownValue.fromJsonDynamic(
                    e, "channelcode", "channelname"));
              });
            }
          } else {
            locationList.clear();
            channelList.clear();
          }
        });
  }

  updateAPICall(){
    if(selectedLocation == null){
      LoadingDialog.showErrorDialog("Please select location");
    }else if(selectedChannel == null){
      LoadingDialog.showErrorDialog("Please select channel");
    }else{
      LoadingDialog.call();
      Map<String, dynamic> postData = {
        "locationcode": selectedLocation?.key??"",
        "channelcode":selectedChannel?.key?? "",
        "scheduleFromdate":DateFormat('yyyy-MM-dd').format(DateFormat("dd-MM-yyyy").parse(formDateController.text)) ??"",
        "scheduleTodate":DateFormat('yyyy-MM-dd').format(DateFormat("dd-MM-yyyy").parse(toDateController.text)) ??""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.GEO_PROGRAM_UPDATE_UPDATE,
          json: postData,
          fun: (map){
            Get.back();
            print(">>>>"+map.toString());
            if(map is Map && map.containsKey("update") && map['update'] != null){
              LoadingDialog.callDataSavedMessage(map['update']??"");
            }else{
              LoadingDialog.showErrorDialog((map??"Some thing went wrong").toString());
            }
          });
    }

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
  clearAll(){
    Get.delete<GeoProgramUpdateController>();
    Get.find<HomeController>().clearPage1();
  }
  void increment() => count.value++;

  formHandler(String btn) {
    if(btn == "Update"){
      updateAPICall();
    }if(btn == "Clear"){
      // print("clear call");
      clearAll();
    }
  }
}
