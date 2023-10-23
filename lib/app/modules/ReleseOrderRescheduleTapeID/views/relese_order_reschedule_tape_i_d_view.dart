import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/app/routes/app_pages.dart';
import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/CheckBox/app_check_box.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/relese_order_reschedule_tape_i_d_controller.dart';

class ReleseOrderRescheduleTapeIDView extends StatelessWidget {
  const ReleseOrderRescheduleTapeIDView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReleseOrderRescheduleTapeIDController());
    return Scaffold(
      body: GetBuilder<ReleseOrderRescheduleTapeIDController>(
        init: controller,
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
                        callback: () {
                          Get.delete<ReleseOrderRescheduleTapeIDController>();
                          Get.find<HomeController>().clearPage1();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  Obx(() {
                    return AppCheckBox(
                      title: "Apply For All",
                      value: controller.isAllCheck.value,
                      onChanged: (val) {
                        if (controller.selectedTapeRight == null ||
                            controller.lstBookingDetails.isEmpty) {
                          controller.isAllCheck.value = false;
                          controller.isAllCheck.refresh();
                          LoadingDialog.callInfoMessage(
                            controller.lstBookingDetails.isEmpty
                                ? "No optional TapeID found for replacing existing TapeID."
                                : "Please replaceble Tapecode.",
                          );
                        } else {
                          controller.isAllCheck.value =
                              !controller.isAllCheck.value;
                          for (var i = 0;
                              i < controller.lstBookingDetails.length;
                              i++) {
                            controller.lstBookingDetails[i].action =
                                controller.isAllCheck.value;
                          }
                          controller.lstBookingDetails.refresh();
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            controller.changeExportTapeCode();
                          });
                        }
                      },
                    );
                  }),

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
                              exportFileName: "RO Reschedule By Tapecode",
                              hideKeys: const [
                                'programCode',
                                'revType',
                                'tapeLanguage',
                                'edit',
                                'midPre',
                                'positionCode'
                              ],
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
                                if (controller.lastSelectedRow != null) {
                                  loadEvent.stateManager.setCurrentCell(
                                      loadEvent.stateManager
                                          .getRowByIdx(
                                              controller.lastSelectedRow)
                                          ?.cells['action'],
                                      controller.lastSelectedRow);
                                  loadEvent.stateManager.moveScrollByRow(
                                      PlutoMoveDirection.down,
                                      controller.lastSelectedRow);
                                } else {
                                  controller.lastSelectedRow = 0;
                                }
                              },
                              onSelected: (event) {
                                controller.lastSelectedRow = event.rowIdx;
                                controller.tapeCodeCaptionRight.value = event
                                    .row!.cells['commercialCaption']!.value
                                    .toString();
                                controller.tapeCodeDuraRight.value = event
                                    .row!.cells['tapeDuration']!.value
                                    .toString();
                              },
                              mode: PlutoGridMode.selectWithOneTap,
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
                          width: context.devicewidth * .23,
                          child: Obx(() {
                            if (controller.lstBookingDetails.isEmpty) {
                              return SizedBox();
                            }
                            return Column(
                              children: [
                                Obx(() {
                                  return DropDownField.formDropDown1WidthMap(
                                    controller.tapeListRight.value,
                                    (val) {
                                      controller.selectedTapeRight = val;
                                    },
                                    "Tape Code",
                                    .2,
                                    selected: controller.selectedTapeRight,
                                  );
                                }),
                                const SizedBox(height: 5),
                                Obx(
                                  () => InputFields.formFieldDisable1(
                                    hintTxt: "Dur",
                                    value: controller.tapeCodeDuraRight.value,
                                    widthRatio: .2,
                                    leftPad: 0,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Obx(
                                  () => InputFields.formFieldDisable1(
                                    hintTxt: "Caption",
                                    value:
                                        controller.tapeCodeCaptionRight.value,
                                    widthRatio: .2,
                                    leftPad: 0,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FormButton(
                                  btnText: "Modify",
                                  callback: controller.changeExportTapeCode,
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

                  /// Common Buttons
                  Get.find<HomeController>()
                      .getCommonButton<ReleseOrderRescheduleTapeIDController>(
                    Routes.COMMERCIAL_CREATION_AUTO,
                    (formName) {
                      if (formName == "Save") {
                        controller.saveData(
                          Get.find<MainController>().user!.logincode!,
                          controller.selectedLocation,
                          controller.selectedChannel,
                          controller.selectedClient,
                          controller.selectedAgency,
                          controller.selectedBrand,
                          controller.fromDateTC.text,
                          controller.toDateTC.text,
                          controller.selectedTape,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
