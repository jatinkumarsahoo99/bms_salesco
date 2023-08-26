import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../providers/SizeDefine.dart';
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
          width: size.width * .65,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Update Executive'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 0,top: 3,right: 8),
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
                          width: size.width*0.46,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Obx(()=>Checkbox(
                                     value: controllerX.selectAll.value,
                                     visualDensity:VisualDensity(horizontal: -4) ,
                                    onChanged: (val){
                                      controllerX.selectAll.value = val!;
                                      controllerX.selectAllList();

                                    })),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  child: Text("Select All", style: TextStyle(
                                    fontSize: SizeDefine.labelSize1,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,left: 8,top: 2,bottom: 0),
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
                SizedBox(height: 8),
                /// bottom common buttons
                SizedBox(
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
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
