import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class PeriodicDealUtilisationFormat2Controller extends GetxController {
  //TODO: Implement PeriodicDealUtilisationFormat2Controller

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> dealNoList = RxList([]);

  Rxn<DropDownValue>? selectedLocation = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedChannel = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedAgency= Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedDealNo = Rxn<DropDownValue>(null);

  TextEditingController utilAsOnDateController = TextEditingController();
  TextEditingController utilAsOnDateToDateController = TextEditingController();
  TextEditingController dealPeriodController = TextEditingController();
  TextEditingController dealPeriodToController = TextEditingController();
  TextEditingController dealAmountController = TextEditingController();

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PERIODIC_DEAL_UTILISATION_FORMAT2_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('periodicDealUtilisationOnLoad') && map['periodicDealUtilisationOnLoad'] != null){
            locationList.clear();
            channelList.clear();
            if( map['periodicDealUtilisationOnLoad'].containsKey('lstlocationmaster') &&
                map['periodicDealUtilisationOnLoad'] ['lstlocationmaster'] != null &&
                map['periodicDealUtilisationOnLoad'] ['lstlocationmaster'].length >0  ){
              map['periodicDealUtilisationOnLoad']['lstlocationmaster'].forEach((e){
                locationList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
            }
            if( map['periodicDealUtilisationOnLoad'].containsKey('lstchannelmaster') &&
                map['periodicDealUtilisationOnLoad'] ['lstchannelmaster'] != null &&
                map['periodicDealUtilisationOnLoad'] ['lstchannelmaster'].length >0  ){
              map['periodicDealUtilisationOnLoad']['lstchannelmaster'].forEach((e){
                channelList.add(DropDownValue.fromJsonDynamic(e, "channelcode", "channelname"));
              });
            }
          }

        });
  }

  getOnChannelLeave(){
    LoadingDialog.call();
    Map<String,dynamic> postData = {
      "Locationcode":selectedLocation?.value?.key?? "",
      "channelcode":selectedChannel?.value?.key??"",
      "LoginCode":Get.find<MainController>().user?.logincode ?? ""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM (
        api: ApiFactory.PERIODIC_DEAL_UTILISATION_FORMAT2_ON_CHANNEL_LEAVE,
        json: postData,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          Get.back();
          clientList.clear();
          if(map is Map && map.containsKey("onLeaveLocation") && map['onLeaveLocation'] != null
              && map['onLeaveLocation'].length >0){
            map['onLeaveLocation'].forEach((e){
              clientList.add(DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
            }) ;
          }else{
            clientList.clear();
          }
          // print(">>>>>>"+map.toString());
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
  formHandler(String string) {

  }
  void increment() => count.value++;
}
