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
import '../controllers/amagi_spot_planning_controller.dart';

class AmagiSpotPlanningView extends GetView<AmagiSpotPlanningController> {
   AmagiSpotPlanningView({Key? key}) : super(key: key);

   AmagiSpotPlanningController controllerX =
   Get.put<AmagiSpotPlanningController>(AmagiSpotPlanningController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    }, "Location", .17,
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
                    }, "channel", .17,
                    isEnable: controllerX.isEnable.value,
                    selected: controllerX.selectedChannel,
                    dialogHeight: Get.height * .35,
                    autoFocus: true,),),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "Scheduled Date",
                    mainTextController: controllerX.scheduleDateController,
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
                      btnText: "Data",
                      callback: () {
                        controllerX.generateBtn();
                      },
                      showIcon: true,
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Obx(()=>RadioRow(
                   items: [
                     "Master Spots",
                     "Channel",
                     "Client",
                     "Data"
                   ],
                   groupValue:
                   controllerX.selectValue.value ?? "",
                   onchange: (String v) {
                     print(">>>>"+v);
                     controllerX.selectValue.value=v;
                     controllerX.selectValue.refresh();
                     controllerX.getRadioType(v).then((value) {
                       controllerX.generateBtn();
                     });
                   },
                 )) ,
                ],
              ),
              Expanded(
                // flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)),
                  child:  GetBuilder<AmagiSpotPlanningController>(
                      id: "grid",
                      builder: (controllerX) {
                        return (controllerX.responseData['report'].length > 0)?
                        Container(
                          child: DataGridFromMap(
                            showSrNo: false,
                            hideCode: false,
                            formatDate: false,
                            widthSpecificColumn:  Get.find<HomeController>().getGridWidthByKey(key: controllerX.getTableNo(controllerX.selectValue.value)?? "tbl1",userGridSettingList: controllerX.userGridSetting1),
                            exportFileName: "Amagi Spot Planning",
                            mode: PlutoGridMode.selectWithOneTap,
                            mapData: (controllerX.responseData['report']),
                            // mapData: (controllerX.dataList)!,
                            widthRatio: Get.width / 9 - 1,
                            onload: (PlutoGridOnLoadedEvent load){
                              controllerX.stateManager = load.stateManager;
                            },
                          ),
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
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
