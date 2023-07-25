import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../AsrunDetailsReportModel.dart';
import '../ChannelListModel.dart';

class AsrunDetailsReportController extends GetxController {
  //TODO: Implement AsrunDetailsReportController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  // RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  List<ChannelListModel> channelList = [];
  RxBool checked = RxBool(false);

  TextEditingController frmDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  AsrunDetailsReportModel ?asrunDetailsReportModel;


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
                channelList.add(new ChannelListModel(ischecked:false ,
                    channelName:e['channelName'] ,
                    channelCode:e['channelCode'] ));
              });
              update(['updateList']);
            }
          }

        });
  }
  clearAll(){
    Get.delete<AsrunDetailsReportController>();
    Get.find<HomeController>().clearPage1();
  }

  fetchGetGenerate(){
    List<ChannelListModel> channelListFilter=[];
    channelListFilter = channelList.where((element) =>
    element.ischecked == true).toList();
    if(selectedLocation == null){
      LoadingDialog.showErrorDialog("Please select location");
    }else if(channelListFilter.isEmpty){
      LoadingDialog.showErrorDialog("Please select some channel");
    }else if(frmDate.text == null || frmDate.text == ""){
      LoadingDialog.showErrorDialog("Please select from date");
    }else if(toDate.text == null || toDate.text == ""){
      LoadingDialog.showErrorDialog("Please select to date");
    }else{
      LoadingDialog.call();
      Map<String,dynamic> postData = {
        "lstChannelList": channelListFilter.map((e) => e.toJson()).toList(),
        "locationcode": selectedLocation!.key??"",
        // "channelCode": selectLocation!.key??"",
        "telecastdate":DateFormat('yyyy-MM-ddTHH:mm:ss').format(
            DateFormat("dd-MM-yyyy").parse(frmDate.text)),
        "todate": DateFormat('yyyy-MM-ddTHH:mm:ss').format(
            DateFormat("dd-MM-yyyy").parse(toDate.text)),
      };
      // print(">>>>>postData>>>"+(postData).toString());
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.ASRUN_DETAILS_REPORT_GENERATE,
          json: postData,
          fun: (map) {
            Get.back();
            print("map>>>"+ jsonEncode(map).toString());
            if(map is Map && map.containsKey('generate') && map['generate'] != null
                && map['generate'].length >0 ){
              asrunDetailsReportModel = AsrunDetailsReportModel.fromJson(map as Map<String,dynamic>);
              update(['grid']);
            }else{
              asrunDetailsReportModel = null;
              update(['grid']);
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
  formHandler(String string) {
    if (string == "Clear") {
      clearAll();
    }
  }
  void increment() => count.value++;
}
