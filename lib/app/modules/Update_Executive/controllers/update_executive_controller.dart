import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class UpdateExecutiveController extends GetxController {
  //TODO: Implement UpdateExecutiveController

  bool isEnable = true;
  final count = 0.obs;
  var clientDetails = RxList<DropDownValue>();


  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> zoneList = RxList([]);
  RxList<DropDownValue> correctExecutiveNameList = RxList([]);

  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();



  Rxn<DropDownValue>? selectedLocation = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedChannel = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedClient = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedAgency = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedZone = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedCorrectExecutiveName = Rxn<DropDownValue>(null);
  int selectedIndex = 0;

  FocusNode locationNode = FocusNode();
  FocusNode channelNode = FocusNode();
  FocusNode clientNode = FocusNode();
  FocusNode agencyNode = FocusNode();
  FocusNode zoneNode = FocusNode();
  FocusNode executiveNamNode = FocusNode();
  FocusNode selectAllNode = FocusNode();
  FocusNode btnNode = FocusNode();

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.UPDATE_EXECUTIVE_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          locationList.clear();
          channelList.clear();
          agencyList.clear();
          correctExecutiveNameList.clear();
          if(map is Map && map.containsKey('updateExecutiveOnload') && map['updateExecutiveOnload'] != null){

            if( map['updateExecutiveOnload'].containsKey('lstlocationmaster') &&
                map['updateExecutiveOnload'] ['lstlocationmaster'] != null &&
                map['updateExecutiveOnload'] ['lstlocationmaster'].length >0  ){
              map['updateExecutiveOnload']['lstlocationmaster'].forEach((e){
                locationList.add(DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
            }
            if( map['updateExecutiveOnload'].containsKey('lstchannelmaster') &&
                map['updateExecutiveOnload'] ['lstchannelmaster'] != null &&
                map['updateExecutiveOnload'] ['lstchannelmaster'].length >0  ){
              map['updateExecutiveOnload']['lstchannelmaster'].forEach((e){
                channelList.add(DropDownValue.fromJsonDynamic(e, "channelcode", "channelname"));
              });
            }
            if( map['updateExecutiveOnload'].containsKey('lstzonemaster') &&
                map['updateExecutiveOnload'] ['lstzonemaster'] != null &&
                map['updateExecutiveOnload'] ['lstzonemaster'].length >0  ){
              map['updateExecutiveOnload']['lstzonemaster'].forEach((e){
                zoneList.add(DropDownValue.fromJsonDynamic(e, "zonecode", "zonename"));
              });
            }
            if( map['updateExecutiveOnload'].containsKey('lstexecutive') &&
                map['updateExecutiveOnload'] ['lstexecutive'] != null &&
                map['updateExecutiveOnload'] ['lstexecutive'].length >0  ){
              map['updateExecutiveOnload']['lstexecutive'].forEach((e){
                correctExecutiveNameList.add(DropDownValue.fromJsonDynamic(e, "personnelCode", "personnelName"));
              });
            }
          }
          else{
            locationList.clear();
            channelList.clear();
            agencyList.clear();
            correctExecutiveNameList.clear();
          }

        });
  }

  getClientList(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "locationcode":selectedLocation?.value?.key??"",
      "channelcode":selectedChannel?.value?.key??""
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM (
        api: ApiFactory.UPDATE_EXECUTIVE_GET_CLIENT,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          Get.back();
          clientList.clear();
          if(map is Map && map.containsKey('client') && map['client'] != null && map['client'].length >0 ){
            RxList<DropDownValue> dataList = RxList([]);
            map['client'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(e, "clientcode", "clientname"));
            });
            clientList.addAll(dataList);
            selectedClient?.value = null;
            selectedClient?.refresh();
          }else{
            clientList.clear();
          }
        });
  }

  getAgencyList(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "locationcode":selectedLocation?.value?.key??"",
      "channelcode":selectedChannel?.value?.key??"",
      "clientcode":selectedClient?.value?.key??"",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM (
        api: ApiFactory.UPDATE_EXECUTIVE_GET_AGENCY,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          Get.back();
          agencyList.clear();
          if(map is Map && map.containsKey('agency') && map['agency'] != null && map['agency'].length >0 ){
            map['agency'].forEach((e){
              agencyList.add(DropDownValue.fromJsonDynamic(e, "agencycode", "agencyname"));
            });
            selectedAgency?.value = null;
            selectedAgency?.refresh();
          }else{
            agencyList.clear();
          }
        });
  }
  VerifyDataModel? verifyDataModel;
  Rx<bool> selectAll = Rx<bool>(false);

  selectAllList(){
    if(selectAll.value == true){
      if(verifyDataModel != null &&
          verifyDataModel?.verifiy != null &&
          ( (verifyDataModel?.verifiy?.length??0) >0)  ){
        verifyDataModel?.verifiy?.forEach((element) {
          if(element.isChecked == false){
            element.isChecked = true;
          }
        });
      }
      update(['grid']);
    }else{
      if(verifyDataModel != null &&
          verifyDataModel?.verifiy != null &&
          ( (verifyDataModel?.verifiy?.length??0) >0)  ){
        verifyDataModel?.verifiy?.forEach((element) {
          if(element.isChecked == true){
            element.isChecked = false;
          }
        });
      }
      update(['grid']);
    }

  }

  // List<FocusNode> listOfNode = [];
  getVerify(){
    LoadingDialog.call();
    Map<String,dynamic> sendData = {
      "locationcode":selectedLocation?.value?.key??"",
      "channelcode":selectedChannel?.value?.key??"",
      "clientcode":selectedClient?.value?.key??"",
      "zonecode":selectedZone?.value?.key??"",
      "bookingeffectivefromdate":date1Controller.text??"",
      "bookingeffectiveTodate":date2Controller.text??"",
      "agencycode":selectedAgency?.value?.key??"",
    };
    Get.find<ConnectorControl>().POSTMETHOD (
        api: ApiFactory.UPDATE_EXECUTIVE_GET_VERIFY,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          Get.back();
          if(map is Map && map.containsKey("verifiy") &&
              map['verifiy'] != null && map['verifiy'].length >0){
            // listOfNode.clear();
            verifyDataModel = VerifyDataModel.fromJson(map as Map<String,dynamic>);
            // listOfNode = List.generate((verifyDataModel?.verifiy?.length??0), (index) => FocusNode());
            update(['grid']);
          }else{
            verifyDataModel = null;
            update(['grid']);
          }

        });
  }

  upDateExecutive(){
    LoadingDialog.call();
    Map<String,dynamic> postData = {
      "executivecode": selectedCorrectExecutiveName?.value?.key??"",
    "locationcode":selectedLocation?.value?.key?? "",
    "channelcode":selectedChannel?.value?.key?? "",
    "lstchktonumber": verifyDataModel?.verifiy?.map((e) => e.toJson1()).toList()
  };
    Get.find<ConnectorControl>().POSTMETHOD (
        api: ApiFactory.UPDATE_EXECUTIVE_UPDATE_EXECUTIVE,
        json: postData,
        // "https://jsonkeeper.com/b/D537"
        fun: ( map) {
          Get.back();
          if(map is Map && map.containsKey("client") && map['client'] != null){
            LoadingDialog.callDataSavedMessage(map['client']??"",callback: (){
              clearAll();
            });
          }else{
            LoadingDialog.showErrorDialog((map??"Something went wrong").toString());
          }
        });

}
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  @override
  void onInit() {
    fetchAllLoaderData();
    super.onInit();
  }
  formHandler(String string){
     if(string == "Clear"){
    clearAll();
    }else if(string == "Update Executive"){
       upDateExecutive();
     }
  }
  clearAll() {
    Get.delete<UpdateExecutiveController>();
    Get.find<HomeController>().clearPage1();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
     /*locationNode.dispose();
     channelNode.dispose();
     clientNode.dispose();
     agencyNode.dispose() ;
     zoneNode.dispose() ;
     executiveNamNode .dispose();*/
    super.onClose();
  }

  void increment() => count.value++;
}

class VerifyDataModel {
  List<Verifiy>? verifiy;

  VerifyDataModel({this.verifiy});

  VerifyDataModel.fromJson(Map<String, dynamic> json) {
    if (json['verifiy'] != null) {
      verifiy = <Verifiy>[];
      json['verifiy'].forEach((v) {
        verifiy!.add(new Verifiy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifiy != null) {
      data['verifiy'] = this.verifiy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verifiy {
  String? bookingnumber;
  bool? isChecked = false;

  Verifiy({this.bookingnumber,this.isChecked});

  Verifiy.fromJson(Map<String, dynamic> json) {
    bookingnumber = json['bookingnumber'];
    isChecked = json['isChecked']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingnumber'] = this.bookingnumber;
    data['isChecked'] = this.isChecked??false;
    return data;
  }
  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingnumber'] = this.bookingnumber;
    return data;
  }
}
