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

import '../controllers/rate_cardfrom_deal_workflow_controller.dart';

class RateCardfromDealWorkflowView
    extends GetView<RateCardfromDealWorkflowController> {
   RateCardfromDealWorkflowView({Key? key}) : super(key: key);

   @override
  RateCardfromDealWorkflowController controller = Get.put<RateCardfromDealWorkflowController>
     (RateCardfromDealWorkflowController());

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
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Obx(() {
                    return DropDownField.formDropDown1WidthMap(
                      controller.locationList.value,
                      // controller.handleOnChangedLocation,
                      (val) {
                        controller.selectedLocation = val;
                        controller.getChannel(val.key ?? "");
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
                      (val) {
                        controller.selectedChannel = val;
                        controller.getExportData();
                      },
                      "Channel",
                      .15,
                      selected: controller.selectedChannel,
                    );
                  }),
                  InputFields.formField1(
                    hintTxt: "Path",
                    controller: controller.pathController,
                    width: 0.2
                  ),
                  FormButton(
                    btnText: "Export",
                    callback: () {
                      controller.exportBtn();
                    },
                  ),
                  FormButton(
                    btnText: "Load",
                    callback: controller.pickFile,
                  ),
                ],
              ),
            ),
            GetBuilder<RateCardfromDealWorkflowController>(
              id: "grid",
              builder: (controller) {
                return Expanded(
                  child:Container(
                    margin: EdgeInsets.all(16),
                    decoration: controller.gridData.export!.isEmpty
                        ? BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    )
                        : null,
                    child: (controller.gridData.export == null ||
                        (controller.gridData.export?.length??0) == 0)
                        ? null
                        : DataGridFromMap3(
                      mode: PlutoGridMode.selectWithOneTap,
                      showSrNo: true,
                      hideCode: false,
                      formatDate: false,
                      exportFileName: "Rate Card Deal WorkFlow",
                      mapData: controller.gridData.export!
                          .map((e) => e.toJson())
                          .toList(),
                      colorCallback: (row) => (row.row.cells
                          .containsValue(controller
                          .stateManager?.currentCell))
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                      onload: (PlutoGridOnLoadedEvent? event) {
                        controller.stateManager =
                            event?.stateManager;
                      },
                    ),
                  )
                );
              }
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
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
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
                                  callback: ((Utils.btnAccessHandler(
                                              btn['name'],
                                              controller.formPermissions!) ==
                                          null))
                                      ? null
                                      : () =>
                                          controller.formHandler(btn['name']),
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
