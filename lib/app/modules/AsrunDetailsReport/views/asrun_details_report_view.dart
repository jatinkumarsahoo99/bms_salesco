import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/asrun_details_report_controller.dart';

class AsrunDetailsReportView extends StatelessWidget {
  AsrunDetailsReportView({Key? key}) : super(key: key);

  AsrunDetailsReportController controllerX =
      Get.put<AsrunDetailsReportController>(AsrunDetailsReportController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /* AppBar(
                title: Text('Asrun Details Report'),
                centerTitle: true,
                backgroundColor: Colors.deepPurple,
              ),*/
              SizedBox(
                height: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => DropDownField.formDropDown1WidthMap(
                            controllerX.locationList.value ?? [],
                            (value) {
                              controllerX.selectedLocation = value;
                            },
                            "Location",
                            .22,
                            isEnable: controllerX.isEnable,
                            selected: controllerX.selectedLocation,
                            dialogHeight: Get.height * .35,
                            autoFocus: true,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        DropDownField().formDropDownCheckBoxMap(
                          controllerX.channels,
                              (value) {
                            print(value);
                          },
                          "Channel",
                          0.22,
                          onChanged: (index, selectValue) {},
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        DateWithThreeTextField(
                          title: "From Date",
                          mainTextController: controllerX.frmDate,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        DateWithThreeTextField(
                          title: "To Date",
                          mainTextController: controllerX.toDate,
                          widthRation: .1,
                          isEnable: controllerX.isEnable,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 17.0, left: 10, right: 10),
                          child: SizedBox(
                            width: Get.width * 0.1,
                            child: FormButtonWrapper(
                              btnText: "Genrate",
                              callback: () {
                                controllerX.fetchGetGenerate();
                              },
                              showIcon: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                // flex: 9,
                child: Container(
                  child: GetBuilder<AsrunDetailsReportController>(
                      id: "grid",
                      builder: (controllerX) {
                        return Container(
                          child: (controllerX.asrunDetailsReportModel != null &&
                                  controllerX
                                          .asrunDetailsReportModel!.generate !=
                                      null &&
                                  controllerX.asrunDetailsReportModel!.generate!
                                      .isNotEmpty)
                              ? DataGridFromMap(
                                  showSrNo: true,
                                  hideCode: false,
                                  formatDate: false,
                                  colorCallback: (row) => (row.row.cells
                                          .containsValue(controllerX
                                              .stateManager?.currentCell))
                                      ? Colors.deepPurple.shade200
                                      : Colors.white,
                                  exportFileName: "Asrun Details Report",
                                  widthSpecificColumn:
                                      Get.find<HomeController>()
                                          .getGridWidthByKey(
                                              userGridSettingList:
                                                  controllerX.userGridSetting1),
                                  mapData: (controllerX
                                          .asrunDetailsReportModel!.generate
                                          ?.map((e) => e.toJson())
                                          .toList()) ??
                                      [
                                        {"noData": "noData"}
                                      ],
                                  // mapData: (controllerX.dataList)!,
                                  widthRatio: Get.width / 9 - 1,
                                  onload: (PlutoGridOnLoadedEvent load) {
                                    controllerX.stateManager =
                                        load.stateManager;
                                  },
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 8,
              ),

              /// bottom common buttons
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions =
                          Get.find<MainController>().permissionList!.lastWhere(
                              (element) =>
                                  element.appFormName ==
                                  "frmAsrundetailsReport");
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
            ],
          ),
        ),
      ),
    );
  }
}
