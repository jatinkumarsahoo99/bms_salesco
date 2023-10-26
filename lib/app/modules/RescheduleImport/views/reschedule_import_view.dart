import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/reschedule_import_controller.dart';

class RescheduleImportView extends GetView<RescheduleImportController> {
  RescheduleImportView({Key? key}) : super(key: key);

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
                      controller.handleOnChangedLocation,
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
                        inkWellFocusNode: controller.channelFN);
                  }),
                  Obx(
                    () {
                      return InputFields.formFieldDisableWidth(
                        hintTxt: "File Name",
                        value: controller.fileName.value,
                        widthRatio: .2,
                      );
                    },
                  ),
                  FormButton(
                    btnText: "Select",
                    callback: controller.selectFile,
                  ),
                  FormButton(
                    btnText: "Show",
                    callback: controller.showBtn,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: controller.dataTableList.isEmpty
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    child: controller.dataTableList.isEmpty
                        ? null
                        : DataGridFromMap(
                            formatDate: false,
                            mode: PlutoGridMode.selectWithOneTap,
                            mapData: controller.dataTableList.value.map((e) {
                              print(e);
                              if (e['Sch Date'].toString().contains('T')) {
                                e['Sch Date'] = DateFormat('dd-MM-yyyy').format(
                                    DateFormat('yyyy-MM-ddThh:mm:ss')
                                        .parse(e['Sch Date']));
                              }
                              if (e['NEW DATE'].toString().contains('T')) {
                                e['NEW DATE'] = DateFormat('dd-MM-yyyy').format(
                                    DateFormat('yyyy-MM-ddThh:mm:ss')
                                        .parse(e['NEW DATE']));
                              }
                              return e;
                            }).toList(),
                            widthSpecificColumn: Get.find<HomeController>()
                                .getGridWidthByKey(
                                    userGridSettingList:
                                        controller.userGridSetting1),
                            onload: (PlutoGridOnLoadedEvent load) {
                              controller.stateManager = load.stateManager;
                            },
                          ),
                  );
                },
              ),
            ),

            /// bottom common buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FormButton(
                  btnText: "Import",
                  callback: controller.saveRecord,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
