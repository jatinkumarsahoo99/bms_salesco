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
import '../../../providers/Utils.dart';
import '../controllers/e_d_i_mapping_controller.dart';

class EDIMappingView extends GetView<EDIMappingController> {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => RadioRow(
                                    items: [
                                      "Client",
                                      "Agency",
                                      "Channel"
                                    ],
                                    groupValue:
                                    controllerX.selectValue.value ?? "",
                                    onchange: (String v) {
                                      print(">>>>"+v);
                                      controllerX.selectValue.value=v;
                                      controllerX.checkRadio(v);
                                      // controllerX.selectValue.refresh();
                                      // controllerX.update(['top']);
                                    },
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (controllerX.isClient)? DropDownField
                                        .formDropDownSearchAPI2(
                                      GlobalKey(),
                                      context,
                                      width: context.width *  0.36,
                                      onchanged: (DropDownValue? val) {
                                        print(">>>" + val.toString());
                                        controllerX.selectedClient = val;
                                        // controllerX.getProductDetails(val?.key??"");
                                        // controllerX.fetchClientDetails((val?.value ??"")??"");
                                      },
                                      title: 'Client',
                                      url:ApiFactory.EDI_MAPPING_CLIENT_SEARCH,
                                      parseKeyForKey: "ClientCode",
                                      parseKeyForValue: 'ClientName',
                                      selectedValue: controllerX.selectedClient,
                                      autoFocus: true,
                                      // maxLength: 1
                                    ):(controllerX.isAgency)?DropDownField
                                        .formDropDownSearchAPI2(
                                      GlobalKey(),
                                      context,
                                      width: context.width *  0.36,
                                      onchanged: (DropDownValue? val) {
                                        print(">>>" + val.toString());
                                        controllerX.selectedAgency = val;
                                        // controllerX.getProductDetails(val?.key??"");
                                        // controllerX.fetchClientDetails((val?.value ??"")??"");
                                      },
                                      title: 'Agency',
                                      url:ApiFactory.EDI_MAPPING_AGENT_SEARCH,
                                      parseKeyForKey: "AgencyCode",
                                      parseKeyForValue: 'AgencyName',
                                      selectedValue: controllerX.selectedAgency,
                                      autoFocus: true,
                                      // maxLength: 1
                                    ):(controllerX.isChannel)?DropDownField
                                        .formDropDownSearchAPI2(
                                      GlobalKey(),
                                      context,
                                      width: context.width *  0.36,
                                      onchanged: (DropDownValue? val) {
                                        print(">>>" + val.toString());
                                        controllerX.selectedChannel = val;
                                        // controllerX.getProductDetails(val?.key??"");
                                        // controllerX.fetchClientDetails((val?.value ??"")??"");
                                      },
                                      title: 'Channel',
                                      url:ApiFactory.EDI_MAPPING_CHANNEL_SEARCH,
                                      parseKeyForKey: "ChannelCode",
                                      parseKeyForValue: 'ChannelName',
                                      selectedValue: controllerX.selectedChannel,
                                      autoFocus: true,
                                      // maxLength: 1
                                    ):DropDownField
                                        .formDropDownSearchAPI2(
                                      GlobalKey(),
                                      context,
                                      width: context.width *  0.36,
                                      onchanged: (DropDownValue? val) {

                                      },
                                      title: '',
                                      url:"",
                                      parseKeyForKey: "productcode",
                                      parseKeyForValue: 'Productname',
                                      // selectedValue: controllerX.selectedProduct,
                                      autoFocus: true,
                                      // maxLength: 1
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)),
                                        child:  GetBuilder<EDIMappingController>(
                                            id: "grid",
                                            builder: (controllerX) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)),
                                              );
                                            }
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
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
