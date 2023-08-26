import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/product_level2_controller.dart';

class ProductLevel2View extends GetView<ProductLevel2Controller> {
   ProductLevel2View({Key? key}) : super(key: key);

   ProductLevel2Controller controllerX =
  Get.put<ProductLevel2Controller>(ProductLevel2Controller());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.64,
          child: Dialog(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.typeList.value??[],
                              (value) {
                            controllerX.selectedType?.value = value;
                            controllerX.fetchProductLevel1(controllerX.selectedType?.value?.key??"");
                          }, "Type", .5,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectedType?.value,
                          dialogHeight: Get.height * .3,
                          inkWellFocusNode: controllerX.typeNode,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.level1List.value??[],
                              (value) {
                            controllerX.selectedLevel1?.value = value;
                          }, "Level 1", .5,
                          isEnable: controllerX.isEnable.value,
                          selected: controllerX.selectedLevel1?.value,
                          inkWellFocusNode: controllerX.level1Node,
                          dialogHeight: Get.height * .3,
                          autoFocus: true,),),
                        InputFields.formField1(
                          hintTxt: "Level 2",
                          controller: controllerX.level2Controller,
                          width:  0.5,
                          // autoFocus: true,
                          focusNode: controllerX.level2Node,
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
                      element.appFormName == "frmProductLevel2");
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
                      return Container(child: Text("No"),);
                    }),
                SizedBox(height: 8),
                /// bottom common buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
