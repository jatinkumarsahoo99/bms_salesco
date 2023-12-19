import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                                controllerX.fetchClient(value.value??"");
                              }, "Location", .22,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .3,
                              inkWellFocusNode: controllerX.locationNode,
                              autoFocus: true,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.channelList.value??[],
                                  (value) {
                                controllerX.selectedChannel = value;
                              }, "Channel", .22,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedChannel,
                              dialogHeight: Get.height * .4,
                              inkWellFocusNode: controllerX.channelNode,
                              autoFocus: false,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.clientList.value??[],
                                  (value) {
                                controllerX.selectedClient = value;
                                // controllerX.fetchAgency();
                                // controllerX.fetchADealNo();
                              }, "Client", .22,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedClient,
                              dialogHeight: Get.height * .4,
                              inkWellFocusNode:controllerX.clientNode ,
                              onFocusChange: (val){
                                if(!val){
                                  if(controllerX.selectedClient?.value != null){
                                    controllerX.selectedAgency = Rxn<DropDownValue>(null);
                                    controllerX.selectedDealNo  = null;
                                    controllerX.selectedAgency?.refresh();
                                    controllerX.fetchAgency();
                                    controllerX.fetchADealNo();
                                  }
                                }
                              },
                              autoFocus: false,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.agencyList.value??[],
                                  (value) {
                                controllerX.selectedAgency?.value = value;

                              }, "Agency", .22,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedAgency?.value,
                              dialogHeight: Get.height * .3,
                              inkWellFocusNode: controllerX.agencyNode,
                              autoFocus: false,),),

                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width*0.22,
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
                                    inkWellFocusNode: controllerX.dealNoFocusNode,
                                    onFocusChange:(sta){
                                      // print("fta"+sta.toString());
                                      if(!sta){
                                        controllerX.leaveDealNo();
                                      }
                                    },
                                    dialogHeight: Get.height * .3,
                                    autoFocus: false,),),
                                  DateWithThreeTextField(
                                    title: "Util As ON",
                                    mainTextController: controllerX.utilAsOnDateController,
                                    widthRation: .1,
                                    isEnable: controllerX.isEnable,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: Get.width*0.22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                ],
                              ),
                            ),

                            SizedBox(
                              width: Get.width*0.22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width*0.1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 0, right: 0),
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
                                    width: Get.width*0.1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 0, right: 0),
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
                                ],
                              ),
                            ),

                            SizedBox(
                              width: Get.width*0.22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width*0.1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 0, right: 0),
                                      child: FormButtonWrapper(
                                        btnText: "Exit",
                                        callback: () {
                                          Get.delete<DealRecoSummaryController>();
                                        },
                                        showIcon: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width*0.1,
                                  )
                                ],
                              ),
                            ),
                          ],),

                      ],
                    ),
                  ),
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
                                colorCallback: (row) => (row.row.cells
                                    .containsValue(
                                    controllerX.stateManager?.currentCell))
                                    ? Colors.deepPurple.shade200
                                    : Colors.white,
                                mapData: (controllerX.dealRecoSummaryModel!.gentare
                                    ?.map((e) => e.toJson())
                                    .toList())!,
                                // mapData: (controllerX.dataList)!,
                                widthRatio: Get.width / 9 - 1,
                                mode: PlutoGridMode.normal,
                                onload: (PlutoGridOnLoadedEvent load){
                                  controllerX.stateManager = load.stateManager;
                                },
                                widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                                    userGridSettingList: controllerX.userGridSetting1),
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
