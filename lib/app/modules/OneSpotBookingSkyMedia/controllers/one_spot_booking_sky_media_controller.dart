import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class OneSpotBookingSkyMediaController extends GetxController {
  //TODO: Implement OnSpotBookingSkyMediaController

  bool isEnable = true;
  final count = 0.obs;
  var clientDetails = RxList<DropDownValue>();
  DropDownValue? selectedClientDetails;
  DropDownValue? selectedClient;
  DropDownValue? selectedProduct;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> clientList = RxList([]);
  RxList<DropDownValue> agencyList = RxList([]);
  RxList<DropDownValue> brandList = RxList([]);
  RxList<DropDownValue> payrouteList = RxList([]);
  RxList<DropDownValue> executiveList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  TextEditingController bookingDateController = new TextEditingController();
  TextEditingController effectiveDateController = new TextEditingController();
  TextEditingController txtController = new TextEditingController();
  TextEditingController bookingRegController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('periodicDealUtilisationOnLoad') &&
              map['periodicDealUtilisationOnLoad'] != null) {
            locationList.clear();
            channelList.clear();
            if(map['periodicDealUtilisationOnLoad'].containsKey('lstlocationmaster') &&
                map['periodicDealUtilisationOnLoad']['lstlocationmaster'] != null &&
                map['periodicDealUtilisationOnLoad']['lstlocationmaster'].length >0
            ){
              map['periodicDealUtilisationOnLoad']['lstlocationmaster'].forEach((e){
                locationList.add(new DropDownValue.fromJsonDynamic(e, "locationCode", "locationName"));
              });
            }
            if(map['periodicDealUtilisationOnLoad'].containsKey('lstchannelmaster') &&
                map['periodicDealUtilisationOnLoad']['lstchannelmaster'] != null &&
                map['periodicDealUtilisationOnLoad']['lstchannelmaster'].length >0
            ){
              map['periodicDealUtilisationOnLoad']['lstchannelmaster'].forEach((e){
                locationList.add(new DropDownValue.fromJsonDynamic(e, "channelcode", "channelname"));
              });
            }
          }else{
            locationList.clear();
            channelList.clear();
          }
        });
  }

  effectiveDateLeave(){
    if(selectedChannel != null && selectedChannel?.value != "ZEE ONE" ){

    }else{

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
  formHandler(String string){}
  void increment() => count.value++;
}
