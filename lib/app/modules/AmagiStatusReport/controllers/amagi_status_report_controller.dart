import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class AmagiStatusReportController extends GetxController {
  //TODO: Implement AmagiStatusReportController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxString selectValue=RxString("Day Wise");
  TextEditingController fromDateController =  TextEditingController();
  TextEditingController toDateController =  TextEditingController();

  bool isDailyWise = true;
  bool isTimeBand = false;
  bool isServiced = false;
  bool isYield = false;
  bool isData = false;

  Future<void> getRadioStatus(String name)async {
    switch(name){
      case "Day Wise":
         isDailyWise = true;
         isTimeBand = false;
         isServiced = false;
         isYield = false;
         isData = false;
         break;
      case "Time Band":
        isDailyWise = false;
        isTimeBand = true;
        isServiced = false;
        isYield = false;
        isData = false;
        break;
      case "Serviced":
        isDailyWise = false;
        isTimeBand = false;
        isServiced = true;
        isYield = false;
        isData = false;
        break;
      case "Yield":
        isDailyWise = false;
        isTimeBand = false;
        isServiced = false;
        isYield = true;
        isData = false;
        break;
      case "Data":
        isDailyWise = false;
        isTimeBand = false;
        isServiced = false;
        isYield = false;
        isData = true;
        break;
    }
  }

  PlutoGridStateManager? stateManager;
  List<Map<String,Map<String, double>>>? userGridSetting1;

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  fetchAllLoaderData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.Amagi_Status_Report_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
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
          closeDialogIfOpen();
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
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Map<String, dynamic> responseData = {'response': []};
  String convertDate(String date) {
    return (DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(DateFormat('dd-MM-yyyy').parse(date)));
  }
  retrieveData() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationCode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "fromDate": convertDate(fromDateController.text)?? "",
      "toDate": convertDate(toDateController.text)?? "",
      "optDayWise": isDailyWise,
      "optTimeBand": isTimeBand,
      "optServiced": isServiced,
      "optyield": isYield,
      "optData": isData
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.Amagi_Status_Report_RetrieveData,
        json: postData,
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey('response') &&
              map['response'] != null &&  map['response'].length >0) {
            responseData = map as Map<String, dynamic>;

            for(int j=0;j<responseData['response'].length ;j++){
              List<String> keys = responseData['response'][j].keys.toList();
              print(">>>keys"+keys.toString());
              for(int i=0;i<keys.length;i++){
                if(
                    responseData['response'][j][keys[i]].toString().trim() == "{}"){
                  print(">>>>>>>>map"+responseData['response'][j][keys[i]].toString());
                  responseData['response'][j][keys[i]] = "";
                }
              }
            }

            update(['grid']);
          } else {
            responseData = {'response': []};
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

  @override
  void onClose() {
    super.onClose();
  }
  formHandler(String str) {
    if(str == "Exit"){
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [
            stateManager
          ]);
    }

  }
  void increment() => count.value++;
}
