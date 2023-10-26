import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../controllers/user_groups_for_deal_workflow_controller.dart';

class UserGroupsForDealWorkflowView
    extends GetView<UserGroupsForDealWorkflowController> {
  UserGroupsForDealWorkflowView({Key? key}) : super(key: key);

  UserGroupsForDealWorkflowController controllerX =
      Get.put<UserGroupsForDealWorkflowController>(
          UserGroupsForDealWorkflowController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.64,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('User groups For Deal Workflow'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputFields.formField1(
                                  hintTxt: "Group",
                                  controller: controllerX.groupTextController,
                                  width: 0.45,
                                  autoFocus: false,
                                  maxLen: 200,
                                  // focusNode: controllerX.brandName,
                                  // isEnable: controllerX.isEnable,
                                  onchanged: (value) {
                                    // controllerX.getDisPlay(value);
                                  },
                                  focusNode: controllerX.groupNode
                                  // autoFocus: true,
                                  ),
                              SizedBox(
                                height: 3,
                              ),
                              DropDownField.formDropDownSearchAPI2(
                                GlobalKey(),
                                context,
                                width: context.width * 0.45,
                                onchanged: (DropDownValue? val) {
                                  controllerX.selectedEmployee = val;
                                },
                                title: 'Employee',
                                url: ApiFactory
                                    .USER_GROUPS_FOR_DEAL_WORKFLOW_EmpSearch,
                                parseKeyForKey: "PersonnelNo",
                                parseKeyForValue: 'Employees',
                                selectedValue: controllerX.selectedEmployee,
                                autoFocus: false,
                                // maxLength: 1
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, left: 1, right: 10),
                                    child: FormButtonWrapper(
                                      btnText: "Add",
                                      callback: () {
                                        controllerX.addBtnClick();
                                      },
                                      showIcon: false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 5, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: GetBuilder<
                                    UserGroupsForDealWorkflowController>(
                                id: "grid",
                                builder: (controllerX) {
                                  return (controllerX.disPlayGroupModel !=
                                              null &&
                                          controllerX.disPlayGroupModel
                                                  ?.displayGroup !=
                                              null &&
                                          (controllerX
                                                      .disPlayGroupModel
                                                      ?.displayGroup
                                                      ?.employees
                                                      ?.length ??
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
                                            .stateManager !=
                                            null &&
                                            (controllerX
                                                .stateManager
                                                ?.rows
                                                .length ??
                                                0) >
                                                0) {
                                          print(
                                              "delete button pressed");
                                          controllerX
                                              .stateManager
                                              ?.removeCurrentRow();
                                          controller.stateManager?.setCurrentCell(controller.stateManager?.
                                          getRowByIdx(controller.stateManager?.currentRowIdx??0)?.cells['personnelno'],
                                              controller.stateManager?.currentRowIdx??0);
                                          controllerX
                                              .stateManager
                                              ?.notifyListeners();
                                        } else {
                                          LoadingDialog
                                              .showErrorDialog(
                                              "Data not found");
                                        }
                                      }
                                    },
                                        child: DataGridFromMap(
                                            showSrNo: false,
                                            hideCode: false,
                                            formatDate: false,
                                            mode: PlutoGridMode.selectWithOneTap,
                                            mapData: (controllerX
                                                .disPlayGroupModel!
                                                .displayGroup
                                                ?.employees
                                                ?.map((e) => e.toJson())
                                                .toList())!,
                                            // mapData: (controllerX.dataList)!,
                                            widthRatio: Get.width / 9 - 1,
                                            onload:
                                                (PlutoGridOnLoadedEvent load) {
                                              controllerX.stateManager =
                                                  load.stateManager;
                                              controller.stateManager?.setCurrentCell(controller.stateManager?.
                                              getRowByIdx(controller.stateManager?.currentRowIdx??0)?.cells['personnelno'],
                                                  controller.stateManager?.currentRowIdx??0);
                                              controller.stateManager?.moveCurrentCellByRowIdx(controller.stateManager?.currentRowIdx??0, PlutoMoveDirection.down);
                                            },
                                            widthSpecificColumn:
                                                Get.find<HomeController>()
                                                    .getGridWidthByKey(
                                              userGridSettingList:
                                                  controllerX.userGridSetting1,
                                            ),
                                          ),
                                      )
                                      : Container();
                                }),
                          ),
                        ),
                      ),

                      /// bottom common buttons
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions =
                            Get.find<MainController>()
                                .permissionList!
                                .lastWhere((element) =>
                                    element.appFormName ==
                                    "frmCommercialMaster");
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
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
