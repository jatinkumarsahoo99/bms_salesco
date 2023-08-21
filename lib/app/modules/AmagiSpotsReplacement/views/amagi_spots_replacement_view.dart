import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/amagi_spots_replacement_controller.dart';

class AmagiSpotsReplacementView
    extends GetView<AmagiSpotsReplacementController> {
   AmagiSpotsReplacementView({Key? key}) : super(key: key);

   AmagiSpotsReplacementController controllerX =
   Get.put<AmagiSpotsReplacementController>(AmagiSpotsReplacementController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          // width: size.width * 0.94,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(()=>DropDownField.formDropDown1WidthMap(
                      controllerX.locationList.value??[],
                          (value) {
                        controllerX.selectedLocation = value;
                      }, "Location", .13,
                      isEnable: controllerX.isEnable,
                      selected: controllerX.selectedLocation,
                      dialogHeight: Get.height * .7,
                      autoFocus: true,),),
                    SizedBox(
                      width: 3,
                    ),
                    Obx(()=>DropDownField.formDropDown1WidthMap(
                      controllerX.locationList.value??[],
                          (value) {
                        controllerX.selectedLocation = value;
                      }, "Channel", .13,
                      isEnable: controllerX.isEnable,
                      selected: controllerX.selectedLocation,
                      dialogHeight: Get.height * .7,
                      autoFocus: true,),),
                    SizedBox(
                      width: 3,
                    ),
                    DateWithThreeTextField(
                      title: "Schedule Date",
                      mainTextController: controllerX.frmDate,
                      widthRation: .1,
                      isEnable: controllerX.isEnable,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Obx(()=>DropDownField.formDropDown1WidthMap(
                      controllerX.locationList.value??[],
                          (value) {
                        controllerX.selectedLocation = value;
                      }, "Objective", .13,
                      isEnable: controllerX.isEnable,
                      selected: controllerX.selectedLocation,
                      dialogHeight: Get.height * .7,
                      autoFocus: true,),),
                    SizedBox(
                      width: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(value: false, onChanged: (val){}),
                          Text("Allow Merge")
                        ],
                      ),
                    ),
                    DateWithThreeTextField(
                      title: "To Date",
                      mainTextController: controllerX.toDate,
                      widthRation: .1,
                      isEnable: controllerX.isEnable,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Data",
                            callback: () {
                              // controllerX.fetchGetGenerate();
                            },
                            showIcon: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Promos",
                            callback: () {
                              // controllerX.fetchGetGenerate();
                            },
                            showIcon: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Excel",
                            callback: () {
                              // controllerX.fetchGetGenerate();
                            },
                            showIcon: true,
                          ),
                        ),
                      ],
                    ),



                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  // flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    child:  GetBuilder<AmagiSpotsReplacementController>(
                        id: "grid",
                        builder: (controllerX) {
                          return Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex:5,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex:5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex:5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey)),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex:5,
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputFields.formField1(
                                            hintTxt: "Available",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "Allocated",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputFields.formField1(
                                            hintTxt: "Un Allocated",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "Balance",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputFields.formField1(
                                            hintTxt: "Ms Time",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "LS Alloc",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InputFields.formField1(
                                            hintTxt: "LS Rev",
                                            controller: TextEditingController(),
                                            width:  0.2,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Deallocate",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Allocate",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Checkbox(value: true, onChanged: (val){}),
                                          Text("Show Allowed")
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Deal Hold",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Summary",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Un Alloc",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 10, right: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.1,
                                              child: FormButtonWrapper(
                                                btnText: "Clients",
                                                callback: () {
                                                  // controllerX.callGetRetrieve();
                                                },
                                                showIcon: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, left: 10, right: 10),
                                        child: FormButtonWrapper(
                                          btnText: "Total",
                                          callback: () {
                                            // controllerX.callGetRetrieve();
                                          },
                                          showIcon: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          InputFields.formField1(
                                            hintTxt: "Lo Dur",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "Lo Dur Mis",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          InputFields.formField1(
                                            hintTxt: "Lo Total",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                          InputFields.formField1(
                                            hintTxt: "Lo Miss",
                                            controller: TextEditingController(),
                                            width:  0.1,
                                            // autoFocus: true,
                                            // isEnable: controllerX.isEnable,
                                            onchanged: (value) {

                                            },
                                            // autoFocus: true,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex:10,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    ),

                  ),
                ),
                SizedBox(height: 5),
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
                        element.appFormName == "frmSPReports");
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
      ),
    );
  }
}
