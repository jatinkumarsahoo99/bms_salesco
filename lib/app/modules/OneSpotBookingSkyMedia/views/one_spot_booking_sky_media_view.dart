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
import '../controllers/one_spot_booking_sky_media_controller.dart';

class OneSpotBookingSkyMediaView extends StatelessWidget {

   OneSpotBookingSkyMediaView({Key? key}) : super(key: key);

   OneSpotBookingSkyMediaController controllerX =
   Get.put<OneSpotBookingSkyMediaController>(OneSpotBookingSkyMediaController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .62,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('On Spot Booking(Sky Media)'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      children: [
                        SizedBox(
                          width:MediaQuery.of(context).size.width*0.46,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(()=>DropDownField.formDropDown1WidthMap(
                                controllerX.locationList.value??[],
                                    (val) {
                                  controllerX.selectedLocation?.value = val;
                                  print(">>>>>>"+(controllerX.selectedLocation?.value?.value).toString());
                                }, "Location",
                                0.1,
                                isEnable: controllerX.isEnable,
                                selected: controllerX.selectedLocation?.value,
                                dialogHeight: Get.height * .35,
                                inkWellFocusNode: controllerX.locationNode,
                                autoFocus: true,),),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Obx(() {
                                  return DropDownField.formDropDown1WidthMap(
                                    controllerX.channelList.value,
                                        (val) { controllerX.selectedChannel?.value = val;
                                        controllerX.onChannelLeave(val.key??"");
                                      },
                                    "Channel",
                                    .3,
                                    dialogHeight: Get.height * .35,
                                    inkWellFocusNode: controllerX.channelNode,
                                     autoFocus: false,
                                    selected: controllerX.selectedChannel?.value,
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
                                  mainTextController:  controllerX.bookingDateController,
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
                                        mainTextController: controllerX.effectiveDateController,
                                        widthRation: .1,
                                        isEnable: controllerX.isEnable,
                                        onFocusChange: (val){
                                          controllerX.effectiveDateLeave();
                                        },
                                      ),
                                      InputFields.formField1(
                                        hintTxt: "",
                                        controller: controllerX.txtController,
                                        width:  0.1,
                                        // autoFocus: true,
                                        // focusNode: controllerX.brandName,
                                        isEnable: controllerX.inactiveGroup.value,
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
                          controllerX.clientList.value??[],
                              (value) {
                            controllerX.selectedClient?.value = value;
                          }, "Client",
                          0.46,
                          isEnable: controllerX.inactiveGroup.value,
                          selected: controllerX.selectedClient?.value ,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.agencyList.value??[],
                              (value) {
                            controllerX.selectedAgency?.value  = value;
                          }, "Agency",
                          0.46,
                          isEnable: controllerX.inactiveGroup.value,
                          selected: controllerX.selectedAgency?.value ,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.brandList.value??[],
                              (value) {
                            controllerX.selectedBrandList?.value  = value;
                          }, "Brand",
                          0.46,
                          isEnable: controllerX.inactiveGroup.value,
                          selected: controllerX.selectedBrandList?.value ,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.payrouteList.value??[],
                              (value) {
                            controllerX.selectedPayrouteList?.value  = value;
                          }, "Payroute",
                          0.46,
                          isEnable:controllerX.inactiveGroup.value,
                          selected: controllerX.selectedPayrouteList?.value ,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.executiveList.value??[],
                              (value) {
                            controllerX.selectedExecutiveList?.value  = value;
                          }, "Executive",
                          0.46,
                          isEnable: controllerX.inactiveGroup.value,
                          selected: controllerX.selectedExecutiveList?.value ,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),

                        InputFields.formField1(
                          hintTxt: "BookingRegNo",
                          controller: controllerX.bookingRegController,
                          width:  0.46,
                          maxLen: 1000,
                          // autoFocus: true,
                          // focusNode: controllerX.brandName,
                          isEnable: controllerX.isEnable,
                          focusNode: controllerX.bookingRegNode,
                          onchanged: (value) {

                          },
                          // autoFocus: true,
                        ),
                        InputFields.formField1(
                          hintTxt: "Amount",
                          controller: controllerX.amountController,
                          width:  0.46,
                          // autoFocus: true,
                          // focusNode: controllerX.brandName,
                          isEnable: controllerX.isEnable,
                          focusNode: controllerX.amountNode,
                          onchanged: (value) {

                          },
                          // autoFocus: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                /// bottom common buttons
                GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions = Get.find<MainController>()
                          .permissionList!
                          .lastWhere((element) =>
                      element.appFormName == "frmDigiTextBooking");
                      if (controller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
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
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
