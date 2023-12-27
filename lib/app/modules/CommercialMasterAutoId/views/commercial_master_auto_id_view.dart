import 'dart:convert';

import 'package:bms_salesco/app/providers/Utils.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/PlutoGrid/src/pluto_grid.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Aes.dart';
import '../../../routes/app_pages.dart';
import '../controllers/commercial_master_auto_id_controller.dart';

class CommercialMasterAutoIdView
    extends GetView<CommercialMasterAutoIdController> {
   CommercialMasterAutoIdView({Key? key}) : super(key: key);

   CommercialMasterAutoIdController controllerX =
   Get.put<CommercialMasterAutoIdController>(
       CommercialMasterAutoIdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => DropDownField.formDropDown1WidthMap(
                    controllerX.loadModel?.value?.loadData?.lstProviders ??
                        [],
                        (data) {
                      controllerX.getProviederSelect(data.value ?? "");
                    },
                    "Providers",
                    0.3,
                    searchReq: true,
                  )),
                  /*  FormButton1(
                    btnText: "User setting test post",
                    callback: () {
                      controllerX.postUserSetting();
                    },
                  ),
                  FormButton1(
                    btnText: "User setting test get",
                    callback: () {},
                  ),*/
                ],
              ),
            ),
            Divider(),
            GetBuilder<CommercialMasterAutoIdController>(
                id: "listUpdate",
                init: controllerX,
                // init: CreateBreakPatternController(),
                builder: (controller) {
                  print("Called this Update >>>listUpdate");
                  if (controller.loadModel?.value?.loadData?.lstNewMedia !=
                      null &&
                      ((controller.loadModel?.value?.loadData?.lstNewMedia
                          ?.length ??
                          0) >
                          0)) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DataGridFromMap(
                          mapData: (controller
                              .loadModel?.value?.loadData?.lstNewMedia
                              ?.map((e) => e.toJson())
                              .toList())!,
                          widthRatio: (Get.width / 9) + 5,
                          showSrNo: true,
                          onload: (PlutoGridOnLoadedEvent grid) {
                            controllerX.stateManager = grid.stateManager;
                          },
                          // widthSpecificColumn: controllerX.userGridSetting1?[0]??{},
                          widthSpecificColumn: Get.find<HomeController>().getGridWidthByKey(
                              userGridSettingList: controllerX.userGridSetting1),
                          hideKeys: ["acid"],
                          mode: PlutoGridMode.select,
                          colorCallback: (row) => (row.row.cells
                              .containsValue(controllerX
                              .stateManager?.currentCell))
                              ? Colors.deepPurple.shade200
                              : Colors.white,
                          // actionIcon: Icons.delete_forever_rounded,
                          onSelected: (PlutoGridOnSelectedEvent pluto) {

                            Get.toNamed(Routes.COMMERCIAL_MASTER_AUTO_ID_DETAILS,
                                parameters: {
                                  "acId": Aes.encrypt(
                                      (pluto.row?.cells["acid"]?.value ??
                                          "").toString()) ??
                                      "",
                                  "exportTapeCode": Aes.encrypt((pluto.row?.cells["exportTapeCode"]?.value ??"").toString())??""
                                });
                          },
                          // mode: controllerX.gridcanFocus,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(0), // if you need this
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Container(
                          height: Get.height - (4 * kToolbarHeight),
                        ),
                      ),
                    );
                  }
                }),
            // Divider(),

            GetBuilder<HomeController>(
                id: "buttons",
                init: Get.find<HomeController>(),
                builder: (controller) {
                  print("Data is???" +
                      Routes.COMMERCIAL_MASTER_AUTO_ID.replaceAll("/", ""));
                  int? index = Get.find<MainController>()
                      .permissionList!
                      .indexWhere((element) {
                    return element.appFormName ==
                        Routes.COMMERCIAL_MASTER_AUTO_ID.replaceAll("/", "");
                  });
                  if (index == null || index == -1) {
                    return Container();
                  }
                  PermissionModel? formPermissions =
                  Get.find<MainController>().permissionList![index];
                  print("k>>>" + jsonEncode(formPermissions.toJson()));
                  if (controller.buttons != null) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var btn in controller.buttons!)
                          FormButtonWrapper(
                            btnText: btn["name"],
                            // isEnabled: btn['isDisabled'],
                            callback: Utils.btnAccessHandler2(btn['name'],
                                controller, formPermissions) ==
                                null
                                ? null
                                : () => formHandler(btn['name']),
                          )
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
      // controllerX.save();
        break;
      case "Clear":
        Get.find<HomeController>().clearPage1();
        Get.delete<CommercialMasterAutoIdController>();
        break;
      case "Exit":
        print("Exit called");
        // controllerX.postUserSetting();
        Get.find<HomeController>().postUserGridSetting1(
            listStateManager: [
              controllerX.stateManager
            ]);
        break;
    }
  }
}
