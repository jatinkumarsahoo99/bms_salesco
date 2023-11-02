import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/SizeDefine.dart';
import '../../../providers/Utils.dart';
import '../controllers/e_d_i_mapping_controller.dart';

class EDIMappingView extends StatelessWidget {
  EDIMappingView({Key? key}) : super(key: key);

  EDIMappingController controllerX =
      Get.put<EDIMappingController>(EDIMappingController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.74,
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: Text('EDI Client Agency Channel Mapping'),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: GetBuilder<EDIMappingController>(
                      id: "top",
                      builder: (controllerX) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: RadioRow(
                                      items: ["Client", "Agency", "Channel"],
                                      groupValue:
                                          controllerX.selectValue.value ?? "",
                                      onchange: (String v) {
                                        print(">>>>" + v);
                                        controllerX.selectValue.value = v;
                                        controllerX.checkRadio(v);
                                        // controllerX.selectValue.refresh();
                                        // controllerX.update(['top']);
                                      },
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 2),
                                child: (controllerX.isClient)
                                    ? DropDownField.formDropDownSearchAPI2(
                                        GlobalKey(),
                                        context,
                                        width: context.width * 0.36,
                                        onchanged: (DropDownValue? val) {
                                          print(">>>" + val.toString());
                                          controllerX.selectedClient = val;
                                          // controllerX.callPopulateEntity();
                                          // controllerX.getProductDetails(val?.key??"");
                                          // controllerX.fetchClientDetails((val?.value ??"")??"");
                                        },
                                        title: 'Client',
                                        url: ApiFactory
                                            .EDI_MAPPING_CLIENT_SEARCH,
                                        parseKeyForKey: "ClientCode",
                                        parseKeyForValue: 'ClientName',
                                        selectedValue:
                                            controllerX.selectedClient,
                                        autoFocus: true,
                                        // maxLength: 1
                                      )
                                    : (controllerX.isAgency)
                                        ? DropDownField.formDropDownSearchAPI2(
                                            GlobalKey(),
                                            context,
                                            width: context.width * 0.36,
                                            onchanged: (DropDownValue? val) {
                                              print(">>>" + val.toString());
                                              controllerX.selectedAgency = val;
                                              // controllerX.callPopulateEntity();
                                              // controllerX.getProductDetails(val?.key??"");
                                              // controllerX.fetchClientDetails((val?.value ??"")??"");
                                            },
                                            title: 'Agency',
                                            url: ApiFactory
                                                .EDI_MAPPING_AGENT_SEARCH,
                                            parseKeyForKey: "AgencyCode",
                                            parseKeyForValue: 'AgencyName',
                                            selectedValue:
                                                controllerX.selectedAgency,
                                            autoFocus: true,
                                            // maxLength: 1
                                          )
                                        : (controllerX.isChannel)
                                            ? DropDownField
                                                .formDropDownSearchAPI2(
                                                GlobalKey(),
                                                context,
                                                width: context.width * 0.36,
                                                onchanged:
                                                    (DropDownValue? val) {
                                                  print(">>>" + val.toString());
                                                  controllerX.selectedChannel =
                                                      val;
                                                  // controllerX.callPopulateEntity();
                                                  // controllerX.getProductDetails(val?.key??"");
                                                  // controllerX.fetchClientDetails((val?.value ??"")??"");
                                                },
                                                title: 'Channel',
                                                url: ApiFactory
                                                    .EDI_MAPPING_CHANNEL_SEARCH,
                                                parseKeyForKey: "ChannelCode",
                                                parseKeyForValue: 'ChannelName',
                                                selectedValue:
                                                    controllerX.selectedChannel,
                                                autoFocus: true,
                                                // maxLength: 1
                                              )
                                            : DropDownField
                                                .formDropDownSearchAPI2(
                                                GlobalKey(),
                                                context,
                                                width: context.width * 0.36,
                                                onchanged:
                                                    (DropDownValue? val) {},
                                                title: '',
                                                url: "",
                                                parseKeyForKey: "productcode",
                                                parseKeyForValue: 'Productname',
                                                // selectedValue: controllerX.selectedProduct,
                                                autoFocus: true,
                                                // maxLength: 1
                                              ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: (controllerX.isClient)
                                      ? InputFields.formField1(
                                          hintTxt: "Search Client",
                                          controller: TextEditingController(),
                                          onchanged: (value) {
                                            controllerX.clientTempList.clear();
                                            if (value.isNotEmpty) {
                                              for (var i = 0;
                                                  i <
                                                      controllerX
                                                          .populateEntityModel!
                                                          .populateEntity!
                                                          .clientMaster!
                                                          .length;
                                                  i++) {
                                                if (controllerX
                                                    .populateEntityModel!
                                                    .populateEntity!
                                                    .clientMaster![i]
                                                    .softClient
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase())) {
                                                  controllerX.isClientTemp
                                                      .value = true;
                                                  controllerX.clientTempList
                                                      .add(controllerX
                                                          .populateEntityModel!
                                                          .populateEntity!
                                                          .clientMaster![i]
                                                          .softClient);
                                                }
                                              }
                                            } else {
                                              controllerX.isClientTemp.value =
                                                  false;
                                              controllerX.clientTempList.addAll(
                                                  controllerX
                                                      .populateEntityModel!
                                                      .populateEntity!
                                                      .clientMaster!);
                                            }
                                          },
                                          width: 0.36,
                                        )
                                      : (controllerX.isAgency)
                                          ? InputFields.formField1(
                                              hintTxt: "Search Agency",
                                              controller:
                                                  TextEditingController(),
                                              onchanged: (value) {
                                                controllerX.agencyTempList
                                                    .clear();
                                                if (value.isNotEmpty) {
                                                  for (var i = 0;
                                                      i <
                                                          controllerX
                                                              .populateEntityModel!
                                                              .populateEntity!
                                                              .agencyMaster!
                                                              .length;
                                                      i++) {
                                                    if (controllerX
                                                        .populateEntityModel!
                                                        .populateEntity!
                                                        .agencyMaster![i]
                                                        .softAgency
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase())) {
                                                      controllerX.isAgencyTemp
                                                          .value = true;
                                                      controllerX.agencyTempList
                                                          .add(controllerX
                                                              .populateEntityModel!
                                                              .populateEntity!
                                                              .agencyMaster![i]
                                                              .softAgency);
                                                    }
                                                  }
                                                } else {
                                                  controllerX.isAgencyTemp
                                                      .value = false;
                                                  controllerX.agencyTempList
                                                      .addAll(controllerX
                                                          .populateEntityModel!
                                                          .populateEntity!
                                                          .agencyMaster!);
                                                }
                                              },
                                              width: 0.36,
                                            )
                                          : (controllerX.isChannel)
                                              ? InputFields.formField1(
                                                  hintTxt: "Search Channel",
                                                  controller:
                                                      TextEditingController(),
                                                  onFieldSubmitted: (value) {
                                                    // tempList.clear();
                                                    // if (value.isNotEmpty) {
                                                    //   for (var i = 0; i < brandTabelList.length; i++) {
                                                    //     if (value == brandTabelList[i]['exportTapeCode']) {
                                                    //       tempList.add(brandTabelList[i]);
                                                    //     }
                                                    //   }
                                                    // } else {
                                                    //   tempList.addAll(brandTabelList.value);
                                                    // }
                                                  },
                                                  width: 0.36,
                                                )
                                              : InputFields.formField1(
                                                  hintTxt: "",
                                                  controller:
                                                      TextEditingController(),
                                                  onFieldSubmitted: (value) {},
                                                  width: 0.36,
                                                )),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: GetBuilder<EDIMappingController>(
                                        id: "grid",
                                        builder: (controllerX) {
                                          switch (controllerX.radioName) {
                                            case "Client":
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: (controllerX.populateEntityModel != null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity !=
                                                              null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity
                                                                  ?.clientMaster !=
                                                              null &&
                                                          (controllerX.clientTempList
                                                                      .length ??
                                                                  0) >
                                                              0)
                                                      ? Focus(
                                                          skipTraversal: true,
                                                          descendantsAreFocusable:
                                                              false,
                                                          descendantsAreTraversable:
                                                              false,
                                                          child: Obx(
                                                            () => ListView
                                                                .builder(
                                                                    itemCount: controllerX
                                                                        .clientTempList
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(3.0),
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                              controllerX.selectedIndex = index;
                                                                              controllerX.update([
                                                                                'grid'
                                                                              ]);
                                                                            },
                                                                            child: Container(
                                                                                color: (controllerX.selectedIndex == index) ? Colors.deepPurpleAccent : Colors.white,
                                                                                child: Text(
                                                                                  controllerX.isClientTemp.value ? controllerX.clientTempList[index] ?? "" : controllerX.clientTempList[index].softClient ?? "",
                                                                                  style: TextStyle(
                                                                                    fontSize: SizeDefine.labelSize1,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: (controllerX.selectedIndex != index) ? Colors.black : Colors.white,
                                                                                  ),
                                                                                ))),
                                                                      );
                                                                    }),
                                                          ),
                                                        )
                                                      : Container());
                                              break;
                                            case "Agency":
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: (controllerX.populateEntityModel != null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity !=
                                                              null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity
                                                                  ?.agencyMaster !=
                                                              null &&
                                                          (controllerX.agencyTempList
                                                                      .length ??
                                                                  0) >
                                                              0)
                                                      ? Focus(
                                                          skipTraversal: true,
                                                          descendantsAreFocusable:
                                                              false,
                                                          descendantsAreTraversable:
                                                              false,
                                                          child: Obx(
                                                            () => ListView
                                                                .builder(
                                                                    itemCount: controllerX
                                                                        .agencyTempList
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(3.0),
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                              controllerX.selectedIndex = index;
                                                                              controllerX.update([
                                                                                'grid'
                                                                              ]);
                                                                            },
                                                                            child: Container(
                                                                                color: (controllerX.selectedIndex == index) ? Colors.deepPurpleAccent : Colors.white,
                                                                                child: Text(
                                                                                  controllerX.isAgencyTemp.value ? controllerX.agencyTempList[index] ?? "" : controllerX.agencyTempList[index].softAgency ?? "",
                                                                                  style: TextStyle(
                                                                                    color: (controllerX.selectedIndex == index) ? Colors.white : Colors.black,
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ))),
                                                                      );
                                                                    }),
                                                          ),
                                                        )
                                                      : Container());
                                              break;
                                            case "Channel":
                                              return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: (controllerX.populateEntityModel != null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity !=
                                                              null &&
                                                          controllerX
                                                                  .populateEntityModel
                                                                  ?.populateEntity
                                                                  ?.channelMaster !=
                                                              null &&
                                                          (controllerX
                                                                      .populateEntityModel
                                                                      ?.populateEntity
                                                                      ?.channelMaster
                                                                      ?.length ??
                                                                  0) >
                                                              0)
                                                      ? Focus(
                                                          skipTraversal: true,
                                                          descendantsAreFocusable:
                                                              false,
                                                          descendantsAreTraversable:
                                                              false,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: controllerX
                                                                      .populateEntityModel
                                                                      ?.populateEntity
                                                                      ?.channelMaster
                                                                      ?.length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3.0),
                                                                      child: GestureDetector(
                                                                          onTap: () {
                                                                            controllerX.selectedIndex =
                                                                                index;
                                                                            controllerX.update([
                                                                              'grid'
                                                                            ]);
                                                                          },
                                                                          child: Container(
                                                                              color: (controllerX.selectedIndex == index) ? Colors.deepPurpleAccent : Colors.white,
                                                                              child: Text(
                                                                                controllerX.populateEntityModel?.populateEntity?.channelMaster?[index].SoftChannel ?? "",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12),
                                                                              ))),
                                                                    );
                                                                  }),
                                                        )
                                                      : Container());
                                              break;
                                            default:
                                              return Container();
                                          }

                                          /* return Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey)),
                                                child:(controllerX.populateEntityModel != null &&
                                                    controllerX.populateEntityModel?.populateEntity != null
                                                )? (controllerX.isClient)?( controllerX.populateEntityModel?.populateEntity?.clientMaster != null &&
                                                    (controllerX.populateEntityModel?.populateEntity?.clientMaster?.length??0) >0)?
                                                ListView.builder(
                                                    itemCount:controllerX.populateEntityModel?.
                                                    populateEntity?.clientMaster?.length ,
                                                    itemBuilder: (BuildContext context,int index){
                                                      return Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: InkWell(
                                                            onTap: (){
                                                              controllerX.selectedIndex = index;
                                                              controllerX.update(['grid']);
                                                            },
                                                            child: Expanded(
                                                              child: Container(
                                                                  color:(controllerX.selectedIndex == index)? Colors.deepPurpleAccent:Colors.white,
                                                                  child: Text(controllerX.populateEntityModel?.populateEntity?.clientMaster?[index].softClient??"",
                                                                    style: TextStyle(color: Colors.black,fontSize: 12),)),
                                                            )),
                                                      );

                                                    }):Container():
                                                (controllerX.isAgency)?
                                                ( controllerX.populateEntityModel?.populateEntity?.agencyMaster != null &&
                                                    (controllerX.populateEntityModel?.populateEntity?.agencyMaster?.length??0) >0)?
                                                ListView.builder(
                                                    itemCount:controllerX.populateEntityModel?.
                                                    populateEntity?.agencyMaster?.length ,
                                                    itemBuilder: (BuildContext context,int index){
                                                      return Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: InkWell(
                                                            onTap: (){
                                                              controllerX.selectedIndex = index;
                                                              controllerX.update(['grid']);
                                                            },
                                                            child: Expanded(
                                                              child: Container(
                                                                  color:(controllerX.selectedIndex == index)? Colors.deepPurpleAccent:Colors.white,
                                                                  child: Text(controllerX.populateEntityModel?.populateEntity?.agencyMaster?[index].softAgency??"",
                                                                    style: TextStyle(color: Colors.black,fontSize: 12),)),
                                                            )),
                                                      );

                                                    }):Container():Container():Container(),
                                              );*/
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),

                /// bottom common buttons
                Align(
                  alignment: Alignment.topLeft,
                  child: GetBuilder<HomeController>(
                      id: "buttons",
                      init: Get.find<HomeController>(),
                      builder: (controller) {
                        PermissionModel formPermissions =
                            Get.find<MainController>()
                                .permissionList!
                                .lastWhere((element) =>
                                    element.appFormName ==
                                    "frmEDIClientAgencyChannelMapping");
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
    );
  }
}
