import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/audit_status_report_controller.dart';

class AuditStatusReportView  extends StatelessWidget  {
   AuditStatusReportView({Key? key}) : super(key: key);

   AuditStatusReportController controllerX =
  Get.put<AuditStatusReportController>(AuditStatusReportController());

   final GlobalKey rebuildKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: rebuildKey,
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
                    title: Text('Audit Status'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Location", .16,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Channel", .21,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      DateWithThreeTextField(
                        title: "Date",
                        mainTextController: TextEditingController(),
                        widthRation: .1,
                        isEnable: controllerX.isEnable,
                      ),
                      Obx(() => RadioRow(
                        items: [
                          "Addition",
                          "Cancelation",
                          "Rechedule"
                        ],
                        groupValue:
                        controllerX.selectValue.value ?? "",
                        onchange: (String v) {
                          print(">>>>"+v);
                          controllerX.selectValue.value=v;
                          controllerX.selectValue.refresh();
                        },
                      )),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Show",
                          callback: () {
                            // controllerX.callGetRetrieve();
                          },
                          showIcon: false,
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
                        child:  GetBuilder<AuditStatusReportController>(
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
