import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/amagi_status_report_controller.dart';

class AmagiStatusReportView extends GetView<AmagiStatusReportController> {
   AmagiStatusReportView({Key? key}) : super(key: key);

   AmagiStatusReportController controllerX =
  Get.put<AmagiStatusReportController>(AmagiStatusReportController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.84,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Amagi Spot Status'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value??[],
                            (value) {
                          controllerX.selectedLocation = value;
                          controllerX.getChannel(value.key??"");
                        }, "Location", .15,
                        isEnable: controllerX.isEnable.value,
                        selected: controllerX.selectedLocation,
                        dialogHeight: Get.height * .35,
                        autoFocus: true,),),

                      Obx(()=>DropDownField.formDropDown1WidthMap(
                        controllerX.channelList.value??[],
                            (value) {
                              controllerX.selectedChannel = value;
                        }, "channel", .15,
                        isEnable: controllerX.isEnable.value,
                        selected: controllerX.selectedChannel,
                        dialogHeight: Get.height * .35,
                        autoFocus: true,),),

                      DateWithThreeTextField(
                        title: "From",
                        mainTextController: controllerX.fromDateController,
                        widthRation: .1,
                        isEnable: controllerX.isEnable.value,
                      ),
                      DateWithThreeTextField(
                        title: "To",
                        mainTextController: controllerX.toDateController,
                        widthRation: .1,
                        isEnable: controllerX.isEnable.value,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Retrieve",
                          callback: () {
                            // controllerX.callGetRetrieve();
                          },
                          showIcon: false,
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioRow(
                      items: [
                        "Day Wise",
                        "Time Band",
                        "Serviced",
                        "Yield",
                        "Data"
                      ],
                      groupValue:
                      controllerX.selectValue.value ?? "",
                      onchange: (String v) {
                        print(">>>>"+v);
                        controllerX.selectValue.value=v;
                        controllerX.selectValue.refresh();
                      },
                    ),
                  ),
                  Expanded(
                    // flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child:  GetBuilder<AmagiStatusReportController>(
                            id: "grid",
                            builder: (controllerX) {
                              return  (controllerX.responseData['report'].length > 0)?
                               DataGridFromMap(
                                  showSrNo: false,
                                  hideCode: false,
                                  formatDate: false,
                                  mode: PlutoGridMode.selectWithOneTap,
                                  mapData: (controllerX.responseData['report']),
                                  // mapData: (controllerX.dataList)!,
                                  widthRatio: Get.width / 9 - 1,
                              ):Container();
                            }
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions = Get.find<MainController>()
                            .permissionList!
                            .lastWhere((element) =>
                        element.appFormName == "frmAma_Planning");
                        if (controller.buttons != null) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                        return Container(child: Text("No"),);
                      })
                  /// bottom common buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
