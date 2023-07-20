import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/periodic_deal_utilisation_format2_controller.dart';

class PeriodicDealUtilisationFormat2View
    extends GetView<PeriodicDealUtilisationFormat2Controller> {
   PeriodicDealUtilisationFormat2View({Key? key}) : super(key: key);

   PeriodicDealUtilisationFormat2Controller controllerX =
   Get.put<PeriodicDealUtilisationFormat2Controller>(PeriodicDealUtilisationFormat2Controller());

   final GlobalKey rebuildKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: rebuildKey,
      body: Center(
        child: SizedBox(
          width: size.width * 0.78,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Periodic Deal Utilisation'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Location", .23,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Channel", .23,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                          child: FormButtonWrapper(
                            btnText: "Generate",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value??[],
                              (value) {
                            controllerX.selectedLocation = value;
                          }, "Client", .55,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedLocation,
                          dialogHeight: Get.height * .7,
                          autoFocus: true,),),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                          child: FormButtonWrapper(
                            btnText: "Clear",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Agency", .4,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "DealNo", .1,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                          child: FormButtonWrapper(
                            btnText: "Exit",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DateWithThreeTextField(
                              title: "Util As ON",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            DateWithThreeTextField(
                              title: "To",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            DateWithThreeTextField(
                              title: "Deal Period",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            DateWithThreeTextField(
                              title: "To",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            InputFields.formField1(
                              hintTxt: "FormName",
                              controller: TextEditingController(),
                              width:  0.1,
                              // autoFocus: true,
                              // focusNode: controllerX.brandName,
                              // isEnable: controllerX.isEnable,
                              onchanged: (value) {

                              },
                              // autoFocus: true,
                            ),
                          ],),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width*0.1,
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
                        child:  GetBuilder<PeriodicDealUtilisationFormat2Controller>(
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
