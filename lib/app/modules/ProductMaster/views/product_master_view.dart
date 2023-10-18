import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/product_master_controller.dart';

class ProductMasterView extends GetView<ProductMasterController> {

   ProductMasterView({Key? key}) : super(key: key);


   ProductMasterController controllerX =
   Get.put<ProductMasterController>(ProductMasterController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.64,
          child: Dialog(
            child: GetBuilder<ProductMasterController>(
              id: "top",
              builder: (controllerX) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBar(
                      title: Text('Product Master'),
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
                            InputFields.formField1(
                              hintTxt: "Product Name",
                              controller: controllerX.productNameController,
                              focusNode: controllerX.productNode,
                              width:  0.5,
                              autoFocus: true,
                              maxLen: 40,
                              // focusNode: controllerX.brandName,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {

                              },
                              // autoFocus: true,
                            ),
                            InputFields.textAreaWidth(
                              hintTxt: "Product Description",
                              controller: controllerX.productDescriptionController,
                              onchanged: (value) {

                              }, widthRatio: 0.5,
                              paddingLeft: 0
                              // autoFocus: true,
                            ),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.productLevelList.value??[],
                                  (value) {
                                controllerX.selectedProductLevel = value;
                              }, "Product level", .5,
                              isEnable: controllerX.isEnable.value,
                              selected: controllerX.selectedProductLevel,
                              inkWellFocusNode: controllerX.productLevelNode,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: GetBuilder<HomeController>(
                          id: "buttons",
                          init: Get.find<HomeController>(),
                          builder: (controller) {
                            PermissionModel formPermissions = Get.find<MainController>()
                                .permissionList!
                                .lastWhere((element) =>
                            element.appFormName == "frmProductMaster");
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
                    SizedBox(height: 8),
                    /// bottom common buttons
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
