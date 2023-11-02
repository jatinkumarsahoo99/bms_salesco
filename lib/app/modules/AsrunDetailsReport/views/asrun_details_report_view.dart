import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/asrun_details_report_controller.dart';

class AsrunDetailsReportView extends StatelessWidget {
   AsrunDetailsReportView({Key? key}) : super(key: key);

   AsrunDetailsReportController controllerX =
   Get.put<AsrunDetailsReportController>(AsrunDetailsReportController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             /* AppBar(
                title: Text('Asrun Details Report'),
                centerTitle: true,
                backgroundColor: Colors.deepPurple,
              ),*/
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value??[],
                              (value) {
                            controllerX.selectedLocation = value;
                          }, "Location", .41,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedLocation,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 3.0,left: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(()=>Checkbox(
                                    value: controllerX.checked.value,
                                    side: const BorderSide(color: Colors.deepPurpleAccent),
                                    onChanged: (bool? value) {
                                      controllerX.checked.value = value!;
                                      if(value!){
                                        for (var element in controllerX
                                            .channelList) {
                                          element.ischecked = true;
                                        }
                                        controllerX.update(['updateList']);
                                      }else{
                                        for (var element in controllerX
                                            .channelList) {
                                          element.ischecked = false;
                                        }
                                        controllerX.update(['updateList']);
                                      }

                                    },visualDensity: VisualDensity(horizontal: -4),
                                  )),
                                  Text(
                                    "Channel",
                                    style: TextStyle(
                                      fontSize: SizeDefine.labelSize1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InputFields.formField1(
                              hintTxt: "Level 1",
                              controller: TextEditingController(),
                              width:  0.12,
                              capital: true,
                              // focusNode: controllerX.level1Node,

                              // autoFocus: true,
                              // focusNode: controllerX.brandName,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {

                              },
                              // autoFocus: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: MediaQuery.of(context).size.height * .17,
                          width: MediaQuery.of(context).size.width*0.41,
                          // margin: EdgeInsets.symmetric(vertical: 10),
                          child: GetBuilder<
                              AsrunDetailsReportController>(
                            id: "updateList",
                            builder: (control) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors
                                              .deepPurpleAccent),
                                      borderRadius:
                                      BorderRadius.circular(
                                          0),
                                    ),
                                    margin: EdgeInsets.only(top: 1,left: 0,bottom: 0,right: 0),
                                    child: ListView.builder(
                                      controller:
                                      ScrollController(),
                                      itemCount:controllerX.channelList.length,
                                      itemBuilder:
                                          (context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 5.0,right: 5,bottom: 3,top: 0),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: controllerX.channelList[index].ischecked,
                                                side: const BorderSide(color: Colors.deepPurpleAccent),
                                                onChanged:
                                                    (bool? value) {
                                                      controllerX.channelList[index].ischecked = value;
                                                      controllerX.update(['updateList']);
                                                },
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controllerX.channelList[index].channelName?? "ZEE",
                                                  style: TextStyle(
                                                    fontSize: SizeDefine.labelSize1,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.07,
                  ),
                  Column(
                    children: [
                      DateWithThreeTextField(
                        title: "From Date",
                        mainTextController: controllerX.frmDate,
                        widthRation: .1,
                        isEnable: controllerX.isEnable,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DateWithThreeTextField(
                        title: "To Date",
                        mainTextController: controllerX.toDate,
                        widthRation: .1,
                        isEnable: controllerX.isEnable,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: SizedBox(
                          width: Get.width*0.1,
                          child: FormButtonWrapper(
                            btnText: "Genrate",
                            callback: () {
                              controllerX.fetchGetGenerate();
                            },
                            showIcon: true,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                // flex: 9,
                child: Container(
                  child:  GetBuilder<AsrunDetailsReportController>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container(
                          child: (controllerX.asrunDetailsReportModel != null &&
                              controllerX.asrunDetailsReportModel!.generate != null &&
                              controllerX.asrunDetailsReportModel!.generate!.isNotEmpty
                          )?DataGridFromMap(
                            showSrNo: true,
                            hideCode: false,
                            formatDate: false,
                            colorCallback: (row) => (row.row.cells
                                .containsValue(
                                controllerX.stateManager?.currentCell))
                                ? Colors.deepPurple.shade200
                                : Colors.white,
                            exportFileName: "Asrun Details Report",
                            widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                                userGridSettingList: controllerX.userGridSetting1),
                            mapData: (controllerX.asrunDetailsReportModel!.generate
                                ?.map((e) => e.toJson())
                                .toList())??[{"noData":"noData"}],
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load){
                              controllerX.stateManager = load.stateManager;
                            },
                          ):Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                          ),
                        );
                      }
                  ),

                ),
              ),
              SizedBox(
                height: 8,
              ),
              /// bottom common buttons
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions = Get.find<MainController>()
                          .permissionList!
                          .lastWhere((element) =>
                      element.appFormName == "frmAsrundetailsReport");
                      if (controller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in controller.buttons!)
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: Utils.btnAccessHandler2(btn['name'],
                                    controller, formPermissions) ==
                                    null
                                    ? null
                                    : () => controllerX.formHandler(
                                  btn['name'],
                                ),
                              )
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
              SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
