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
import '../controllers/on_spot_booking_sky_media_controller.dart';

class OnSpotBookingSkyMediaView
    extends GetView<OnSpotBookingSkyMediaController> {
   OnSpotBookingSkyMediaView({Key? key}) : super(key: key);

   OnSpotBookingSkyMediaController controllerX =
   Get.put<OnSpotBookingSkyMediaController>(OnSpotBookingSkyMediaController());


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
                  title: Text('On Spot Booking(Sky Media)'),
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
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.46,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DateWithThreeTextField(
                                title: "Booking Date",
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
                                      title: "Effective Date",
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
                                      isEnable: controllerX.isEnable,
                                      onchanged: (value) {

                                      },
                                      // autoFocus: true,
                                    ),
                                  ],
                                ),
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
                        }, "Brand",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Payroute",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                        }, "Executive",
                        0.46,
                        isEnable: controllerX.isEnable,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .7,
                        autoFocus: true,),),

                      InputFields.formField1(
                        hintTxt: "BookingRegNo",
                        controller: TextEditingController(),
                        width:  0.46,
                        // autoFocus: true,
                        // focusNode: controllerX.brandName,
                        isEnable: controllerX.isEnable,
                        onchanged: (value) {

                        },
                        // autoFocus: true,
                      ),
                      InputFields.formField1(
                        hintTxt: "Amount",
                        controller: TextEditingController(),
                        width:  0.46,
                        // autoFocus: true,
                        // focusNode: controllerX.brandName,
                        isEnable: controllerX.isEnable,
                        onchanged: (value) {

                        },
                        // autoFocus: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                /// bottom common buttons
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
                              if(btn["name"] != "Docs" && btn["name"] != "Delete"
                                  && btn["name"] != "Refresh" && btn["name"] != "Search" )
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
