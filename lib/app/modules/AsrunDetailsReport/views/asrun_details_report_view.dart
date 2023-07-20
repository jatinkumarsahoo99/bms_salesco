import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
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
        child: SizedBox(
          width: size.width * 0.94,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Asrun Details Report'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Location", .61,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),

                            Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width*0.61,
                              // margin: EdgeInsets.symmetric(vertical: 10),
                              child: GetBuilder<
                                  AsrunDetailsReportController>(
                                id: "updateTable1",
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
                                        margin:
                                        EdgeInsets.only(top: 8),
                                        child: ListView.builder(
                                          controller:
                                          ScrollController(),
                                          itemCount:10,
                                          itemBuilder:
                                              (context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 1,top: 1),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: false,
                                                    onChanged:
                                                        (bool? value) {

                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "ZEE",
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

                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            DateWithThreeTextField(
                              title: "From Date",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            DateWithThreeTextField(
                              title: "To Date",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 10, right: 10),
                              child: FormButtonWrapper(
                                btnText: "Genrate",
                                callback: () {
                                  // controllerX.callGetRetrieve();
                                },
                                showIcon: false,
                              ),
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child:  GetBuilder<AsrunDetailsReportController>(
                            id: "grid",
                            builder: (controllerX) {
                              return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),

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
                          element.appFormName == "frmCommercialMaster");
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
        ),
      ),
    );
  }
}
