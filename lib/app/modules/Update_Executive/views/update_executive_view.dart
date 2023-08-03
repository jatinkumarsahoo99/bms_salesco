import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../controllers/update_executive_controller.dart';

class UpdateExecutiveView extends GetView<UpdateExecutiveController> {
   UpdateExecutiveView({Key? key}) : super(key: key);

   UpdateExecutiveController controllerX =
   Get.put<UpdateExecutiveController>(UpdateExecutiveController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * .55,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Update Executive'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocusTraversalGroup(
                    policy: OrderedTraversalPolicy(),
                    child: Column(
                      children: [
                        SizedBox(
                          width:MediaQuery.of(context).size.width*0.46,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(()=>DropDownField.formDropDown1WidthMap(
                                controllerX.locationList.value??[],
                                    (value) {
                                  controllerX.selectedLocation?.value = value;
                                }, "Location",
                                0.1,
                                isEnable: controllerX.isEnable,
                                inkWellFocusNode: controllerX.locationNode,
                                selected: controllerX.selectedLocation?.value,
                                dialogHeight: Get.height * .35,
                                autoFocus: false,),),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Obx(() {
                                  return DropDownField.formDropDown1WidthMap(
                                    controllerX.channelList.value,
                                        (val) {
                                      controllerX.selectedChannel?.value = val;
                                      controllerX.getClientList();
                                      },
                                    "Channel",
                                    .3,
                                   /* onFocusChange: (val){
                                      if(!val){

                                      }
                                    },*/
                                    inkWellFocusNode: controllerX.channelNode,
                                    autoFocus: false,
                                    dialogHeight: Get.height * .35,
                                    selected: controllerX.selectedChannel?.value,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),

                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.clientList .value??[],
                              (value) {
                            controllerX.selectedClient?.value = value;
                            controllerX.getAgencyList();
                          }, "Client",
                          0.46,
                          isEnable: controllerX.isEnable,
                          inkWellFocusNode: controllerX.clientNode,
                          selected: controllerX.selectedClient?.value,
                          dialogHeight: Get.height * .35,
                          /*onFocusChange: (val){
                            if(!val){
                              controllerX.getAgencyList();
                            }
                          },*/
                            autoFocus: false,),),
                        SizedBox(
                          height: 1,
                        ),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.agencyList.value??[],
                              (value) {
                            controllerX.selectedAgency?.value = value;
                          }, "Agency",
                          0.46,
                          isEnable: controllerX.isEnable,
                          inkWellFocusNode: controllerX.agencyNode,
                          selected: controllerX.selectedAgency?.value,
                          dialogHeight: Get.height * .35,
                          autoFocus: false,),),
                        SizedBox(
                          height: 1,
                        ),
                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.zoneList.value??[],
                              (value) {
                            controllerX.selectedZone?.value = value;
                          }, "Zone",
                          0.46,
                          isEnable: controllerX.isEnable,
                          inkWellFocusNode: controllerX.zoneNode,
                          selected: controllerX.selectedZone?.value,
                          dialogHeight: Get.height * .35,
                          autoFocus: false,),),
                        SizedBox(
                          width:MediaQuery.of(context).size.width*0.46,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DateWithThreeTextField(
                                title: "Date",
                                mainTextController:controllerX.date1Controller,
                                widthRation: .1,
                                isEnable: controllerX.isEnable,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    DateWithThreeTextField(
                                      title: "Date",
                                      mainTextController: controllerX.date2Controller,
                                      widthRation: .1,
                                      isEnable: controllerX.isEnable,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 10, right: 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width*0.1,
                                        child: FormButtonWrapper(
                                          btnText: "Show T.O",
                                          callback: () {
                                            controllerX.getVerify();
                                          },
                                          showIcon: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                             Obx(()=>Checkbox(value: controllerX.selectAll.value,
                                onChanged: (val){
                                  controllerX.selectAll.value = val!;
                                  controllerX.selectAllList();

                                })),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text("Select All"),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            width: MediaQuery.of(context).size.width*0.46,
                            height: MediaQuery.of(context).size.height*0.2,
                            child:  GetBuilder<UpdateExecutiveController>(
                                id: "grid",
                                builder: (controllerX) {
                                  return (controllerX.verifyDataModel != null &&
                                      controllerX.verifyDataModel?.verifiy != null &&
                                      (controllerX.verifyDataModel?.verifiy?.length??0) >0
                                  )?Container(
                                    child:ListView.builder(
                                      itemCount:controllerX.verifyDataModel?.verifiy?.length??0,
                                        itemBuilder:
                                        (BuildContext context, int index){
                                        return InkWell(
                                          onTap: (){
                                            controllerX.selectedIndex =index;
                                            controllerX.update(['grid']);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Checkbox(
                                                  value: controllerX.verifyDataModel?.
                                                  verifiy?[index].isChecked,
                                                  onChanged: (val){
                                                    controllerX.verifyDataModel?.
                                                    verifiy?[index].isChecked = val;
                                                    controllerX.update(['grid']);
                                                  }),
                                              Expanded(
                                                child: Container(
                                                    color: (controllerX
                                                        .selectedIndex ==
                                                        index)
                                                        ? Colors.deepPurpleAccent
                                                        : Colors.white,
                                                    child: Text(
                                                      controllerX
                                                          .verifyDataModel
                                                          ?.verifiy?[index]
                                                          .bookingnumber ??
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

                                    }),
                                  ): Container();
                                }
                            ),

                          ),
                        ),


                        Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.correctExecutiveNameList.value??[],
                              (value) {
                            controllerX.selectedCorrectExecutiveName?.value = value;
                          }, "Correct Executive Name",
                          0.46,
                          isEnable: controllerX.isEnable,
                          inkWellFocusNode: controllerX.executiveNamNode,
                          selected: controllerX.selectedCorrectExecutiveName?.value,
                          dialogHeight: Get.height * .7,
                          autoFocus: false,),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                /// bottom common buttons
                SizedBox(
                  height: 40,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var btn in ["Update Executive", "Clear", "Exit"]) ...{
                        FormButtonWrapper(
                          btnText: btn,
                          callback: () => controller.formHandler(btn),
                        )
                      },
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
