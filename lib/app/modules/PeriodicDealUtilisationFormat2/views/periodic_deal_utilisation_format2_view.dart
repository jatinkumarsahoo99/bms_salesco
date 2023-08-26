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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value??[],
                              (value) {
                            controllerX.selectedLocation?.value = value;
                            controllerX.selectedChannel?.value = null;
                          }, "Location", .25,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedLocation?.value,
                          dialogHeight: Get.height * .35,
                          autoFocus: true,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.channelList.value??[],
                              (value) {
                            controllerX.selectedChannel?.value = value;
                            controllerX.getOnChannelLeave();
                          }, "Channel", .25,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedChannel?.value,
                          dialogHeight: Get.height * .35,
                          autoFocus: false,),),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.07,
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
                        showIcon: true,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.55,
                    child: Obx(()=>DropDownField.formDropDown1WidthMap(
                      controllerX.clientList.value??[],
                          (value) {
                        controllerX.selectedClient?.value = value;
                      }, "Client", .55,
                      isEnable: controllerX.isEnable,
                      selected: controllerX.selectedClient?.value,
                      dialogHeight: Get.height * .7,
                      autoFocus: false,),),
                  ),
                  SizedBox(
                    width: size.width*0.07,
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
                        showIcon: true,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.agencyList.value??[],
                              (value) {
                            controllerX.selectedAgency?.value = value;
                          }, "Agency", .4,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedAgency?.value,
                          dialogHeight: Get.height * .7,
                          autoFocus: false,),),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.dealNoList.value??[],
                              (value) {
                            controllerX.selectedDealNo?.value = value;
                          }, "DealNo", .1,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedDealNo?.value,
                          dialogHeight: Get.height * .7,
                          autoFocus: false,),),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.07,
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
                        showIcon: true,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 4,
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
                          mainTextController: controllerX.utilAsOnDateController,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        DateWithThreeTextField(
                          title: "To",
                          mainTextController: controllerX.utilAsOnDateToDateController,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        DateWithThreeTextField(
                          title: "Deal Period",
                          mainTextController: controllerX.dealPeriodController,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        DateWithThreeTextField(
                          title: "To",
                          mainTextController: controllerX.dealPeriodToController,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        InputFields.formField1(
                          hintTxt: "Deal Amount",
                          controller: controllerX.dealAmountController,
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
              SizedBox(
                height: 4,
              ),
              Expanded(
                flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)),
                  child:  GetBuilder<PeriodicDealUtilisationFormat2Controller>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container(

                        );
                      }
                  ),

                ),
              ),
              SizedBox(
                height: 4,
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
              SizedBox(height: 2),
              /// bottom common buttons
            ],
          ),
        ),
      ),
    );
  }
}
