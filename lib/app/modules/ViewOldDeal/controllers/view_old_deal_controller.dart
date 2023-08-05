import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../providers/ApiFactory.dart';
import '../ViewOldDealResponseModel.dart';

class ViewOldDealController extends GetxController {
  //TODO: Implement ViewOldDealController

  final count = 0.obs;

  RxList<DropDownValue> executiveList = RxList([]);
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> dealNoList = RxList([]);

  Rxn<DropDownValue> selectedExecutiveList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedLocationList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedChannelList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedClientList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedAgencyList = Rxn<DropDownValue>(null);
  Rxn<DropDownValue> selectedDealNoList = Rxn<DropDownValue>(null);

  TextEditingController dateController = TextEditingController();
  TextEditingController dealPeriodFromController = TextEditingController();
  TextEditingController toDateFromController = TextEditingController();
  TextEditingController dealAmountController = TextEditingController();
  TextEditingController totalDealDurationController = TextEditingController();

  FocusNode executiveNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode channelNode = FocusNode();
  FocusNode clientNode = FocusNode();
  FocusNode agencyNode = FocusNode();
  FocusNode dealNoNode = FocusNode();

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.ViewOldDeals_LOAD,
        fun: (map) {
          locationList.clear();
          channelList.clear();
          executiveList.clear();
          if(map is Map && map.containsKey("pageload") &&
              map['pageload'] != null ){
            if(map['pageload'].containsKey('lstlocations') &&
                map['pageload']['lstlocations'] != null && map['pageload']['lstlocations'].length > 0 ){
              RxList<DropDownValue>? dataList = RxList([]);
              map['pageload']['lstlocations'].forEach((e){
                dataList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
              locationList.addAll(dataList);
            }

            if(map['pageload'].containsKey('lstchannels') &&
                map['pageload']['lstchannels'] != null &&
                map['pageload']['lstchannels'].length > 0){
              RxList<DropDownValue>? dataList = RxList([]);
              map['pageload']['lstchannels'].forEach((e){
                dataList.add(DropDownValue.fromJsonDynamic(e, "channelCode", "channelName"));
              });
              channelList.addAll(dataList);
            }
            if(map['pageload'].containsKey('lstpersonnelmaster') &&
                map['pageload']['lstpersonnelmaster'] != null &&
                map['pageload']['lstpersonnelmaster'].length > 0){
              RxList<DropDownValue>? dataList = RxList([]);
              map['pageload']['lstpersonnelmaster'].forEach((e){
                dataList.add(DropDownValue.fromJsonDynamic(e, "personnelcode", "executivename"));
              });
              executiveList.addAll(dataList);
            }
          }
        });
  }

  getClient(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "executivecode":selectedExecutiveList.value?.key??"",
      "location":selectedLocationList.value?.value??"",
      "channel":selectedChannelList.value?.value??""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.ViewOldDeals_GET_CLIENT,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          clientList.clear();
          print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey("client") && map['client'] != null && map['client'].length >0){
            RxList<DropDownValue>? dataList = RxList([]);
            map['client'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
            });
            clientList = dataList;
          }
        });
  }

  getAgency(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "executivecode":selectedExecutiveList.value?.key??"",
      "location":selectedLocationList.value?.value??"",
      "channel":selectedChannelList.value?.value??"",
      "client":selectedClientList.value?.value??""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.ViewOldDeals_GET_AGENCY,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          agencyList.clear();
          print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey("agency") && map['agency'] != null && map['agency'].length >0){
            RxList<DropDownValue>? dataList = RxList([]);
            map['agency'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(e, "agencyCode", "agencyname"));
            });
            agencyList = dataList;
          }
        });
  }

  getDeal(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "agencycode":selectedAgencyList.value?.key??"",
      "locationcode":selectedLocationList.value?.key??"",
      "channelcode":selectedChannelList.value?.key??"",
      "clientcode":selectedClientList.value?.key??""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.ViewOldDeals_GET_DEAL,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          dealNoList.clear();
          print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey("deal") && map['deal'] != null && map['deal'].length >0){
            RxList<DropDownValue>? dataList = RxList([]);
            map['deal'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(e, "dealNumber", "dealnumber1"));
            });
            dealNoList = dataList;
          }
        });
  }
  ViewOldDealResponseModel? viewOldDealResponseModel = ViewOldDealResponseModel(deal:
  Deal(lstdealmaster: [],lstdealusage: []) );

  String convertDateFromat(String date){
   return  DateFormat('dd-MM-yyyy').format( DateFormat('yyyy-MM-ddTHH:mm:ss').
    parse(date));
  }

  dealLeaveNo(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "locationcode":selectedLocationList.value?.key??"",
      "channelcode":selectedChannelList.value?.key??"",
      "dealno":selectedDealNoList.value?.key??""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.ViewOldDeals_GET_DEAL_LEAVE,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          if(map is Map && map.containsKey('deal') && map['deal'] != null){
            viewOldDealResponseModel = ViewOldDealResponseModel.fromJson(map as Map<String,dynamic>);
            if(viewOldDealResponseModel?.deal?.lstdealmaster != null &&
                (viewOldDealResponseModel?.deal?.lstdealmaster?.length??0 )>0 ){
              if( (viewOldDealResponseModel?.deal?.
              lstdealmaster?[0].fromDate != null &&
                  viewOldDealResponseModel?.deal?.lstdealmaster?[0].fromDate != "")){
                dealPeriodFromController.text = convertDateFromat(viewOldDealResponseModel?.deal?.lstdealmaster?[0].fromDate??"");
              }
              if( (viewOldDealResponseModel?.deal?.
              lstdealmaster?[0].todate != null &&
                  viewOldDealResponseModel?.deal?.lstdealmaster?[0].todate != "")){
                toDateFromController.text = convertDateFromat(viewOldDealResponseModel?.deal?.lstdealmaster?[0].todate??"");
              }
              dealAmountController.text = (viewOldDealResponseModel?.deal?.lstdealmaster?[0].dealamount??"0").toString();
              totalDealDurationController.text =(viewOldDealResponseModel?.deal?.lstdealmaster?[0].seconds??"0").toString();

            }
            update(['ref']);
          }
          else{
            viewOldDealResponseModel = ViewOldDealResponseModel(deal:
            Deal(lstdealmaster: [],lstdealusage: []) );
            update(['ref']);
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

  void increment() => count.value++;
}
