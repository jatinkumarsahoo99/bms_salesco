import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/zone_wise_inventory_utilization_controller.dart';

class ZoneWiseInventoryUtilizationView extends GetView<ZoneWiseInventoryUtilizationController> {
  const ZoneWiseInventoryUtilizationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Wrap(
                spacing: 10,
                runSpacing: 5,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      (val){
                        controller.selectedLocation = val;
                        controller.getChannel(val.key??"");
                      },
                      "Location",
                      .15,
                      autoFocus: true,
                      selected: controller.selectedLocation,
                      inkWellFocusNode: controller.locationFN,
                    );
                  }),
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.channelList.value,
                      (val) => controller.selectedChannel = val,
                      "Channel",
                      .15,
                      selected: controller.selectedChannel,
                    );
                  }),
                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controller.fromDateController,
                    widthRation: .15,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controller.toDateController,
                    widthRation: .15,
                  ),
                  InputFields.formFieldNumberMask(
                    hintTxt: "From Time",
                    controller: controller.fromTimeController,
                    widthRatio: .15,
                  ),
                  InputFields.formFieldNumberMask(
                    hintTxt: "To Time",
                    controller: controller.toTimeController,
                    widthRatio: .15,
                  ),
                  // InputFields.formField1(
                  //   hintTxt: "Path",
                  //   controller: TextEditingController(),
                  // ),
                  FormButtonWrapper(
                    btnText: "Generate",
                    showIcon: true,
                    callback:(){
                      controller.callGenerate();
                    },
                  ),
                  // FormButton(
                  //   btnText: "Load",
                  //   callback: controller.handleCheckAndUncheck,
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: controller.zoneWiseUtilizationResponseModel!.value.generate!.isEmpty
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    child: controller.zoneWiseUtilizationResponseModel!.value.generate!.isEmpty
                        ? null
                        : DataGridFromMap3(
                            mode: PlutoGridMode.selectWithOneTap,
                            checkBoxColumnKey: ["cancel"],
                            actionIconKey: ['cancel'],
                            specificWidth: {
                              "clientname": 200,
                            },
                      onColumnHeaderDoubleTap: (String val){
                              print(">>>>>"+val);
                      },
                      onRowDoubleTap: (val){

                      },
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                            mapData:controller.zoneWiseUtilizationResponseModel!.value.generate!.map((e) => e.toJson()).toList(),
                          ),
                  );
                },
              ),
            ),

            /// bottom common buttons
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (btncontroller) {
                    if (btncontroller.buttons != null) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 0),
                        child: SizedBox(
                          height: 40,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 15,
                            alignment: WrapAlignment.center,
                            children: [
                              for (var btn in btncontroller.buttons!) ...{
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback: ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                      ? null
                                      : () => controller.formHandler(btn['name']),
                                )
                              },
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
