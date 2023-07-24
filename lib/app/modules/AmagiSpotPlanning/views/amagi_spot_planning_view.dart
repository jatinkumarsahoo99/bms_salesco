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
import '../controllers/amagi_spot_planning_controller.dart';

class AmagiSpotPlanningView extends GetView<AmagiSpotPlanningController> {
   AmagiSpotPlanningView({Key? key}) : super(key: key);

   AmagiSpotPlanningController controllerX =
   Get.put<AmagiSpotPlanningController>(AmagiSpotPlanningController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.84,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Amagi Spot Planning'),
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
                        }, "Location", .21,
                        isEnable: controllerX.isEnable.value,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),

                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {

                        }, "channel", .21,
                        isEnable: controllerX.isEnable.value,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),

                      DateWithThreeTextField(
                        title: "Scheduled Date",
                        mainTextController: TextEditingController(),
                        widthRation: .1,
                        isEnable: controllerX.isEnable.value,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Data",
                          callback: () {
                            // controllerX.callGetRetrieve();
                          },
                          showIcon: false,
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioRow(
                      items: [
                        "Master Spots",
                        "Channel",
                        "Client",
                        "Data"
                      ],
                      groupValue:
                      controllerX.selectValue.value ?? "",
                      onchange: (String v) {
                        print(">>>>"+v);
                        controllerX.selectValue.value=v;
                        controllerX.selectValue.refresh();
                      },
                    ),
                  ),
                  Expanded(
                    // flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child:  GetBuilder<AmagiSpotPlanningController>(
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
                  /*SizedBox(height: 5),
                  GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions = Get.find<MainController>()
                            .permissionList!
                            .lastWhere((element) =>
                        element.appFormName == "frmAma_Planning");
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
                        return Container(child: Text("No"),);
                      })*/
                  /// bottom common buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
