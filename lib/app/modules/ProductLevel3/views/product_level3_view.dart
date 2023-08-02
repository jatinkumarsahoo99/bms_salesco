import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/product_level3_controller.dart';

class ProductLevel3View extends GetView<ProductLevel3Controller> {
   ProductLevel3View({Key? key}) : super(key: key);

   ProductLevel3Controller controllerX =
  Get.put<ProductLevel3Controller>(ProductLevel3Controller());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.54,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Product Type Master'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(()=>DropDownField.formDropDown1WidthMap(
                            controllerX.typeList.value??[],
                                (value) {
                              controllerX.selectedType?.value = value;
                              controllerX.fetchProductLevel1(value.key??"");
                            }, "Type", .41,
                            isEnable: controllerX.isEnable.value,
                            selected: controllerX.selectedType?.value,
                            inkWellFocusNode: controllerX.typeNode,
                            dialogHeight: Get.height * .3,
                            autoFocus: true,),),
                          Obx(()=>DropDownField.formDropDown1WidthMap(
                            controllerX.level1List.value??[],
                                (value) {
                              controllerX.selectedLevel1?.value = value;
                              controllerX.fetchProductLevel2(int.parse((value.key??"0").toString()));
                            }, "Level 1", .41,
                            isEnable: controllerX.isEnable.value,
                            selected: controllerX.selectedLevel1?.value,
                            inkWellFocusNode: controllerX.level1Node,
                            dialogHeight: Get.height * .3,
                            autoFocus: true,),),
                          Obx(()=>DropDownField.formDropDown1WidthMap(
                            controllerX.level2List.value??[],
                                (value) {
                              controllerX.selectedLevel2?.value = value;

                            }, "Level 2", .41,
                            isEnable: controllerX.isEnable.value,
                            selected: controllerX.selectedLevel2?.value,
                            inkWellFocusNode: controllerX.level2Node,
                            dialogHeight: Get.height * .3,
                            autoFocus: true,),),
                          InputFields.formField1(
                            hintTxt: "Level 3",
                            controller: controllerX.level3Controller,
                            focusNode: controllerX.level3Node,
                            width:  0.41,
                            // autoFocus: true,
                            // focusNode: controllerX.brandName,
                            // isEnable: controllerX.isEnable,
                            onchanged: (value) {

                            },
                            // autoFocus: true,
                          ),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                    GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions = Get.find<MainController>()
                            .permissionList!
                            .lastWhere((element) =>
                        element.appFormName == "frmProductLevel3");
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
                      })
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
