import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../DealRecoSummaryModel.dart';

class DealRecoSummaryController extends GetxController {
  //TODO: Implement DealRecoSummaryController
  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> dealNoList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedDealNo;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController utilAsOnDateController = TextEditingController();

  FocusNode dealNoFocusNode = FocusNode();
  bool isFocusActive = false;


  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ASRUN_DETAILS_REPORT_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('pageload') && map['pageload'] != null){
            locationList.clear();
            channelList.clear();
            if( map['pageload'].containsKey('locations') &&
                map['pageload'] ['locations'] != null &&
                map['pageload'] ['locations'].length >0  ){
              map['pageload']['locations'].forEach((e){
                locationList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
            }
            if( map['pageload'].containsKey('channels') &&
                map['pageload'] ['channels'] != null &&
                map['pageload'] ['channels'].length >0  ){
              map['pageload']['channels'].forEach((e){
                channelList.add(DropDownValue.fromJsonDynamic(e, "channelCode", "channelName"));
              });
            }
          }

        });
  }

  fetchClient(String locationName){
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_CLIENT+locationName,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('client') && map['client'] != null && map['client'].length > 0){
            clientList.clear();
              map['client'].forEach((e){
                clientList.add(DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
              });
          }

        });

  }

  fetchAgency(){
    Map<String, dynamic> postData = {
      "LocationName": selectedLocation?.value??"",
      "ChannelName": ((selectedChannel?.value)??""),
      "ClientName": ((selectedClient?.value)??""),
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_AGENCY,
        json: postData,
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('agency') && map['agency'] != null && map['agency'].length > 0){
            agencyList.clear();
            map['agency'].forEach((e){
              agencyList.add(DropDownValue.fromJsonDynamic(e, "agencycode", "agencyname"));
            });
          }

        });
  }

  leaveDealNo(){
    Map<String, dynamic> postData = {
      "locationname": selectedLocation?.value??"",
      "channelname": ((selectedChannel?.value)??""),
      "dealnumber": ((selectedDealNo?.value)??""),
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_DEAL_LEAVE,
        json: postData,
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('dealleave') && map['dealleave'] != null &&
              map['dealleave'].length > 0){
            fromDateController.text = DateFormat('dd-MM-yyyy').format (DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['dealleave'][0]['fromdate']) );
            toDateController.text = DateFormat('dd-MM-yyyy').format (DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['dealleave'][0]['todate']) );
          }
        });
  }

  fetchADealNo(){
    Map<String, dynamic> postData = {
      "LocationName": selectedLocation?.value??"",
      "ChannelName": ((selectedChannel?.value)??""),
      "ClientName": ((selectedClient?.value)??""),
      // "ClientName": "PROCTER%26GAMBLH%26HMUM",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GET_DEAL,
        json: postData,
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('deal') && map['deal'] != null && map['deal'].length > 0){
            dealNoList.clear();
            map['deal'].forEach((e){
              dealNoList.add(DropDownValue.fromJsonDynamic(e, "dealnumber1", "dealNumber"));
            });
          }

        });
  }

  DealRecoSummaryModel? dealRecoSummaryModel;
  callGenerate(){
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key??"",
      "channelcode": (selectedChannel?.key)??"",
      "dealnumber": (selectedDealNo?.value)??"",
      "FROMDATE": DateFormat('dd-MMM-yyyy').format(DateFormat('dd-MM-yyyy').parse( fromDateController.text))??"",
      "TODATE": DateFormat('dd-MMM-yyyy').format(DateFormat('dd-MM-yyyy').parse( toDateController.text))??"",
      // "ClientName": "PROCTER%26GAMBLH%26HMUM",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_RECO_SUMMARY_GENERATE,
        json: postData,
        fun: ( map) {
          Get.back();
          print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey('gentare') && map['gentare'] != null && map['gentare'].length > 0){
            dealRecoSummaryModel = DealRecoSummaryModel.fromJson(map as Map<String,dynamic>) ;
            update(['grid']);
          }else{
            dealRecoSummaryModel = null;
            update(['grid']);
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
  formHandler(String string) {

  }

  void increment() => count.value++;
}
