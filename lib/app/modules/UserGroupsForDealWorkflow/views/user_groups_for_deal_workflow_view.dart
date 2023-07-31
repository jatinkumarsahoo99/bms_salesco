import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
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
   Get.put<UserGroupsForDealWorkflowController>(UserGroupsForDealWorkflowController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.64,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('User groups For Deal Workflow'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InputFields.formField1(
                    hintTxt: "Group",
                    controller: controllerX.groupTextController,
                    width:  0.36,
                    // autoFocus: true,
                    // focusNode: controllerX.brandName,
                    // isEnable: controllerX.isEnable,
                    onchanged: (value) {

                    },
                    // autoFocus: true,
                  ),
                  DropDownField
                      .formDropDownSearchAPI2(
                    GlobalKey(),
                    context,
                    width: context.width *  0.36,
                    onchanged: (DropDownValue? val) {
                      controllerX.selectedEmployee = val;
                    },
                    title: 'Employee',
                    url:ApiFactory.USER_GROUPS_FOR_DEAL_WORKFLOW_EmpSearch,
                    parseKeyForKey: "productcode",
                    parseKeyForValue: 'Productname',
                    selectedValue: controllerX.selectedEmployee,
                    autoFocus: true,
                    // maxLength: 1
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Add",
                          callback: () {
                            // controllerX.callGetRetrieve();
                          },
                          showIcon: false,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: MediaQuery.of(context).size.height*0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child:  GetBuilder<UserGroupsForDealWorkflowController>(
                            id: "grid",
                            builder: (controllerX) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),

                              );
                            }
                        ),

                      ),
                    ),
                  ),
                  /// bottom common buttons
                  Align(
                    alignment: Alignment.topLeft,
                    child: GetBuilder<HomeController>(
                        id: "buttons",
                        init: Get.find<HomeController>(),
                        builder: (controller) {
                          PermissionModel formPermissions = Get.find<MainController>()
                              .permissionList!
                              .lastWhere((element) =>
                          element.appFormName == "frmCommercialMaster");
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
                        }),
                  ),
                  SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
