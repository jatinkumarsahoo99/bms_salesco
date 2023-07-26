import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingScreen.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/CommercialLanguageSpecificationController.dart';

class CommercialLanguageSpecificationView
    extends GetView<CommercialLanguageSpecificationController> {

  CommercialLanguageSpecificationController controllerX=Get.put<CommercialLanguageSpecificationController>(CommercialLanguageSpecificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<CommercialLanguageSpecificationController>(
              init: controllerX,
              id: "updateView",
              builder: (control) {
                if (controllerX.locationList == null) {
                  return SizedBox(
                      width: Get.width,
                      height: Get.height * 0.2,
                      child: LoadingScreen());
                }
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 5,
                    spacing: 5,
                    children: [
                      Obx(() => DropDownField.formDropDown1WidthMap(
                        controllerX.locationList.value,
                            (data) {
                          // controllerX.selectLocation = data;
                          // controllerX.getChannel(data.key);
                        },
                        "Location",
                        controllerX.widthSize,
                        // isEnable: controllerX.isEnable.value,
                        searchReq: true,
                        // selected: controllerX.selectLocation,
                      )),

                      Obx(() => DropDownField.formDropDown1WidthMap(
                        controllerX.channelList.value,
                            (data) {
                          // controllerX.selectChannel = data;
                          // controllerX.getChannelLeave();
                        },
                        "Channel",
                        controllerX.widthSize,
                        // isEnable: controllerX.isEnable.value,
                        searchReq: true,
                        // selected: controllerX.selectChannel,
                      )),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: FormButton(
                          btnText: "Display",
                          callback: () {
                            // controllerX.btnRemove_Click();
                            // controllerX.addTable();
                          },
                          showIcon: false,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Divider(),
            /* GetBuilder<SegmentController>(
                init: controllerX,
                id: "segmentDefaultLoad",
                builder: (controller) {
                  return Expanded(
                      child: */ /*(controller.actualDefaults != null &&
                              (controller.actualDefaults?.isNotEmpty)! &&
                              controller.tableSegment != null)
                          ? */ /*
                          _dataTable2() */ /*: Container()*/ /*);
                }),*/
            GetBuilder<CommercialLanguageSpecificationController>(
                id: "listUpdate",
                init: controllerX,
                // init: CreateBreakPatternController(),
                builder: (controller) {
                  print("Called this Update >>>listUpdate");
                  if (controller.tableList != null &&
                      ((controller.tableList.length ?? 0) > 0)) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DataGridFromMap(
                          mapData: (controller.tableList
                              ?.map((e) => e.toJson())
                              .toList())!,
                          widthRatio: (Get.width / 9) + 5,
                          showSrNo: true,
                          onload: (PlutoGridOnLoadedEvent grid) {
                            // controllerX.stateManager = grid.stateManager;
                          },
                          mode: PlutoGridMode.selectWithOneTap,
                          // actionIcon: Icons.delete_forever_rounded,
                          onSelected: (PlutoGridOnSelectedEvent pluto) {
                            // controllerX.onDoubleClick(pluto);
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
                  PermissionModel formPermissions = Get.find<MainController>()
                      .permissionList!
                      .lastWhere((element) {
                    return element.appFormName == "frmDSeriesSpecs";
                  });
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
    switch(btn){
      case "Save":
        // controllerX.save();
        break;
      case "Clear":
        Get.find<HomeController>().clearPage1();
        Get.delete<CommercialLanguageSpecificationController>();
        break;
    }
  }
}
