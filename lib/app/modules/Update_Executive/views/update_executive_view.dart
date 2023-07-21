import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/update_executive_controller.dart';

class UpdateExecutiveView extends GetView<UpdateExecutiveController> {
   UpdateExecutiveView({Key? key}) : super(key: key);

   UpdateExecutiveController controllerX =
   Get.put<UpdateExecutiveController>(UpdateExecutiveController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .55,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Update Executive'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Location",
                              0.1,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Obx(() {
                                return DropDownField.formDropDown1WidthMap(
                                  controller.channelList.value,
                                      (val) => controller.selectedChannel = val,
                                  "Channel",
                                  .3,
                                  selected: controller.selectedChannel,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Client",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Agency",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Zone",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),

                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DateWithThreeTextField(
                              title: "Date",
                              mainTextController: TextEditingController(),
                              widthRation: .1,
                              isEnable: controllerX.isEnable,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DateWithThreeTextField(
                                    title: "Date",
                                    mainTextController: TextEditingController(),
                                    widthRation: .1,
                                    isEnable: controllerX.isEnable,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, left: 10, right: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: FormButtonWrapper(
                                        btnText: "Show T.O",
                                        callback: () {
                                          // controllerX.callGetRetrieve();
                                        },
                                        showIcon: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Checkbox(value: false,

                              onChanged: (val){

                          }),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text("Select All"),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width*0.46,
                          height: MediaQuery.of(context).size.height*0.2,
                          child:  GetBuilder<UpdateExecutiveController>(
                              id: "grid",
                              builder: (controllerX) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),

                                );
                              }
                          ),

                        ),
                      ),


                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Correct Executive Name",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                /// bottom common buttons
                SizedBox(
                  height: 40,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var btn in ["Update Executive", "Clear", "Exit"]) ...{
                        FormButtonWrapper(
                          btnText: btn,
                          callback: () => controller.formHandler(btn),
                        )
                      },
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
