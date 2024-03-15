import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../data/user_data_settings_model.dart';
import '../controllers/GenerateBookingAHMDController.dart';

class GenerateBookingAHMDView extends GetView<GenerateBookingAHMDController> {
   GenerateBookingAHMDView({Key? key}) : super(key: key);
  GenerateBookingAHMDController controllerX =
  Get.put<GenerateBookingAHMDController>(
      GenerateBookingAHMDController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<GenerateBookingAHMDController>(
                id: "init",
                init: controllerX,
                builder: (logic) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownField.formDropDown1WidthMap(
                        controllerX.location ?? [],
                            (value) {
                          controllerX.selectedLocation = value;
                          controllerX.getChannel();
                          // controllerX.getMatchDetails(programCode: value.key??"");
                        },
                        "Location",
                        .16,
                        // isEnable: controllerX.isEnable.value,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .35,
                        autoFocus: true,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      DropDownField().formDropDownCheckBoxMap(
                        controllerX.channels,
                            (value) {
                          controllerX.selectedChannel = value;
                        },
                        "Channel",
                        0.16,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      DateWithThreeTextField(
                        title: "From",
                        mainTextController: controllerX.frmDt,
                        widthRation: .16,
                        // isEnable: controllerX.isEnable.value,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      DateWithThreeTextField(
                        title: "To",
                        mainTextController: controllerX.toDt,
                        widthRation: .16,
                        // isEnable: controllerX.isEnable.value,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Retrieve",
                          callback: () {
                            controllerX.showApiCall();
                          },
                          showIcon: true,
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 8,
            ),
            GetBuilder<GenerateBookingAHMDController>(
                id: "grid",
                init: controllerX,
                builder: (logic) {
                  return Expanded(
                      child: (controllerX.dataList != null &&
                          (controllerX.dataList?.isNotEmpty ?? false))
                          ? DataGridFromMap(
                        showSrNo: true,
                        exportFileName: "Generate Booking Report",
                        mode: PlutoGridMode.normal,
                        mapData: (controller.dataList!),
                        widthRatio: Get.width / 9 - 1,
                        onload: (PlutoGridOnLoadedEvent load) {
                          controller.gridStateManager = load.stateManager;
                        },
                        widthSpecificColumn: (controller
                            .userDataSettings?.userSetting
                            ?.firstWhere(
                                (element) =>
                            element.controlName ==
                                "gridStateManager",
                            orElse: () => UserSetting())
                            .userSettings),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
