import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../controllers/workflow_definition_controller.dart';

class WorkflowDefinitionView extends GetView<WorkflowDefinitionController> {
   WorkflowDefinitionView({Key? key}) : super(key: key);

   WorkflowDefinitionController controllerX = Get.put<WorkflowDefinitionController>(WorkflowDefinitionController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FocusTraversalGroup(
                  policy:OrderedTraversalPolicy(),
                  child: Expanded(
                    flex:8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<WorkflowDefinitionController>(
                          id: "top",
                          builder: (controllerX) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              padding: const EdgeInsets.all(16),
                              child: ListView(
                                children: [
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Location",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Channel",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Zone",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Station",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Team",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(()=>DropDownField.formDropDown1WidthMap(
                                    controllerX.locationList.value??[],
                                        (value) {
                                      controllerX.selectedLocation = value;
                                    }, "Type",
                                    0.36,
                                    isEnable: controllerX.isEnable,
                                    selected: controllerX.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    autoFocus: true,),),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(() => RadioRow(
                                    items: [
                                      "Employee",
                                      "User Group"
                                    ],
                                    groupValue:
                                    controllerX.selectValue.value ?? "",
                                    onchange: (String v) {
                                      print(">>>>"+v);
                                      controllerX.selectValue.value=v;
                                      controllerX.selectValue.refresh();
                                    },
                                  )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  DropDownField
                                      .formDropDownSearchAPI2(
                                    GlobalKey(),
                                    context,
                                    width: context.width *  0.36,
                                    onchanged: (DropDownValue? val) {
                                      print(">>>" + val.toString());
                                      controllerX.selectedProduct = val;
                                      // controllerX.getProductDetails(val?.key??"");
                                      // controllerX.fetchClientDetails((val?.value ??"")??"");
                                    },
                                    title: 'User',
                                    url:"",
                                    parseKeyForKey: "productcode",
                                    parseKeyForValue: 'Productname',
                                    selectedValue: controllerX.selectedProduct,
                                    autoFocus: true,
                                    // maxLength: 1
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  DropDownField
                                      .formDropDownSearchAPI2(
                                    GlobalKey(),
                                    context,
                                    width: context.width *  0.36,
                                    onchanged: (DropDownValue? val) {
                                      print(">>>" + val.toString());
                                      controllerX.selectedProduct = val;
                                      // controllerX.getProductDetails(val?.key??"");
                                      // controllerX.fetchClientDetails((val?.value ??"")??"");
                                    },
                                    title: 'Group',
                                    url:"",
                                    parseKeyForKey: "productcode",
                                    parseKeyForValue: 'Productname',
                                    selectedValue: controllerX.selectedProduct,
                                    autoFocus: true,
                                    // maxLength: 1
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Step Name",
                                    controller: TextEditingController(),
                                    width:  0.36,
                                    // autoFocus: true,
                                    focusNode: controllerX.brandName,
                                    // isEnable: controllerX.isEnable,
                                    onchanged: (value) {

                                    },
                                    // autoFocus: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "FormName",
                                    controller: TextEditingController(),
                                    width:  0.36,
                                    // autoFocus: true,
                                    focusNode: controllerX.brandName,
                                    // isEnable: controllerX.isEnable,
                                    onchanged: (value) {

                                    },
                                    // autoFocus: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => RadioRow(
                                        items: [
                                          "Before",
                                          "After"
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
                                          btnText: "Add",
                                          callback: () {
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Clear",
                                          callback: () {
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Copy To",
                                          callback: () {
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                    ],
                                  )


                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)),
                      child: GetBuilder<WorkflowDefinitionController>(
                          id: "grid",
                          builder: (controllerX) {
                            return Container(
                              /*  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),*/
                            );
                          }
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 7),
          GetBuilder<HomeController>(
              id: "buttons",
              init: Get.find<HomeController>(),
              builder: (controller) {
                PermissionModel formPermissions = Get.find<MainController>()
                    .permissionList!
                    .lastWhere((element) =>
                element.appFormName == "frmBrandMaster");
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
              })
        ],
      ),
    );
  }
}
