import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/deal_reco_summary_controller.dart';

class DealRecoSummaryView extends GetView<DealRecoSummaryController> {
   DealRecoSummaryView({Key? key}) : super(key: key);

   DealRecoSummaryController controllerX =
   Get.put<DealRecoSummaryController>(DealRecoSummaryController());

   final GlobalKey rebuildKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: rebuildKey,
      body: Center(
        child: SizedBox(
          // width: size.width * 0.74,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /*AppBar(
                  title: Text('Deal Reco Summary'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),*/
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FocusTraversalGroup(
                        policy: OrderedTraversalPolicy(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                      controllerX.fetchClient(value.value??"");
                                    }, "Location", .23,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .3,
                                    autoFocus: true,),),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.channelList.value??[],
                                        (value) {
                                      controllerX.selectedChannel = value;
                                    }, "Channel", .23,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedChannel,
                                    dialogHeight: Get.height * .4,
                                    autoFocus: true,),),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.55,
                              child: Obx(()=>DropDownField.formDropDown1WidthMap(
                                controllerX.clientList.value??[],
                                    (value) {
                                  controllerX.selectedClient = value;
                                  controllerX.fetchAgency();
                                  controllerX.fetchADealNo();
                                }, "Client", .55,
                                isEnable: controllerX.isEnable,
                                selected: controllerX.selectedClient,
                                dialogHeight: Get.height * .4,
                                autoFocus: true,),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.55,
                              child: Obx(()=>DropDownField.formDropDown1WidthMap(
                                controllerX.agencyList.value??[],
                                    (value) {
                                  controllerX.selectedAgency = value;

                                }, "Agency", .55,
                                isEnable: controllerX.isEnable,
                                selected: controllerX.selectedAgency,
                                dialogHeight: Get.height * .3,
                                autoFocus: true,),),
                            ),
                            Container(
                              width:MediaQuery.of(context).size.width*0.55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.dealNoList.value??[],
                                        (value) {
                                      controllerX.selectedDealNo = value;

                                    }, "DealNo", .1,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedDealNo,
                                    onFocusChange:(sta){
                                      // print("fta"+sta.toString());
                                      if(!sta){
                                        controllerX.leaveDealNo();
                                      }
                                    },
                                    dialogHeight: Get.height * .3,
                                    autoFocus: true,),),
                                  DateWithThreeTextField(
                                    title: "Util As ON",
                                    mainTextController: controllerX.utilAsOnDateController,
                                    widthRation: .1,
                                    isEnable: controllerX.isEnable,
                                  ),
                                  DateWithThreeTextField(
                                    title: "From Date",
                                    mainTextController: controllerX.fromDateController,
                                    widthRation: .1,
                                    isEnable: controllerX.isEnable,
                                  ),
                                  DateWithThreeTextField(
                                    title: "To Date",
                                    mainTextController: controllerX.toDateController,
                                    widthRation: .1,
                                    isEnable: controllerX.isEnable,
                                  ),
                                ],),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width*0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.09,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 10, right: 10),
                              child: FormButtonWrapper(
                                btnText: "Generate",
                                callback: () {
                                  controllerX.callGenerate();
                                },
                                showIcon: false,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.09,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 10, right: 10),
                              child: FormButtonWrapper(
                                btnText: "Clear",
                                callback: () {
                                  Get.delete<DealRecoSummaryController>();
                                  Get.find<HomeController>().clearPage1();
                                },
                                showIcon: false,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.09,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 10, right: 10),
                              child: FormButtonWrapper(
                                btnText: "Exit",
                                callback: () {
                                  Get.delete<DealRecoSummaryController>();
                                },
                                showIcon: false,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child:  GetBuilder<DealRecoSummaryController>(
                          id: "grid",
                          builder: (controllerX) {
                            return (controllerX.dealRecoSummaryModel != null &&
                                controllerX.dealRecoSummaryModel?.gentare != null &&
                                (controllerX.dealRecoSummaryModel?.gentare?.length??0) >0) ?
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: DataGridFromMap(
                                showSrNo: false,
                                hideCode: false,
                                formatDate: false,
                                mapData: (controllerX.dealRecoSummaryModel!.gentare
                                    ?.map((e) => e.toJson())
                                    .toList())!,
                                // mapData: (controllerX.dataList)!,
                                widthRatio: Get.width / 9 - 1,
                              ),

                            ):Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            );
                          }
                      ),

                    ),
                  ),
                ),
                /// bottom common buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
