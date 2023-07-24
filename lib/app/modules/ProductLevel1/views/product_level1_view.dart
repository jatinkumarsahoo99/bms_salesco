import 'package:bms_salesco/app/data/PermissionModel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../providers/Utils.dart';
import '../controllers/product_level1_controller.dart';

class ProductLevel1View extends GetView<ProductLevel1Controller> {
   ProductLevel1View({Key? key}) : super(key: key);

   ProductLevel1Controller controllerX =
   Get.put<ProductLevel1Controller>(ProductLevel1Controller());

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
                            controllerX.locationList.value??[],
                                (value) {
                              controllerX.selectedLocation = value;
                            }, "Type", .41,
                            isEnable: controllerX.isEnable.value,
                            selected: controllerX.selectedLocation,
                            dialogHeight: Get.height * .7,
                            autoFocus: true,),),
                          InputFields.formField1(
                            hintTxt: "Level 1",
                            controller: TextEditingController(),
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
                /*  GetBuilder<HomeController>(
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
