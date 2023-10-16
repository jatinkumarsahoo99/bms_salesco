import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/app/routes/app_pages.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/relese_order_reschedule_tape_i_d_controller.dart';

class ReleseOrderRescheduleTapeIDView extends StatelessWidget {
  const ReleseOrderRescheduleTapeIDView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReleseOrderRescheduleTapeIDController>(
        init: Get.put(ReleseOrderRescheduleTapeIDController()),
        builder: (controller) {
          return SizedBox(
            width: context.devicewidth,
            height: context.deviceheight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Controlls
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.locationList.value,
                          (val) {
                            controller.selectedLocation = val;
                            controller.getChannel(val);
                          },
                          "Location",
                          .12,
                          selected: controller.selectedLocation,
                          inkWellFocusNode: controller.locationFN,
                          autoFocus: true,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.channelList.value,
                          (val) {
                            controller.selectedChannel = val;
                            controller.getClient(
                              controller.selectedLocation,
                              val,
                            );
                          },
                          "Channel",
                          .12,
                          selected: controller.selectedChannel,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.clientList.value,
                          (val) {
                            controller.selectedClient = val;
                            controller.getAgency(
                              controller.selectedLocation,
                              controller.selectedChannel,
                              val,
                            );
                          },
                          "Client",
                          .12,
                          selected: controller.selectedClient,
                          dialogWidth: 300,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.agencyList.value,
                          (val) {
                            controller.selectedAgency = val;
                            controller.getBrand(
                              controller.selectedLocation,
                              controller.selectedChannel,
                              controller.selectedClient,
                              val,
                            );
                          },
                          "Agency",
                          .12,
                          selected: controller.selectedAgency,
                          dialogWidth: 300,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.brandList.value,
                          (val) {
                            controller.selectedBrand = val;
                            controller.getTapeDetails(
                              controller.selectedLocation,
                              controller.selectedChannel,
                              controller.selectedClient,
                              controller.selectedAgency,
                              val,
                              controller.fromDateTC.text,
                              controller.toDateTC.text,
                            );
                          },
                          "Brand",
                          .12,
                          selected: controller.selectedBrand,
                        );
                      }),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.tapeList.value,
                          (val) {
                            controller.selectedTape = val;
                            controller.tapeCodeDura.value = val.key!;
                          },
                          "Tape Code",
                          .12,
                          selected: controller.selectedTape,
                        );
                      }),
                      Obx(() {
                        return InputFields.formFieldDisable1(
                          hintTxt: "TapeCode Duration",
                          value: controller.tapeCodeDura.value,
                          widthRatio: .12,
                        );
                      }),
                      Row(),
                      DateWithThreeTextField(
                        title: "Eff. From Date",
                        widthRation: .12,
                        mainTextController: controller.fromDateTC,
                      ),
                      DateWithThreeTextField(
                        widthRation: .12,
                        title: "Eff. To Date",
                        mainTextController: controller.toDateTC,
                      ),
                      FormButton(
                        btnText: "Search",
                        callback: () => controller.getBookingDetails(
                          controller.selectedLocation,
                          controller.selectedChannel,
                          controller.selectedClient,
                          controller.selectedAgency,
                          controller.selectedBrand,
                          controller.fromDateTC.text,
                          controller.toDateTC.text,
                          controller.selectedTape,
                        ),
                      ),
                      FormButton(
                        btnText: "Clear",
                        callback: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Data table
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return DataGridFromMap3(
                              columnAutoResize: false,
                              mapData: controller.lstBookingDetails.value
                                  .map((e) => e.toJson())
                                  .toList(),
                              formatDate: false,
                              hideCode: false,
                              colorCallback: (event) {
                                if (event.row.cells['edit']?.value == "1") {
                                  return const Color.fromARGB(
                                      255, 128, 128, 128);
                                }
                                if (event.row.cells['bookingStatus']?.value ==
                                    "R") {
                                  return const Color.fromARGB(
                                      255, 188, 143, 143);
                                }
                                return Colors.white;
                              },
                              checkBoxStrComparison: "true",
                              uncheckCheckBoxStr: "false",
                              checkBoxColumnKey: ["action"],
                              actionIconKey: ["action"],
                              onload: (loadEvent) {
                                controller.stateManager =
                                    loadEvent.stateManager;
                              },
                              actionOnPress: (position, isSpaceCalled) {
                                if (isSpaceCalled) {
                                  var newVal = !(controller
                                          .stateManager!
                                          .refRows[position.rowIdx!]
                                          .cells['action']!
                                          .value ==
                                      "true");
                                  controller
                                      .lstBookingDetails[controller
                                          .stateManager!
                                          .refRows[position.rowIdx!]
                                          .sortIdx]
                                      .action = newVal;
                                }
                              },
                              onEdit: (event) {
                                controller.lstBookingDetails[event.row.sortIdx]
                                    .action = (event.value == "true");
                              },
                            );
                          }),
                        ),
                        SizedBox(
                          width: context.devicewidth * .3,
                          child: Column(
                            children: [
                              Obx(() {
                                return DropDownField.formDropDown1WidthMap(
                                  controller.tapeListRight.value,
                                  (val) {
                                    controller.selectedTapeRight = val;
                                  },
                                  "Tape Code",
                                  .12,
                                  selected: controller.selectedTapeRight,
                                );
                              }),
                              FormButton(
                                btnText: "Modify",
                                callback: controller.changeExportTapeCode,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

                  /// Common Buttons
                  Get.find<HomeController>()
                      .getCommonButton<ReleseOrderRescheduleTapeIDController>(
                          Routes.COMMERCIAL_CREATION_AUTO, (formName) {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  formhandler(String btnName) {
    switch (btnName) {
      case "Clear":
        break;
    }
  }
}
