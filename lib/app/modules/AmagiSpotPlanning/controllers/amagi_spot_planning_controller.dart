import 'dart:convert';

import 'package:bms_salesco/app/providers/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class AmagiSpotPlanningController extends GetxController {


  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxString selectValue = RxString("Master Spots");

  TextEditingController scheduleDateController = TextEditingController();
  bool isMasterSpots = true;
  bool isChannel = false;
  bool isClient = false;
  bool isData = false;

  PlutoGridStateManager? stateManager;
  List<Map<String,Map<String, double>>>? userGridSetting1;

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

/*  Map<String,double> getGridWidthByKey(String? key,List<Map<String,Map<String, double>>>? userGridSettingList){
    Map<String,double> gridWidths = {};
    if((userGridSettingList?.length??0) > 0){
      for(int i=0;i< (userGridSettingList?.length??0) ;i++){
        if(((userGridSettingList?[i].keys.toList())??[]).contains(key??"")){
          gridWidths = userGridSettingList?[i][key] as Map<String ,double>;
          break;
        }else{
          continue;
        }
      }
      print(">>>>>>>>>>>>>ifgridWidths"+gridWidths.toString());
      return gridWidths;
    }else{
      print(">>>>>>>>>>>>>elsegridWidths"+gridWidths.toString());
      return gridWidths;
    }
  }*/

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

  String getTableNo(String ? key){
    switch(key){
      case "Master Spots":
        return "tbl1";
        break;
      case "Channel":
        return "tbl2";
        break;
      case "Client":
        return "tbl3";
        break;
      case "Data":
        return "tbl4";
        break;
      default:
        return "tbl1";
        break;
    }
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

            List<Map<String, dynamic>> mapData = [];
            for (Map<String, dynamic> element in map['report']) {
              Map<String, dynamic> mapDa = {};
              element.forEach((key, value) {
                String k = key.toString().trim().replaceAll("\n", " ");
                if((value == 0 || value == "0") && ((key.toString().toLowerCase().contains("rate")) == false) &&
                    (key != "SpotAmount" ) &&
                    (key != "ValueAmount") ){
                  mapDa[k] = "";
                }else if(key.toString().trim().toLowerCase().contains(("ScheduleDate").toLowerCase().trim()) == true){
                  mapDa[k] = Utils.formatDateTime3(value);
                }else{
                  mapDa[k] = value;
                }
              });
              mapData.add(mapDa);
            }
            responseData={'report': mapData??[]};

            // responseData = map as Map<String, dynamic>;

            update(['grid']);
          } else {
            responseData = {'report': []};
            update(['grid']);
          }
        });
  }



  @override
  void onInit() {
    fetchUserSetting1();
    super.onInit();
  }

  @override
  void onReady() {
    fetchAllLoaderData();
    super.onReady();
  }
  clearAll() {
    Get.delete<AmagiSpotPlanningController>();
    Get.find<HomeController>().clearPage1();
  }

  formHandler(String str) {
    if(str == 'Exit'){
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager
          ],tableNamesList: [getTableNo(selectValue.value)??'tbl1']);
    }else if (str == "Clear") {
      clearAll();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
