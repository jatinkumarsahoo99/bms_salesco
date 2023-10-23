import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/audit_status_report_controller.dart';

class AuditStatusReportView  extends StatelessWidget  {
   AuditStatusReportView({Key? key}) : super(key: key);

   AuditStatusReportController controllerX =
  Get.put<AuditStatusReportController>(AuditStatusReportController());

   final GlobalKey rebuildKey = GlobalKey();


   Widget _dataTable1(context) {
     return GetBuilder<AuditStatusReportController>(
         id: "grid",
         // init: CreateBreakPatternController(),
         builder: (controller) {
           if(controllerX.auditStatusReportModel != null && controllerX.auditStatusReportModel?.audit != null &&
               (controllerX.auditStatusReportModel?.audit?.length??0) >0
           ){
             // print(">>>>>>>>DataList"+( controllerX.auditStatusReportModel!.audit!.length).toString());
             return Expanded(
               flex: 10,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DataGridFromMap(
                   showSrNo: false,
                   hideCode: false,
                   formatDate: false,
                   exportFileName: "Audit Status Report",
                   widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                       userGridSettingList: controllerX.userGridSetting1,key: "tbl1"),
                   mapData: (controllerX.auditStatusReportModel?.audit
                       ?.map((e) => e.toJson())
                       .toList())!,
                   // mapData: (controllerX.dataList)!,
                   widthRatio: Get.width / 9 - 1,
                   onload: (PlutoGridOnLoadedEvent load){
                     controllerX.stateManager1 = load.stateManager;
                   },
                 ),
               ),
             );
           }
           else if(controllerX.auditStatusGenerateToList != null && controllerX.auditStatusGenerateToList?.listData != null &&
               (controllerX.auditStatusGenerateToList?.listData?.length??0) >0){
             // print(">>>>>>ListData"+(controllerX.auditStatusGenerateToList!.listData?.length.toString()??""));
             return Expanded(
               flex: 10,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DataGridFromMap(
                   showSrNo: false,
                   hideCode: false,
                   formatDate: false,
                   exportFileName: "Audit Status Report",
                   widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                       userGridSettingList: controllerX.userGridSetting1,key: "tbl2"),
                   mapData: (controllerX.auditStatusGenerateToList?.listData
                       ?.map((e) => e.toJson())
                       .toList())!,
                   // mapData: (controllerX.dataList)!,
                   widthRatio: Get.width / 9 - 1,
                   onload: (PlutoGridOnLoadedEvent load){
                     controllerX.stateManager2 = load.stateManager;
                   },
                 ),
               ),
             );
           }
           else if(controllerX.auditStatusCancel != null && controllerX.auditStatusCancel?.cancel != null &&
               (controllerX.auditStatusCancel?.cancel?.length??0) >0){
             // print(">>>>>>ListData"+(controllerX.auditStatusGenerateToList!.listData?.length.toString()??""));
             return Expanded(
               flex: 10,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DataGridFromMap(
                   showSrNo: false,
                   hideCode: false,
                   formatDate: false,
                   exportFileName: "Audit Status Report",
                   widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                       userGridSettingList: controllerX.userGridSetting1,key: "tbl3"),
                   mapData: (controllerX.auditStatusCancel?.cancel
                       ?.map((e) => e.toJson())
                       .toList())!,
                   // mapData: (controllerX.dataList)!,
                   widthRatio: Get.width / 9 - 1,
                   onload: (PlutoGridOnLoadedEvent load){
                     controllerX.stateManager3 = load.stateManager;
                   },
                 ),
               ),
             );
           }
           else{
             return Expanded(
               flex: 10,
               // height: 400,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   // height: Get.height - (2 * kToolbarHeight),
                   decoration:
                   BoxDecoration(border: Border.all(color: Colors.grey)),
                 ),
               ),
             );
           }
         });
   }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: rebuildKey,
      body: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<AuditStatusReportController>(
                        id: "initialData",
                        builder: (control) {
                          return Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 10.0, top: 0),
                              child: FocusTraversalGroup(
                                policy: OrderedTraversalPolicy(),
                                child: SingleChildScrollView(
                                  // padding: EdgeInsets.only(top: 1),
                                  controller: ScrollController(),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(()=>DropDownField.formDropDown1WidthMap(
                                        controllerX.locationList.value??[],
                                            (value) {
                                          controllerX.selectedLocation = value;
                                        }, "Location", .22,
                                        isEnable: controllerX.isEnable.value,
                                        selected: controllerX.selectedLocation,
                                        // dialogHeight: Get.height * .3,
                                        autoFocus: true,),),
                                    /*  DropDownField.formDropDown1WidthMap(
                                              [],
                                                  (value) {

                                              },
                                              "Location",
                                              0.22,
                                              isEnable: controllerX.isEnable.value,
                                              // selected: controllerX.selectLocation,
                                              autoFocus: true,
                                              dialogWidth: 330,
                                              dialogHeight: Get.height * .7,
                                            ),*/
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Obx(()=>  Checkbox(
                                              value: controllerX.checked.value,
                                              side: const BorderSide(color: Colors.deepPurpleAccent),
                                              onChanged: (bool? value) {
                                                controllerX.checked.value = value!;
                                                if(value!){
                                                  for (var element in controllerX
                                                      .channelList) {
                                                    element.ischecked = true;
                                                  }
                                                  controllerX.update(['updateChannel']);
                                                }else{
                                                  for (var element in controllerX
                                                      .channelList) {
                                                    element.ischecked = false;
                                                  }
                                                  controllerX.update(['updateChannel']);
                                                }

                                              },
                                            )) ,
                                            Text(
                                              "Channel",
                                              style:TextStyle(
                                                fontSize: SizeDefine.labelSize1,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height * .3,
                                        // margin: EdgeInsets.symmetric(vertical: 10),
                                        child: GetBuilder<
                                            AuditStatusReportController>(
                                          id: "updateChannel",
                                          builder: (control) {
                                            return Stack(
                                              children: [
                                                Focus(
                                                  skipTraversal: true,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .deepPurpleAccent),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    margin:
                                                    EdgeInsets.only(top: 8),
                                                    child: ListView.builder(
                                                      controller:
                                                      ScrollController(),
                                                      itemCount: controllerX.channelList.length,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return Row(
                                                          children: [
                                                            Checkbox(
                                                              value: controllerX.channelList[index].ischecked,
                                                              side: const BorderSide(color: Colors.deepPurpleAccent),
                                                              focusNode: FocusNode(skipTraversal: true),
                                                              onChanged:
                                                                  (bool? value) {
                                                                    controllerX.channelList[index].ischecked = value;
                                                                    controllerX.update(['updateChannel']);
                                                              },
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                controllerX.channelList[index].channelName?? "ZEE",
                                                                style:TextStyle(
                                                                  fontSize: SizeDefine.labelSize1,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                               DateWithThreeTextField(
                                                  title: "Date",
                                                  splitType: "-",
                                                  widthRation: 0.09,
                                                  isEnable: controllerX.isEnable.value,
                                                  onFocusChange: (data) {},
                                                  mainTextController:controllerX.dateController,
                                                ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14.0, left: 0, right: 0),
                                                child: SizedBox(
                                                  width: size.width*0.11,
                                                  child: FormButtonWrapper(
                                                    btnText: "Genrate Audit Status",
                                                    callback: () {
                                                      controllerX.fetchGetGenerateAuditStatus();
                                                    },
                                                    showIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14.0, left: 0, right: 0),
                                                child: SizedBox(
                                                  width: size.width*0.11,
                                                  child: FormButtonWrapper(
                                                    btnText: "Generate Can/Res",
                                                    callback: () {
                                                      controllerX.fetchGetGenerateAuditStatusCancel();
                                                    },
                                                    showIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("T.O. List",   style:TextStyle(
                                        fontSize: SizeDefine.labelSize1,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration:
                                        BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                             DateWithThreeTextField(
                                                  title: "From Date",
                                                  splitType: "-",
                                                  widthRation: 0.16,
                                                  isEnable: controllerX.isEnable.value,
                                                  onFocusChange: (data) {},
                                                  mainTextController:controllerX.frmDate,
                                                ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              DateWithThreeTextField(
                                                title: "To Date",
                                                splitType: "-",
                                                widthRation: 0.16,
                                                isEnable: controllerX.isEnable.value,
                                                onFocusChange: (data) {},
                                                mainTextController:controllerX.toDate,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14.0, left: 10, right: 10,bottom: 6),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.2,
                                                  child: FormButtonWrapper(
                                                    btnText: "Generate T.O. List",
                                                    callback: () {
                                                      controllerX.fetchGetGenerateTOList();
                                                    },
                                                    showIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          FormButton(
                                            btnText: "Clear",
                                            callback: () {
                                              Get.delete<AuditStatusReportController>();
                                              Get.find<HomeController>().clearPage1();
                                            },
                                          ),
                                          FormButton(
                                            btnText: "Exit",
                                            callback: () {
                                              Get.delete<AuditStatusReportController>();
                                              Get.find<HomeController>().postUserGridSetting1(
                                                  listStateManager: [
                                                    controllerX.stateManager1,controllerX.stateManager2
                                                  ],tableNamesList: ['tbl1','tbl2']);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      VerticalDivider(),
                      _dataTable1(context),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
