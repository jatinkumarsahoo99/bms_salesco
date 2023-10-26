import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
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
                                      inkWellFocusNode: controllerX.locationNode,
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
                                    height: 2,
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
                                      inkWellFocusNode: controllerX.channelNode,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
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
                                      inkWellFocusNode: controllerX.zoneNode,
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
                                    height: 2,
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
                                      inkWellFocusNode: controllerX.stationNode,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
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
                                      inkWellFocusNode: controllerX.teamNode,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Obx(
                                    () => DropDownField.formDropDown1WidthMap(
                                      controllerX.typeList.value ?? [],
                                      (value) {
                                        controllerX.selectedType = value;

                                      },
                                      "Type",
                                      0.36,
                                      isEnable: controllerX.isEnable.value,
                                      selected: controllerX.selectedType,
                                      inkWellFocusNode: controllerX.typeNode,
                                       onFocusChange: (val) {
                                        if (!val) {
                                          if(controllerX.selectedType != null){
                                            controllerX.getDisplayApi();
                                          }
                                        }
                                      },
                                      dialogHeight: Get.height * .35,
                                      autoFocus: true,
                                    ),
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
                                          if(v == "Employee"){
                                            controllerX.userEnable.value = true;
                                            controllerX.groupEnable.value = false;
                                            controllerX.groupEnable.refresh();
                                            controllerX.userEnable.refresh();
                                          }else{
                                            controllerX.userEnable.value = false;
                                            controllerX.groupEnable.value = true;
                                            controllerX.groupEnable.refresh();
                                            controllerX.userEnable.refresh();
                                          }
                                        },
                                      )),
                                 Obx(()=>DropDownField.formDropDownSearchAPI2(
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
                                     selectedValue: controllerX.selectedUser,
                                     inkwellFocus:  controllerX.userNode,
                                     // autoFocus: true,
                                     isEnable: controllerX.userEnable.value
                                   // maxLength: 1
                                 ),) ,
                                  SizedBox(
                                    height: 2,
                                  ),
                                 Obx(()=>DropDownField.formDropDownSearchAPI2(
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
                                     inkwellFocus: controllerX.groupNode,
                                     isEnable: controllerX.groupEnable.value
                                   // maxLength: 1
                                 ),) ,
                                  SizedBox(
                                    height: 2,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => Padding(
                                        padding: const EdgeInsets.only(top: 8.0,left: 0),
                                        child: RadioRow(
                                              items: const ["Before", "After"],
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
                                            ),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Add",
                                          callback: () {
                                            controllerX.btnAddClick();
                                          },
                                          showIcon: true,
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
                                          showIcon: true,
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
                                          showIcon: true,
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
                                ? RawKeyboardListener(
                                  focusNode: FocusNode(),
                              onKey: (RawKeyEvent event) {
                                if (event.logicalKey ==
                                    LogicalKeyboardKey
                                        .delete &&
                                    event
                                    is! RawKeyUpEvent) {
                                  if (controllerX
                                      .gridStateManager !=
                                      null &&
                                      (controllerX
                                          .gridStateManager
                                          ?.rows
                                          .length ??
                                          0) >
                                          0) {
                                    print(
                                        "delete button pressed");
                                    controllerX
                                        .gridStateManager
                                        ?.removeCurrentRow();
                                    controllerX
                                        .gridStateManager
                                        ?.notifyListeners();
                                  } else {
                                    LoadingDialog
                                        .showErrorDialog(
                                        "Data not found");
                                  }
                                }
                              },
                                  child: DataGridFromMap(
                                      showSrNo: true,
                                      hideCode: false,
                                      formatDate: false,
                                      exportFileName: "WorkFlow Definition",
                                      mode: PlutoGridMode.selectWithOneTap,
                                      onload: (PlutoGridOnLoadedEvent load) {
                                        controllerX.gridStateManager =
                                            load.stateManager;
                                       /* controllerX.gridStateManager!
                                            .setCurrentCell(
                                                controllerX.gridStateManager!
                                                    .getRowByIdx(controllerX
                                                        .selectedIndex)!
                                                    .cells['sequenceName'],
                                                controllerX.selectedIndex);
                                        controllerX.gridStateManager!
                                            .moveCurrentCellByRowIdx(
                                                controllerX.selectedIndex ?? 0,
                                                PlutoMoveDirection.down);*/
                                      },
                                      onSelected:
                                          (PlutoGridOnSelectedEvent? val) {
                                            controllerX.isDoubleClick = false;

                                        controllerX.selectedIndex =
                                            val?.rowIdx ?? 0;
                                      },
                                      onRowDoubleTap:
                                          (PlutoGridOnRowDoubleTapEvent? val) {
                                            controllerX.selectedIndex =
                                                val?.rowIdx ?? 0;
                                            /*controllerX.gridStateManager!
                                                .setCurrentCell(
                                                controllerX.gridStateManager!
                                                    .getRowByIdx(controllerX
                                                    .selectedIndex)!
                                                    .cells['sequenceName'],
                                                controllerX.selectedIndex);
                                            controllerX.gridStateManager!
                                                .moveCurrentCellByRowIdx(
                                                controllerX.selectedIndex ?? 0,
                                                PlutoMoveDirection.down);*/
                                        controllerX.onDoubleTap(val?.rowIdx ?? 0);
                                            // controllerX.isDoubleClick = true;
                                      },
                              widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                                    userGridSettingList: controllerX.userGridSetting1),
                                      mapData: (controllerX
                                          .dealWorkDefinitionGridModel!.display
                                          ?.map((e) => e.toJson2())
                                          .toList())!,
                                      // mapData: (controllerX.dataList)!,
                                      widthRatio: Get.width / 9 - 1,
                                    ),
                                )
                                : Container();
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
        width: Get.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Obx(()=>Checkbox(value: controllerX.checkAll.value, onChanged: (val){
                   controllerX.checkAll.value =  val!;
                   controllerX.checkAllList(val);
                 }),),
                  Expanded(
                    child: GetBuilder<WorkflowDefinitionController>(
                        id: "copyToGrid",
                        builder: (context) {
                          return Container(
                            decoration:
                                BoxDecoration(border: Border.all(color: Colors.grey)),
                            child: (controllerX.onLeaveCopyZoneModel != null &&
                                    controllerX
                                            .onLeaveCopyZoneModel?.onLeaveCopyZone !=
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
                                        onTap: () {
                                          controllerX.selectedCopyToIndex = index;
                                          controllerX.update(['copyToGrid']);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Checkbox(
                                                value: controllerX
                                                    .onLeaveCopyZoneModel
                                                    ?.onLeaveCopyZone?[index]
                                                    .isChecked,
                                                onChanged: (val) {
                                                  controllerX
                                                      .onLeaveCopyZoneModel
                                                      ?.onLeaveCopyZone?[index]
                                                      .isChecked = val;
                                                  controllerX.selectedCopyToIndex =
                                                      index;
                                                  controllerX.update(['copyToGrid']);
                                                }),
                                            Expanded(
                                              child: Container(
                                                  color: (controllerX
                                                              .selectedCopyToIndex ==
                                                          index)
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
                        }),
                  ),
                ],
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
