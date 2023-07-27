import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../DealWorkDefinitionGridModel.dart';
import '../controllers/workflow_definition_controller.dart';

class WorkflowDefinitionView extends GetView<WorkflowDefinitionController> {
  WorkflowDefinitionView({Key? key}) : super(key: key);

  WorkflowDefinitionController controllerX =
      Get.put<WorkflowDefinitionController>(WorkflowDefinitionController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<WorkflowDefinitionController>(
                        id: "top",
                        builder: (controllerX) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            padding: const EdgeInsets.all(16),
                            child: FocusTraversalGroup(
                              policy: OrderedTraversalPolicy(),
                              child: ListView(
                                children: [
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.locationList.value ?? [],
                                      (value) {
                                        controllerX.selectedLocation = value;
                                        controllerX.selectedChannel = null;
                                        controllerX.onLeaveLocation(
                                            controllerX.selectedLocation?.key ??
                                                "");
                                      },
                                      "Location",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedLocation,
                                      /*onFocusChange: (val) {
                                        if (!val) {
                                          controllerX.onLeaveLocation(
                                              controllerX
                                                      .selectedLocation?.key ??
                                                  "");
                                        }
                                      },*/
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.channelList.value ?? [],
                                      (value) {
                                        controllerX.selectedChannel = value;
                                      },
                                      "Channel",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedChannel,
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.zoneList.value ?? [],
                                      (value) {
                                        controllerX.selectedZone = value;
                                        controllerX.selectedStation = null;
                                        controllerX.onLeaveZone(
                                            controllerX.selectedZone?.key ??
                                                "");
                                      },
                                      "Zone",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedZone,
                                      /* onFocusChange: (val) {
                                        if (!val) {
                                          controllerX.onLeaveZone(
                                              controllerX.selectedZone?.key ??
                                                  "");
                                        }
                                      },*/
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.stationList.value ?? [],
                                      (value) {
                                        controllerX.selectedStation = value;
                                      },
                                      "Station",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedStation,
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.teamList.value ?? [],
                                      (value) {
                                        controllerX.selectedTeam = value;
                                      },
                                      "Team",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedTeam,
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.typeList.value ?? [],
                                      (value) {
                                        controllerX.selectedType = value;
                                        controllerX.getDisplayApi();
                                      },
                                      "Type",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedType,
                                      /* onFocusChange: (val) {
                                        if (!val) {
                                          controllerX.getDisplayApi();
                                        }
                                      },*/
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Obx(() => RadioRow(
                                        items: ["Employee", "User Group"],
                                        groupValue:
                                            controllerX.selectRadio1.value ??
                                                "",
                                        onchange: (String v) {
                                          print(">>>>" + v);
                                          controllerX.selectRadio1.value = v;
                                          controllerX.selectRadio1.refresh();
                                        },
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  DropDownField.formDropDownSearchAPI2(
                                    GlobalKey(),
                                    context,
                                    width: context.width * 0.36,
                                    onchanged: (DropDownValue? val) {
                                      print(">>>" + val.toString());
                                      controllerX.selectedUser = val;
                                      // controllerX.getProductDetails(val?.key??"");
                                      // controllerX.fetchClientDetails((val?.value ??"")??"");
                                    },
                                    title: 'User',
                                    url: ApiFactory
                                        .DEAL_WORK_FLOW_DEFINITION_GET_USER_SEARCH,
                                    parseKeyForKey: "PersonnelNo",
                                    parseKeyForValue: 'Employees',
                                    selectedValue: controllerX.selectedProduct,
                                    autoFocus: true,
                                    // maxLength: 1
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  DropDownField.formDropDownSearchAPI2(
                                    GlobalKey(),
                                    context,
                                    width: context.width * 0.36,
                                    onchanged: (DropDownValue? val) {
                                      print(">>>" + val.toString());
                                      controllerX.selectedGroup = val;
                                      // controllerX.getProductDetails(val?.key??"");
                                      // controllerX.fetchClientDetails((val?.value ??"")??"");
                                    },
                                    title: 'Group',
                                    url: ApiFactory
                                        .DEAL_WORK_FLOW_DEFINITION_GET_GROUP_SEARCH,
                                    parseKeyForKey: "GroupID",
                                    parseKeyForValue: 'GroupName',
                                    selectedValue: controllerX.selectedGroup,
                                    autoFocus: true,
                                    // maxLength: 1
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "Step Name",
                                    controller: controllerX.stepNameController,
                                    width: 0.36,
                                    // autoFocus: true,
                                    // focusNode: controllerX.brandName,
                                    // isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InputFields.formField1(
                                    hintTxt: "FormName",
                                    controller: controllerX.formNameController,
                                    width: 0.36,
                                    // autoFocus: true,
                                    // focusNode: controllerX.brandName,
                                    // isEnable: controllerX.isEnable,
                                    onchanged: (value) {},
                                    autoFocus: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => RadioRow(
                                            items: ["Before", "After"],
                                            groupValue: controllerX
                                                    .selectRadio2.value ??
                                                "",
                                            onchange: (String v) {
                                              print(">>>>" + v);
                                              controllerX.selectRadio2.value =
                                                  v;
                                              controllerX.selectRadio2
                                                  .refresh();
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Add",
                                          callback: () {
                                            if (controllerX
                                                    .selectRadio2.value ==
                                                "After") {
                                              /*controllerX.gridStateManager?.insertRows((controllerX.selectedIndex??0)+1,
                                                  [PlutoRow(cells: {
                                                    "approvalSequenceID": PlutoCell(value: "0"),
                                                    "sequenceName": PlutoCell(value: controllerX.stepNameController.text??""),
                                                    "formName": PlutoCell(value: controllerX.formNameController.text??""),
                                                    "groupID": PlutoCell(value: controllerX.selectedGroup?.key??""),
                                                    "groupName": PlutoCell(value:controllerX.selectedGroup?.value??""),
                                                    "personnelNo": PlutoCell(value: controllerX.selectedUser?.key??""),
                                                    "employees": PlutoCell(value:controllerX.selectedUser?.value??""),
                                                  } )]);*/

                                              if (controllerX
                                                          .approvalSequenceId !=
                                                      null &&
                                                  controllerX
                                                          .approvalSequenceId !=
                                                      "" &&
                                                  controllerX
                                                          .approvalSequenceId !=
                                                      "0") {
                                                int selIndex =(controllerX.selectedIndex ?? 0)  ;
                                                controllerX
                                                        .dealWorkDefinitionGridModel
                                                        ?.display?[selIndex]
                                                        .approvalSequenceID =
                                                    int.parse(controllerX
                                                            .approvalSequenceId ??
                                                        "0");
                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .employees = controllerX
                                                        .selectedUser?.value ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .formName = controllerX
                                                        .formNameController
                                                        .text ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .personnelNo = controllerX
                                                        .selectedUser?.key ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .groupID = int.parse(controllerX
                                                        .selectedGroup?.key ??
                                                    "0");

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .sequenceName = controllerX
                                                        .stepNameController
                                                        .text ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[selIndex]
                                                    .groupName = controllerX
                                                        .selectedGroup?.value ??
                                                    "";
                                              } else {
                                                int selIndex =(controllerX.selectedIndex ?? 0) +1  ;
                                                controllerX.dealWorkDefinitionGridModel?.display?.insert(
                                                    selIndex,
                                                    Display(
                                                        approvalSequenceID: int.parse(
                                                            controllerX.approvalSequenceId ??
                                                                "0"),
                                                        employees: controllerX
                                                                .selectedUser
                                                                ?.value ??
                                                            "",
                                                        formName: controllerX
                                                                .formNameController
                                                                .text ??
                                                            "",
                                                        groupID: int.parse(controllerX
                                                                .selectedGroup
                                                                ?.key ??
                                                            "0"),
                                                        groupName: controllerX
                                                                .selectedGroup
                                                                ?.value ??
                                                            "",
                                                        personnelNo:
                                                            controllerX.selectedUser?.key ?? "",
                                                        sequenceName: controllerX.stepNameController.text ?? ""));
                                              }
                                              controllerX.clearNew();
                                              controllerX.update(['grid']);
                                            } else {
                                              /* controllerX.gridStateManager?.insertRows((controllerX.selectedIndex??0),
                                                  [PlutoRow(cells: {
                                                    "approvalSequenceID": PlutoCell(value: "0"),
                                                    "sequenceName": PlutoCell(value: controllerX.stepNameController.text??""),
                                                    "formName": PlutoCell(value: controllerX.formNameController.text??""),
                                                    "groupID": PlutoCell(value: controllerX.selectedGroup?.key??""),
                                                    "groupName": PlutoCell(value:controllerX.selectedGroup?.value??""),
                                                    "personnelNo": PlutoCell(value: controllerX.selectedUser?.key??""),
                                                    "employees": PlutoCell(value:controllerX.selectedUser?.value??""),
                                                  } )]);*/
                                              if (controllerX
                                                          .approvalSequenceId !=
                                                      null &&
                                                  controllerX
                                                          .approvalSequenceId !=
                                                      "" &&
                                                  controllerX
                                                          .approvalSequenceId !=
                                                      "0") {
                                                controllerX
                                                        .dealWorkDefinitionGridModel
                                                        ?.display?[controllerX
                                                                .selectedIndex ??
                                                            0]
                                                        .approvalSequenceID =
                                                    int.parse(controllerX
                                                            .approvalSequenceId ??
                                                        "0");
                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .employees = controllerX
                                                        .selectedUser?.value ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .formName = controllerX
                                                        .formNameController
                                                        .text ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .personnelNo = controllerX
                                                        .selectedUser?.key ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .groupID = int.parse(controllerX
                                                        .selectedGroup?.key ??
                                                    "0");

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .sequenceName = controllerX
                                                        .stepNameController
                                                        .text ??
                                                    "";

                                                controllerX
                                                    .dealWorkDefinitionGridModel
                                                    ?.display?[controllerX
                                                            .selectedIndex ??
                                                        0]
                                                    .groupName = controllerX
                                                        .selectedGroup?.value ??
                                                    "";
                                              } else {
                                                controllerX.dealWorkDefinitionGridModel?.display?.insert(
                                                    controllerX.selectedIndex ??
                                                        0,
                                                    Display(
                                                        approvalSequenceID: int.parse(
                                                            controllerX.approvalSequenceId ??
                                                                "0"),
                                                        employees: controllerX
                                                                .selectedUser
                                                                ?.value ??
                                                            "",
                                                        formName: controllerX
                                                                .formNameController
                                                                .text ??
                                                            "",
                                                        groupID: int.parse(controllerX
                                                                .selectedGroup
                                                                ?.key ??
                                                            "0"),
                                                        groupName: controllerX
                                                                .selectedGroup
                                                                ?.value ??
                                                            "",
                                                        personnelNo:
                                                            controllerX.selectedUser?.key ?? "",
                                                        sequenceName: controllerX.stepNameController.text ?? ""));
                                              }
                                              controllerX.clearNew();
                                              controllerX.update(['grid']);
                                            }
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Clear",
                                          callback: () {
                                            controllerX.clearNew();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Copy To",
                                          callback: () {
                                            showCopyTo(context);
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: GetBuilder<WorkflowDefinitionController>(
                          id: "grid",
                          builder: (controllerX) {
                            return (controllerX.dealWorkDefinitionGridModel !=
                                        null &&
                                    controllerX.dealWorkDefinitionGridModel
                                            ?.display !=
                                        null &&
                                    (controllerX.dealWorkDefinitionGridModel
                                                ?.display?.length ??
                                            0) >
                                        0)
                                ? DataGridFromMap(
                                    showSrNo: false,
                                    hideCode: false,
                                    formatDate: false,
                                    mode: PlutoGridMode.selectWithOneTap,
                                    onload: (PlutoGridOnLoadedEvent load) {
                                      controllerX.gridStateManager =
                                          load.stateManager;
                                      controllerX.gridStateManager!
                                          .setCurrentCell(
                                              controllerX.gridStateManager!
                                                  .getRowByIdx(controllerX
                                                      .selectedIndex)!
                                                  .cells['sequenceName'],
                                              controllerX.selectedIndex);
                                      controllerX.gridStateManager!
                                          .moveCurrentCellByRowIdx(
                                              controllerX.selectedIndex ?? 0,
                                              PlutoMoveDirection.down);
                                    },
                                    onSelected:
                                        (PlutoGridOnSelectedEvent? val) {
                                      controllerX.selectedIndex =
                                          val?.rowIdx ?? 0;
                                    },
                                    onRowDoubleTap:
                                        (PlutoGridOnRowDoubleTapEvent? val) {
                                      controllerX.onDoubleTap(val?.rowIdx ?? 0);
                                    },
                                    mapData: (controllerX
                                        .dealWorkDefinitionGridModel!.display
                                        ?.map((e) => e.toJson())
                                        .toList())!,
                                    // mapData: (controllerX.dataList)!,
                                    widthRatio: Get.width / 9 - 1,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                  );
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 7),
          GetBuilder<HomeController>(
              id: "buttons",
              init: Get.find<HomeController>(),
              builder: (controller) {
                PermissionModel formPermissions = Get.find<MainController>()
                    .permissionList!
                    .lastWhere(
                        (element) => element.appFormName == "frmBrandMaster");
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
                return Container();
              })
        ],
      ),
    );
  }

  showCopyTo(context) {
    return Get.defaultDialog(
      barrierDismissible: true,
      title: "Copy To",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      content: Container(
        height: Get.height * 0.65,
        width: Get.width * 0.4,
        child: Column(
          children: [
            Obx(
              () => DropDownField.formDropDown1WidthMap(
                controllerX.locationList.value ?? [],
                (value) {
                  controllerX.selectedCopyToLocation = value;
                  controllerX.onLeaveLocation(
                      controllerX.selectedCopyToLocation?.key ?? "");
                },
                "Location",
                0.36,
                isEnable: controllerX.isEnable.value,
                selected: controllerX.selectedCopyToLocation,
                dialogHeight: Get.height * .35,
                autoFocus: true,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Obx(
              () => DropDownField.formDropDown1WidthMap(
                controllerX.channelList.value ?? [],
                (value) {
                  controllerX.selectedCopyToChannel = value;
                },
                "Channel",
                0.36,
                isEnable: controllerX.isEnable.value,
                selected: controllerX.selectedCopyToChannel,
                dialogHeight: Get.height * .35,
                autoFocus: true,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Obx(
              () => DropDownField.formDropDown1WidthMap(
                controllerX.copyToZoneList.value ?? [],
                (value) {
                  controllerX.selectedCopyToZone = value;
                  controllerX.onLeaveCopyToZone(
                      controllerX.selectedCopyToZone?.key ?? "");
                },
                "Zone",
                0.36,
                isEnable: controllerX.isEnable.value,
                selected: controllerX.selectedCopyToZone,
                dialogHeight: Get.height * .35,
                autoFocus: true,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(
              child: GetBuilder<WorkflowDefinitionController>(
                id: "copyToGrid",
                builder: (context) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: (controllerX.onLeaveCopyZoneModel != null &&
                            controllerX.onLeaveCopyZoneModel?.onLeaveCopyZone !=
                                null &&
                            (controllerX.onLeaveCopyZoneModel?.onLeaveCopyZone
                                        ?.length ??
                                    0) >
                                0)
                        ? ListView.builder(
                            itemCount: controllerX.onLeaveCopyZoneModel
                                    ?.onLeaveCopyZone?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  controllerX.selectedCopyToIndex = index;
                                  controllerX.update(['copyToGrid']);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Checkbox(
                                        value: controllerX.onLeaveCopyZoneModel
                                            ?.onLeaveCopyZone?[index].isChecked,
                                        onChanged: (val) {
                                          controllerX
                                              .onLeaveCopyZoneModel
                                              ?.onLeaveCopyZone?[index]
                                              .isChecked = val;
                                          controllerX.selectedCopyToIndex = index;
                                          controllerX.update(['copyToGrid']);
                                        }),
                                    Expanded(
                                      child: Container(
                                          color:
                                              (controllerX.selectedCopyToIndex == index)
                                                  ? Colors.deepPurpleAccent
                                                  : Colors.white,
                                          child: Text(
                                            controllerX
                                                    .onLeaveCopyZoneModel
                                                    ?.onLeaveCopyZone?[index]
                                                    .stationname ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    )
                                  ],
                                ),
                              );
                            })
                        : Container(),
                  );
                }
              ),
            )
          ],
        ),
      ),
      cancel: FormButtonWrapper(
        btnText: "Close",
        showIcon: false,
        callback: () {
          Get.back();
        },
      ),
      radius: 10,
    );
  }
}
