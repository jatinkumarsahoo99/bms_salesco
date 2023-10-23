import 'package:bms_salesco/widgets/CheckBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/make_good_report_controller.dart';

class MakeGoodReportView extends GetView<MakeGoodReportController> {
  const MakeGoodReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Controllers
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Obx(() {
                      return DropDownField.formDropDown1WidthMap(
                        controller.locationList.value,
                        (v) => controller.selectedLocation = v,
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
                        (v) {
                          controller.selectedChannel = v;
                        },
                        "Channel",
                        .15,
                        selected: controller.selectedChannel,
                      );
                    }),
                    DateWithThreeTextField(
                      title: "From Date",
                      mainTextController: controller.fromDateTC,
                      widthRation: 0.15,
                    ),
                    DateWithThreeTextField(
                      title: "To Date",
                      mainTextController: controller.toDateTC,
                      widthRation: 0.15,
                      onFocusChange: (date) {
                        controller.getClient();
                      },
                    ),
                    Obx(() {
                      return DropDownField.formDropDown1WidthMap(
                        controller.clientList.value,
                        (v) {
                          controller.selectedClient = v;
                          controller.getAgency();
                        },
                        "Client",
                        .15,
                        selected: controller.selectedClient,
                        isEnable: controller.controllsEnable.value,
                        inkWellFocusNode: controller.clientFN,
                      );
                    }),
                    Obx(() {
                      return DropDownField.formDropDown1WidthMap(
                        controller.agencyList.value,
                        (v) {
                          controller.selectedAgency = v;
                          controller.getBrand();
                        },
                        "Agency",
                        .15,
                        selected: controller.selectedAgency,
                        isEnable: controller.controllsEnable.value,
                      );
                    }),
                    Obx(() {
                      return DropDownField.formDropDown1WidthMap(
                        controller.brandList.value,
                        (v) => controller.selectedBrand = v,
                        "Brand",
                        .15,
                        selected: controller.selectedBrand,
                        isEnable: controller.controllsEnable.value,
                      );
                    }),
                    Obx(() {
                      return CheckBoxWidget1(
                        title: "All Clients",
                        value: !controller.controllsEnable.value,
                        onChanged: (val) {
                          controller.controllsEnable.value =
                              !(controller.controllsEnable.value);
                        },
                      );
                    }),
                    FormButton(
                        btnText: "Report", callback: controller.generateReport),
                  ],
                ),
              ),

              ///Data table
              Expanded(
                child: Obx(
                  () {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: controller.dataTableList.value.isEmpty
                          ? BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            )
                          : null,
                      child: controller.dataTableList.value.isEmpty
                          ? null
                          : DataGridFromMap3(
                              onload: (PlutoGridOnLoadedEvent load) {
                                controller.stateManager = load.stateManager;
                              },
                              exportFileName: "Make Good Report",
                              hideCode: false,
                              colorCallback: (row) => row.row.cells
                                      .containsValue(
                                          controller.stateManager?.currentCell)
                                  ? Colors.deepPurple.shade100
                                  : Colors.white,
                              columnAutoResize: false,
                              widthSpecificColumn: Get.find<HomeController>()
                                  .getGridWidthByKey(
                                      userGridSettingList:
                                          controller.userGridSetting1?.value),
                              mapData: controller.dataTableList.value,
                              formatDate: false,
                            ),
                    );
                  },
                ),
              ),

              ///Common Buttons
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (btncontroller) {
                      if (btncontroller.buttons != null) {
                        return Wrap(
                          spacing: 5,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: [
                            for (var btn in btncontroller.buttons!) ...{
                              FormButtonWrapper(
                                btnText: btn["name"],
                                callback: ((Utils.btnAccessHandler(btn['name'],
                                            controller.formPermissions!) ==
                                        null))
                                    ? null
                                    : () => controller.formHandler(btn['name']),
                              )
                            },
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
