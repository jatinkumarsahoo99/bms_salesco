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
import '../controllers/asrun_details_report_controller.dart';

class AsrunDetailsReportView extends GetView<AsrunDetailsReportController> {
   AsrunDetailsReportView({Key? key}) : super(key: key);

   AsrunDetailsReportController controllerX =
   Get.put<AsrunDetailsReportController>(AsrunDetailsReportController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
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
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 3.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.1,
                                ),
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

                                  },
                                )) ,
                                Text(
                                  "Channel",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
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
                                                        fontSize: 12,fontWeight: FontWeight.bold),
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
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        DateWithThreeTextField(
                          title: "From Date",
                          mainTextController: controllerX.frmDate,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
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
                          child: FormButtonWrapper(
                            btnText: "Genrate",
                            callback: () {
                              controllerX.fetchGetGenerate();
                            },
                            showIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.2,
                  )

                ],
              ),
              Expanded(
                // flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    child:  GetBuilder<AsrunDetailsReportController>(
                        id: "grid",
                        builder: (controllerX) {
                          return Container(
                            child: (controllerX.asrunDetailsReportModel != null &&
                                controllerX.asrunDetailsReportModel!.generate != null &&
                                controllerX.asrunDetailsReportModel!.generate!.length >0
                            )?DataGridFromMap(
                              showSrNo: false,
                              hideCode: false,
                              formatDate: false,
                              mapData: (controllerX.asrunDetailsReportModel!.generate
                                  ?.map((e) => e.toJson())
                                  .toList())!,
                              // mapData: (controllerX.dataList)!,
                              widthRatio: Get.width / 9 - 1,
                            ):Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                            ),
                          );
                        }
                    ),

                  ),
                ),
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
                        return ButtonBar(
                          alignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
