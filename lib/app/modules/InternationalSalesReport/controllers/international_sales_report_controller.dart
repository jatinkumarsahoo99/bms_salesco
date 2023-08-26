import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../InternationalSalesReportModel.dart';

class InternationalSalesReportController extends GetxController {
  //TODO: Implement InternationalSalesReportController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;

  RxString selectValue=RxString("Detail");

  TextEditingController fromDateController = TextEditingController() ;
  TextEditingController toDateController = TextEditingController() ;
  bool isSummary = false;
  getRadioStatus(String val){
    switch(val){
      case "Detail":
        isSummary = false;
        break;
      case "Summary":
        isSummary = true;
        break;
      default:
        isSummary = false;
    }
  }
  InternationalSalesReportModel? internationalSalesReportModel = InternationalSalesReportModel(report:Report(internationalDetails: []) );
  callBtnGenerate(){
    LoadingDialog.call();
    internationalSalesReportModel = InternationalSalesReportModel(report:Report(internationalDetails: [],internationalSalesSummary: []) );
    Map<String, dynamic> postData = {
      "fromDate":  DateFormat('yyyy-MM-dd').format(DateFormat("dd-MM-yyyy").parse(fromDateController.text)) ??"",
      "ToDate": DateFormat('yyyy-MM-dd').format(DateFormat("dd-MM-yyyy").parse(toDateController.text)) ??"",
      "isSummary":isSummary
      // "ClientName": "PROCTER%26GAMBLH%26HMUM",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.INTERNATIONAL_SALES_REPORT_GENERATE,
        json: postData,
        fun: ( map) {
          Get.back();
          if(map is Map && map.containsKey('report') && map['report'] != null){
            if(map['report'].containsKey('internationalDetails') && map['report'].containsKey('internationalSalesSummary')
            ){
              internationalSalesReportModel = InternationalSalesReportModel.fromJson(map as Map<String,dynamic>) ;
              update(['grid']);
            }else{
              internationalSalesReportModel = InternationalSalesReportModel(report:Report(internationalDetails: [],internationalSalesSummary: []) );
              update(['grid']);
            }
          }else{
            internationalSalesReportModel = InternationalSalesReportModel(report:Report(internationalDetails: [],internationalSalesSummary: []) );
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
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
