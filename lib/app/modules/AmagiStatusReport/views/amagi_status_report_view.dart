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
                  SizedBox(
                    width: 5,
                  ),

                  Obx(()=>DropDownField.formDropDown1WidthMap(
                    controllerX.channelList.value??[],
                        (value) {
                          controllerX.selectedChannel = value;
                    }, "channel", .15,
                    isEnable: controllerX.isEnable.value,
                    selected: controllerX.selectedChannel,
                    dialogHeight: Get.height * .35,
                    autoFocus: true,),),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "From",
                    mainTextController: controllerX.fromDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "To",
                    mainTextController: controllerX.toDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Retrieve",
                      callback: () {
                        controllerX.retrieveData();
                      },
                      showIcon: true,
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  Obx(()=>RadioRow(
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
                      controllerX.getRadioStatus(v).then((value) {
                        controllerX.retrieveData();
                      });
                    },
                  ),),
                ],
              ),
              Expanded(
                // flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)),
                  child:  GetBuilder<AmagiStatusReportController>(
                      id: "grid",
                      builder: (controllerX) {
                        return  (controllerX.responseData['response'].length > 0)?
                         DataGridFromMap(
                            showSrNo: false,
                            hideCode: false,
                            formatDate: false,
                            widthSpecificColumn:  Get.find<HomeController>().getGridWidthByKey(
                                userGridSettingList: controllerX.userGridSetting1,key:controllerX.getTableNo(controllerX.selectValue.value) ??"tbl1"),
                            mode: PlutoGridMode.selectWithOneTap,
                            mapData: (controllerX.responseData['response']),
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                           onload: (PlutoGridOnLoadedEvent load){
                             controllerX.stateManager = load.stateManager;
                           },
                        ):Container();
                      }
                  ),

                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: GetBuilder<HomeController>(
                    id: "buttons",
                    init: Get.find<HomeController>(),
                    builder: (controller) {
                      PermissionModel formPermissions = Get.find<MainController>()
                          .permissionList!
                          .lastWhere((element) =>
                      element.appFormName == "frmAma_Planning");
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
                      return Container(child: Text("No"),);
                    }),
              )
              /// bottom common buttons
            ],
          ),
        ),
      ),
    );
  }
}
