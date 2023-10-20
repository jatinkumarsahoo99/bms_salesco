import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/floating_dialog.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/DataGridMenu.dart';
import '../../../providers/Utils.dart';
import '../controllers/amagi_spots_replacement_controller.dart';

class AmagiSpotsReplacementView
    extends GetView<AmagiSpotsReplacementController> {
  AmagiSpotsReplacementView({Key? key}) : super(key: key);

  @override
  AmagiSpotsReplacementController controller =
  Get.put<AmagiSpotsReplacementController>(
      AmagiSpotsReplacementController());

  var rebuildKey = GlobalKey<ScaffoldState>();

  dragableDialogClient() {
    controller.initialOffset.value = 2;
    // Completer<bool> completer = Completer<bool>();
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.8,
          height: Get.height * 0.8,
          child: Column(
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                          controller.title?.value ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // flex: 9,
                child: Obx(() {
                  return Container(
                      child: DataGridFromMapAmagiDialog(
                        showSrNo: false,
                        hideCode: false,
                        formatDate: false,
                        summary: controller.isSummary.value,
                        exportFileName: "Amagi Spot Replacement",
                        mode: PlutoGridMode.selectWithOneTap,
                        mapData: controller.mapList.value,
                        // mapData: (controller.dataList)!,
                        widthRatio: Get.width / 9 - 1,

                        onload: (PlutoGridOnLoadedEvent load) {
                          controller.dialogStateManager = load.stateManager;
                          // controller.stateManager = load.stateManager;
                        },
                      ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dragAbleDialogGetSummary() {
    controller.initialOffset.value = 2;
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.8,
          height: Get.height * 0.8,
          child: Column(
            children: [
              Container(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                          controller.title?.value ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // flex: 9,
                child: Obx(() {
                  return Container(
                      child: DataGridFromMapAmagiDialog(
                        showSrNo: false,
                        hideCode: false,
                        formatDate: false,
                        exportFileName: "Amagi Spot Replacement",
                        mode: PlutoGridMode.selectWithOneTap,
                        mapData: controller.mapList.value,
                        summary: controller.isSummary.value,
                        // mapData: (controller.dataList)!,
                        widthRatio: Get.width / 9 - 1,

                        onload: (PlutoGridOnLoadedEvent load) {
                          controller.dialogStateManager = load.stateManager;
                          // controller.stateManager = load.stateManager;
                        },
                      ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dragAbleDialogGetTotal() {
    controller.initialOffset.value = 2;
    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.9,
          height: Get.height * 0.8,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                          controller.title?.value ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // flex: 9,
                child: Obx(() {
                  return Container(
                      child: DataGridFromMapAmagiDialog(
                        showSrNo: false,
                        hideCode: false,
                        formatDate: false,
                        summary: controller.isSummary.value,
                        exportFileName: "Amagi Spot Replacement",
                        mode: PlutoGridMode.selectWithOneTap,
                        mapData: controller.mapList.value,
                        // mapData: (controller.dataList)!,
                        widthRatio: Get.width / 9 - 1,

                        onload: (PlutoGridOnLoadedEvent load) {
                          controller.dialogStateManager = load.stateManager;
                          // controller.stateManager = load.stateManager;
                        },
                      ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  dragAbleDialogGet() {
    controller.initialOffset.value = 2;
    TextEditingController txCaptionController = TextEditingController();
    TextEditingController txIdController = TextEditingController(text:
    controller.amagiSpotReplacementModel?.lstSpots?.fastInsertText ?? "");
    DropDownValue? selectEventType = DropDownValue(
        value: "Promo", key: "Promo");
    List<DropDownValue> selectEventTypeList = [DropDownValue(value: "Promo", key: "Promo")];
    Rx<bool> mySta = Rx<bool>(false);

    controller.dialogWidget = Material(
      color: Colors.white,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: Get.width * 0.5,
          height: Get.height * 0.8,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                // color: Colors.grey[200],
                child: Stack(
                  fit: StackFit.expand,
                  // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                          controller.title?.value ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          controller.dialogWidget = null;
                          controller.canDialogShow.value = false;
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width*0.22,
                    height: Get.height*0.07,
                    child: DropDownField.formDropDown1WidthMap(
                      selectEventTypeList,
                          (value) {
                        // selectedObjective = value;
                        selectEventType = value;
                      },
                      "Objective",
                      .2,
                      // isEnable: isEnable,
                      selected: selectEventType,
                      dialogHeight: Get.height * .7,
                      onFocusChange: (val){},
                      height: Get.height * 0.067,widgetKey: GlobalKey(),
                      // inkWellFocusNode: objectiveNode,
                      autoFocus: true,
                    ),
                  ),
                  InputFields.formField1(
                    hintTxt: "Tx Caption",
                    controller: txCaptionController,
                    width: 0.2,maxLen: 40,

                    // autoFocus: true,
                    // focusNode: controllerX.brandName,
                    // isEnable: controllerX.isEnable,
                    onchanged: (value) {},
                    autoFocus: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),

              Row(
                children: [
                  InputFields.formField1(
                    hintTxt: "Tx Id",
                    controller: txIdController,
                    width: 0.5,
                    // maxLines: ,
                    // autoFocus: true,
                    // focusNode: controllerX.brandName,
                    // isEnable: controllerX.isEnable,
                    onchanged: (value) {},
                    maxLen: 500,
                    autoFocus: false,
                  ),
                ],
              ),

              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Obx(() {
                    return Checkbox(value: mySta.value,
                        onChanged: (val) {
                          mySta.value = val!;
                          mySta.refresh();
                        });
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("My"),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 0.0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Search",
                      callback: () {
                        controller.callFastInsert(
                          caption: txCaptionController.text,
                          eventType: selectEventType?.key,mine: mySta.value,txID:txIdController.text,myProperty: "" ).
                        then((value) {
                          controller.mapList.value = value;
                          print(">>>>>>>>>>>"+controller.mapList.value.toString());
                          controller.mapList.refresh();
                        });
                        // controller.fetchGetGenerate();
                      },
                      showIcon: true,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: FormButtonWrapper(
                      btnText: "Add",
                      callback: () {
                        // controller.fetchGetGenerate();
                      },
                      showIcon: true,
                    ),
                  ),
                ],
              ),
              Expanded(child: Obx(() {
                return Container(
                  child: DataGridFromMapAmagiDialog(
                    showSrNo: false,
                    hideCode: false,
                    formatDate: false,
                    summary: controller.isSummary.value,
                    exportFileName: "Amagi Spot Replacement",
                    mode: PlutoGridMode.selectWithOneTap,
                    mapData: controller.mapList.value,
                    // mapData: (controller.dataList)!,
                    widthRatio: Get.width / 9 - 1,
                    onload: (PlutoGridOnLoadedEvent load) {
                      controller.dialogStateManager = load.stateManager;
                      // controller.stateManager = load.stateManager;
                    },
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
    controller.canDialogShow.value = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return GetBuilder<AmagiSpotsReplacementController>(
      assignId: true,
      id: "all",
      builder: (controller) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              key: rebuildKey,
              floatingActionButton: Obx(() {
                return controller.canDialogShow.value
                    ? DraggableFab(
                  initPosition: controller.getOffSetValue(constraints),
                  child: controller.dialogWidget!,
                )
                    : const SizedBox();
              }),
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
                            Obx(
                                  () =>
                                  DropDownField.formDropDown1WidthMap(
                                    controller.locationList.value ?? [],
                                        (value) {
                                      controller.selectedLocation = value;
                                    },
                                    "Location",
                                    .13,
                                    isEnable: controller.isEnable,
                                    selected: controller.selectedLocation,
                                    dialogHeight: Get.height * .7,
                                    inkWellFocusNode: controller.locationNode,
                                    autoFocus: true,
                                  ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Obx(
                                  () =>
                                  DropDownField.formDropDown1WidthMap(
                                    controller.channelList.value ?? [],
                                        (value) {
                                      controller.selectedChannel = value;
                                    },
                                    "Channel",
                                    .13,
                                    isEnable: controller.isEnable,
                                    selected: controller.selectedChannel,
                                    dialogHeight: Get.height * .7,
                                    inkWellFocusNode: controller.channelNode,
                                    autoFocus: true,
                                  ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            DateWithThreeTextField(
                              title: "Schedule Date",
                              mainTextController: controller.frmDate,
                              widthRation: .1,
                              isEnable: controller.isEnable,
                              onFocusChange: (String date) {
                                // controller.getSpotDialog();

                                controller.getSpots().then((value) {
                                  if ((controller
                                      .amagiSpotReplacementModel
                                      ?.lstSpots
                                      ?.fastInserts
                                      ?.promoResponse
                                      ?.length ??
                                      0) >
                                      0) {
                                    if (controller.canDialogShow.value ==
                                        true) {
                                      controller.title?.value = "";
                                      controller.mapList.value = value;
                                      controller.mapList.refresh();
                                      // dragableDialog(mapList: value);
                                      controller.title?.refresh();
                                      // controller.bindData();
                                    } else {
                                      controller.title?.value = "";
                                      // print(">>>>>>>>>valueMapData" + value.toString());
                                      controller.mapList.value = value;
                                      dragAbleDialogGet();
                                    }
                                  }
                                  Future.delayed(Duration(seconds: 2), () {
                                    controller.bindData();
                                  },);
                                });
                              },
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Obx(
                                  () =>
                                  DropDownField.formDropDown1WidthMap(
                                    controller.objectiveList.value ?? [],
                                        (value) {
                                      controller.selectedObjective = value;
                                    },
                                    "Objective",
                                    .13,
                                    isEnable: controller.isEnable,
                                    selected: controller.selectedObjective,
                                    dialogHeight: Get.height * .7,
                                    inkWellFocusNode: controller.objectiveNode,
                                    autoFocus: true,
                                  ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Obx(() {
                                    return Checkbox(
                                        value: controller.allowMergeSta.value,
                                        onChanged: (val) {
                                          controller.allowMergeSta.value =
                                              val ?? false;
                                          controller.allowMergeSta.refresh();
                                        });
                                  }),
                                  Text("Allow Merge")
                                ],
                              ),
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
                                      controller.getSpots(reProcess: true)
                                          .then((value) {
                                        if ((controller
                                            .amagiSpotReplacementModel
                                            ?.lstSpots
                                            ?.fastInserts
                                            ?.promoResponse
                                            ?.length ??
                                            0) >
                                            0) {
                                          if (controller.canDialogShow.value ==
                                              true) {
                                            controller.title?.value = "";
                                            controller.mapList.value = value;
                                            controller.mapList.refresh();
                                            controller.isSummary.value = false;
                                            controller.isSummary.refresh();
                                            // dragableDialog(mapList: value);
                                            controller.title?.refresh();
                                            // controller.bindData();
                                          } else {
                                            controller.title?.value = "";
                                            controller.isSummary.value = false;
                                            // print(">>>>>>>>>valueMapData" + value.toString());
                                            controller.mapList.value = value;
                                            // dragAbleDialogGet();

                                          }
                                        }
                                        Future.delayed(
                                          Duration(seconds: 2), () {
                                          controller.bindData();
                                        },);
                                      });
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
                                      controller
                                          .dialogWidget =
                                      null;
                                      controller
                                          .canDialogShow
                                          .value = false;
                                      controller.isSummary.value = true;
                                      controller.update(['id']);

                                      Future.delayed(
                                        const Duration(seconds: 1), () {
                                        controller.title?.value = "";
                                        controller.isSummary.value = false;
                                        // print(">>>>>>>>>valueMapData" + value.toString());
                                        controller.mapList.value =
                                        controller.amagiSpotReplacementModel
                                            ?.lstSpots?.fastInserts
                                            ?.promoResponse
                                            ?.map((e) => e.toJson())
                                            .toList() as List<dynamic>;
                                        dragAbleDialogGet();
                                      },);
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
                                      controller.callExcel();
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
                            child: GetBuilder<AmagiSpotsReplacementController>(
                                id: "all",
                                builder: (controller) {
                                  return Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: GetBuilder<
                                                    AmagiSpotsReplacementController>(
                                                  assignId: true,
                                                  id: "childChannel",
                                                  builder: (controller) {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.all(3.0),
                                                      child: (controller
                                                          .amagiSpotReplacementModel !=
                                                          null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots !=
                                                              null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.childChannel !=
                                                              null &&
                                                          (controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.childChannel
                                                              ?.length ??
                                                              0) >
                                                              0)
                                                          ? DataGridFromMapForAmagiSpotReplacement(
                                                        showSrNo: false,
                                                        hideCode: false,
                                                        formatDate: false,
                                                        columnAutoResize: false,
                                                        isChannelGrid: true,
                                                        hideKeys: const [
                                                          "locationCode",
                                                          "channelCode",
                                                          "channelid",
                                                          "isParent",
                                                          "colNo"
                                                        ],
                                                        widthSpecificColumn: {
                                                          "totalSpots": 130,
                                                          "unallocatedSpots": 130,
                                                          "locationname": 130,
                                                          "channelname": 130
                                                        },
                                                        exportFileName:
                                                        "Amagi Spot Replacement",
                                                        mode: PlutoGridMode
                                                            .selectWithOneTap,
                                                        enableSort: true,
                                                        numTypeKeyList: const [
                                                          'totalSpots'
                                                        ],
                                                        mapData: controller
                                                            .amagiSpotReplacementModel
                                                            ?.lstSpots
                                                            ?.childChannel
                                                            ?.map((e) =>
                                                            e
                                                                .toJson())
                                                            .toList()
                                                        as List<dynamic>,
                                                        // mapData: (controller.dataList)!,
                                                        widthRatio:
                                                        Get.width / 9 - 1,
                                                        colorCallback: (
                                                            PlutoRowColorContext colorData) {
                                                          Color color = Colors
                                                              .white;
                                                          if (controller
                                                              .childChannelStateManager
                                                              ?.currentRowIdx ==
                                                              colorData
                                                                  .rowIdx) {
                                                            color = Color(
                                                                0xFFD1C4E9);
                                                          }
                                                          return color;
                                                        },
                                                        onSelected: (
                                                            PlutoGridOnSelectedEvent? val) {
                                                          controller
                                                              .channelSpotIndex =
                                                              val?.rowIdx ?? 0;
                                                          print(
                                                              ">>>>>>>>>>>>>childChannel + Click ");
                                                          controller.bindData();
                                                        },
                                                        onload:
                                                            (
                                                            PlutoGridOnLoadedEvent
                                                            load) {
                                                          controller
                                                              .childChannelStateManager =
                                                              load.stateManager;

                                                          controller
                                                              .childChannelStateManager
                                                              ?.sortDescending(
                                                              controller
                                                                  .childChannelStateManager
                                                                  ?.columns
                                                                  .where((
                                                                  element) =>
                                                              element.field ==
                                                                  "totalSpots")
                                                                  .first ??
                                                                  PlutoColumn(
                                                                      title: "totalSpots",
                                                                      field: "totalSpots",
                                                                      type: PlutoColumnType
                                                                          .number()));

                                                          controller
                                                              .childChannelStateManager
                                                              ?.setCurrentCell(
                                                              controller
                                                                  .childChannelStateManager
                                                                  ?.getRowByIdx(
                                                                  controller
                                                                      .childChannelStateManager
                                                                      ?.currentRowIdx ??
                                                                      0)
                                                                  ?.cells['locationname'],
                                                              controller
                                                                  .childChannelStateManager
                                                                  ?.currentRowIdx ??
                                                                  0);
                                                          // controller.stateManager = load.stateManager;

                                                          // controller.childChannelStateManager?.addListener(() { });

                                                          load.stateManager
                                                              .setSelectingMode(
                                                              PlutoGridSelectingMode
                                                                  .cell);
                                                        },
                                                      )
                                                          : Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: GetBuilder<
                                                    AmagiSpotsReplacementController>(
                                                  assignId: true,
                                                  id: "masterSpots",
                                                  builder: (logic) {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.all(3.0),
                                                      child: (controller
                                                          .amagiSpotReplacementModel !=
                                                          null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots !=
                                                              null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.masterSpots !=
                                                              null &&
                                                          (controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.masterSpots
                                                              ?.length ??
                                                              0) >
                                                              0)
                                                          ? DataGridFromMapForAmagiSpotReplacement(
                                                        showSrNo: false,
                                                        hideCode: false,
                                                        formatDate: false,
                                                        columnAutoResize: false,
                                                        isMasterGrid: true,
                                                        hideKeys: const [
                                                          "id",
                                                          'locationCode',
                                                          'channelCode'
                                                        ],
                                                        widthSpecificColumn: const {
                                                          "bookingNumber": 150,
                                                          "bookingDetailCode": 150,
                                                          "tapeCode": 150,
                                                          "tapeDuration": 150,
                                                          "rate": 150,
                                                          "spotAmount": 150,
                                                          "starttime": 150,
                                                          "endTime": 150,
                                                          "scheduleTime": 150,
                                                          "scheduleDate": 150,
                                                          "clientName": 150,
                                                          "valuationrate": 150,
                                                          "valuationAmount": 150,
                                                          "brandName": 150,
                                                          "hold": 150,
                                                          "scheduleEndTime": 150,
                                                          "combineSpots": 150,
                                                          "neW_ID": 150,
                                                          "tapeDuration1": 150,
                                                          "tapeid": 150
                                                        },
                                                        mode: PlutoGridMode
                                                            .selectWithOneTap,
                                                        exportFileName:
                                                        "Amagi Spot Replacement",
                                                        onContextMenuClick: (
                                                            DataGridMenuItem itemType,
                                                            int index,
                                                            renderContext) {
                                                          switch (itemType) {
                                                            case DataGridMenuItem
                                                                .allowMergeSpots:
                                                              controller
                                                                  .mergeOrDoNotMerge(
                                                                  bookingDetCode: renderContext
                                                                      .row
                                                                      .cells['bookingDetailCode']
                                                                      ?.value ??
                                                                      0,
                                                                  bookingNo: renderContext
                                                                      .row
                                                                      .cells['bookingNumber']
                                                                      ?.value ??
                                                                      "",
                                                                  date: renderContext
                                                                      .row
                                                                      .cells['scheduleDate']
                                                                      ?.value,
                                                                  merge: 1);
                                                              print(
                                                                  renderContext
                                                                      .row
                                                                      .cells['bookingNumber']
                                                                      ?.value
                                                                      .toString());
                                                              break;
                                                            case DataGridMenuItem
                                                                .doNotMergeSpots:
                                                              controller
                                                                  .mergeOrDoNotMerge(
                                                                  bookingDetCode: renderContext
                                                                      .row
                                                                      .cells['bookingDetailCode']
                                                                      ?.value ??
                                                                      0,
                                                                  bookingNo: renderContext
                                                                      .row
                                                                      .cells['bookingNumber']
                                                                      ?.value ??
                                                                      "",
                                                                  date: renderContext
                                                                      .row
                                                                      .cells['scheduleDate']
                                                                      ?.value,
                                                                  merge: 0);
                                                              print(
                                                                  renderContext
                                                                      .row
                                                                      .cells['bookingNumber']
                                                                      ?.value
                                                                      .toString());
                                                              break;
                                                            default:
                                                              print(
                                                                  "break call");
                                                          }
                                                        },
                                                        mapData: controller
                                                            .amagiSpotReplacementModel
                                                            ?.lstSpots
                                                            ?.masterSpots
                                                            ?.map((e) =>
                                                            e.toJson())
                                                            .toList()
                                                        as List<dynamic>,
                                                        // mapData: (controller.dataList)!,
                                                        widthRatio:
                                                        Get.width / 9 - 1,
                                                        onSelected: (
                                                            PlutoGridOnSelectedEvent val) {
                                                          controller
                                                              .masterSpotIndex =
                                                              val.rowIdx ?? 0;
                                                          controller.bindData();
                                                        },
                                                        colorCallback: (
                                                            PlutoRowColorContext colorData) {
                                                          Color color = Colors
                                                              .white;
                                                          if (controller
                                                              .masterSpotsStateManager
                                                              ?.currentRowIdx ==
                                                              colorData
                                                                  .rowIdx) {
                                                            color = Color(
                                                                0xFFD1C4E9);
                                                          }
                                                          return color;
                                                        },
                                                        onload:
                                                            (
                                                            PlutoGridOnLoadedEvent
                                                            load) {
                                                          controller
                                                              .masterSpotsStateManager =
                                                              load.stateManager;
                                                          // controllerX.stateManager = load.stateManager;

                                                          controller
                                                              .masterSpotsStateManager
                                                              ?.setCurrentCell(
                                                              controller
                                                                  .masterSpotsStateManager
                                                                  ?.getRowByIdx(
                                                                  controller
                                                                      .masterSpotsStateManager
                                                                      ?.currentRowIdx ??
                                                                      0)
                                                                  ?.cells['bookingNumber'],
                                                              controller
                                                                  .masterSpotsStateManager
                                                                  ?.currentRowIdx ??
                                                                  0);

                                                          load.stateManager
                                                              .setSelectingMode(
                                                              PlutoGridSelectingMode
                                                                  .cell);
                                                        },
                                                      )
                                                          : Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: ListView(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "Available",
                                                    controller: controller
                                                        .availableController,
                                                    width: 0.1,
                                                    // autoFocus: true,
                                                    isEnable: controller.isEnable1,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                  InputFields.formField1(
                                                    hintTxt: "Allocated",
                                                    controller: controller
                                                        .allocatedController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "Un Allocated",
                                                    controller: controller
                                                        .unAllocatedController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controllerX.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                  InputFields.formField1(
                                                    hintTxt: "Balance",
                                                    controller: controller
                                                        .balanceController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controllerX.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "Ms Time",
                                                    controller: controller
                                                        .msTimeController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controllerX.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                  InputFields.formField1(
                                                    hintTxt: "LS Alloc",
                                                    controller: controller
                                                        .lsAllocController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controllerX.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "LS Rev",
                                                    controller: controller
                                                        .lsRevController,
                                                    width: 0.2,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controllerX.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Deallocate",
                                                        callback: () {
                                                          controller
                                                              .btnDeallocateClick();
                                                        },
                                                        showIcon: true,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Allocate",
                                                        callback: () {
                                                          controller
                                                              .btnAllocateClick();
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: [
                                                  Obx(() {
                                                    return Checkbox(
                                                        value: controller
                                                            .chkChecktimeBand
                                                            .value,
                                                        onChanged: (val) {
                                                          controller
                                                              .chkChecktimeBand
                                                              .value = val!;
                                                          controller
                                                              .chkChecktimeBand
                                                              .refresh();
                                                        });
                                                  }),
                                                  Text("Show Allowed")
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Deal Hold",
                                                        callback: () {
                                                          controller
                                                              .btnDeallocateHoldClick();
                                                          // controller.getPivotList(postData: controller.getDataFromGrid(controller.localSpotsStateManager));
                                                        },
                                                        showIcon: true,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Summary",
                                                        callback: () {
                                                          controller
                                                              .dialogWidget =
                                                          null;
                                                          controller
                                                              .canDialogShow
                                                              .value = false;
                                                          controller.isSummary
                                                              .value = true;
                                                          controller.update(
                                                              ['id']);
                                                          Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                                () {
                                                              controller
                                                                  .getSummaryAPICall()
                                                                  .then((
                                                                  value) {
                                                                print(
                                                                    ">>>>>>>>>>>>>>>>>from view Side" +
                                                                        value
                                                                            .toString());
                                                                if (controller
                                                                    .canDialogShow
                                                                    .value ==
                                                                    true) {
                                                                  controller
                                                                      .title
                                                                      ?.value =
                                                                  "Summary";
                                                                  controller
                                                                      .isSummary
                                                                      .value =
                                                                  true;
                                                                  controller
                                                                      .mapList
                                                                      .value =
                                                                      value;
                                                                  controller
                                                                      .mapList
                                                                      .refresh();
                                                                  // dragableDialog(mapList: value);
                                                                  controller
                                                                      .title
                                                                      ?.refresh();
                                                                } else {
                                                                  controller
                                                                      .title
                                                                      ?.value =
                                                                  "Summary";
                                                                  print(
                                                                      ">>>>>>>>>valueMapData" +
                                                                          value
                                                                              .toString());
                                                                  controller
                                                                      .mapList
                                                                      .value =
                                                                      value;
                                                                  controller
                                                                      .isSummary
                                                                      .value =
                                                                  true;
                                                                  controller
                                                                      .isSummary
                                                                      .refresh();
                                                                  dragableDialogClient();
                                                                }
                                                              });
                                                            },);
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Un Alloc",
                                                        callback: () {
                                                          controller
                                                              .dialogWidget =
                                                          null;
                                                          controller
                                                              .canDialogShow
                                                              .value = false;
                                                          controller.update(
                                                              ['id']);
                                                          controller.isSummary
                                                              .value = false;

                                                          Future.delayed(
                                                            const Duration(
                                                                seconds: 1), () {
                                                            controller
                                                                .getUnallocatedHoldCall()
                                                                .then((value) {
                                                              if (controller
                                                                  .canDialogShow
                                                                  .value ==
                                                                  true) {
                                                                controller.title
                                                                    ?.value =
                                                                "Un Alloc";
                                                                controller
                                                                    .mapList
                                                                    .value =
                                                                    value;
                                                                controller
                                                                    .isSummary
                                                                    .value =
                                                                false;
                                                                controller
                                                                    .isSummary
                                                                    .refresh();
                                                                controller
                                                                    .mapList
                                                                    .refresh();
                                                                // dragableDialog(mapList: value);
                                                                controller.title
                                                                    ?.refresh();
                                                              } else {
                                                                controller.title
                                                                    ?.value =
                                                                "Client";
                                                                print(
                                                                    ">>>>>>>>>valueMapData" +
                                                                        value
                                                                            .toString());
                                                                controller
                                                                    .mapList
                                                                    .value =
                                                                    value;
                                                                controller
                                                                    .isSummary
                                                                    .value =
                                                                false;
                                                                controller
                                                                    .isSummary
                                                                    .refresh();
                                                                dragableDialogClient();
                                                              }
                                                            });
                                                          },);
                                                        },
                                                        showIcon: true,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 4.0,
                                                        left: 10,
                                                        right: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width *
                                                          0.1,
                                                      child: FormButtonWrapper(
                                                        btnText: "Clients",
                                                        callback: () {
                                                          controller
                                                              .dialogWidget =
                                                          null;
                                                          controller
                                                              .canDialogShow
                                                              .value = false;
                                                          controller.update(
                                                              ['id']);
                                                          controller.isSummary
                                                              .value = false;

                                                          Future.delayed(
                                                            const Duration(
                                                                seconds: 1), () {
                                                            controller
                                                                .getClientAPICall()
                                                                .then((value) {
                                                              if (controller
                                                                  .canDialogShow
                                                                  .value ==
                                                                  true) {
                                                                controller.title
                                                                    ?.value =
                                                                "Client";
                                                                controller
                                                                    .mapList
                                                                    .value =
                                                                    value;
                                                                controller
                                                                    .isSummary
                                                                    .value =
                                                                false;
                                                                controller
                                                                    .isSummary
                                                                    .refresh();
                                                                controller
                                                                    .mapList
                                                                    .refresh();
                                                                // dragableDialog(mapList: value);
                                                                controller.title
                                                                    ?.refresh();
                                                              } else {
                                                                controller.title
                                                                    ?.value =
                                                                "Client";
                                                                print(
                                                                    ">>>>>>>>>valueMapData" +
                                                                        value
                                                                            .toString());
                                                                controller
                                                                    .mapList
                                                                    .value =
                                                                    value;
                                                                controller
                                                                    .isSummary
                                                                    .value =
                                                                false;
                                                                controller
                                                                    .isSummary
                                                                    .refresh();
                                                                dragableDialogClient();
                                                              }
                                                            });
                                                          },);
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
                                                    top: 4.0,
                                                    left: 10,
                                                    right: 10),
                                                child: FormButtonWrapper(
                                                  btnText: "Total",
                                                  callback: () {
                                                    controller.dialogWidget =
                                                    null;
                                                    controller.canDialogShow
                                                        .value = false;
                                                    controller.isSummary.value =
                                                    false;
                                                    controller.update(['id']);

                                                    Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                      controller
                                                          .getTotalAPICall()
                                                          .then((value) {
                                                        if (controller
                                                            .canDialogShow
                                                            .value ==
                                                            true) {
                                                          controller.title
                                                              ?.value =
                                                          "Total";
                                                          controller.mapList
                                                              .value =
                                                              value;
                                                          controller.isSummary
                                                              .value = false;
                                                          controller.isSummary
                                                              .refresh();
                                                          controller.mapList
                                                              .refresh();
                                                          // dragableDialog(mapList: value);
                                                          controller.title
                                                              ?.refresh();
                                                        } else {
                                                          controller.title
                                                              ?.value =
                                                          "Total";
                                                          print(
                                                              ">>>>>>>>>valueMapData" +
                                                                  value
                                                                      .toString());
                                                          controller.mapList
                                                              .value =
                                                              value;
                                                          controller.isSummary
                                                              .value = false;
                                                          controller.isSummary
                                                              .refresh();
                                                          dragAbleDialogGetTotal();
                                                        }
                                                      });
                                                    },);
                                                  },
                                                  showIcon: true,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "Lo Dur",
                                                    controller: controller
                                                        .loDurController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controller.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                  InputFields.formField1(
                                                    hintTxt: "Lo Dur Mis",
                                                    controller: controller
                                                        .loDurMisController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controller.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InputFields.formField1(
                                                    hintTxt: "Lo Total",
                                                    controller: controller
                                                        .loTotalController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controller.isEnable,
                                                    onchanged: (value) {},
                                                    // autoFocus: true,
                                                  ),
                                                  InputFields.formField1(
                                                    hintTxt: "Lo Miss",
                                                    controller: controller
                                                        .loMissController,
                                                    width: 0.1,
                                                    isEnable: controller.isEnable1,
                                                    // autoFocus: true,
                                                    // isEnable: controller.isEnable,
                                                    onchanged: (value) {},
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
                                          flex: 10,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: GetBuilder<
                                                    AmagiSpotsReplacementController>(
                                                  assignId: true,
                                                  id: "localSpots",
                                                  builder: (controller) {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.all(3.0),
                                                      child: (controller
                                                          .amagiSpotReplacementModel !=
                                                          null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots !=
                                                              null &&
                                                          controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.localSpots !=
                                                              null &&
                                                          (controller
                                                              .amagiSpotReplacementModel
                                                              ?.lstSpots
                                                              ?.localSpots
                                                              ?.length ??
                                                              0) >
                                                              0)
                                                          ? DataGridFromMapForAmagiSpotReplacement(
                                                        showSrNo: false,
                                                        hideCode: false,
                                                        formatDate: false,
                                                        isLocalSpotGrid: true,
                                                        columnAutoResize: false,
                                                        numTypeKeyList: ["bookingDetailCode"],
                                                        widthSpecificColumn: {
                                                          "colNo": 150,
                                                          "bookingNumber": 150,
                                                          "clientName": 150,
                                                          "tapeCode": 150,
                                                          "tapeDuration": 150,
                                                          "rate": 150,
                                                          "spotAmount": 150,
                                                          "valuationrate": 150,
                                                          "valuationAmount": 150,
                                                          "starttime": 150,
                                                          "endTime": 150,
                                                          "parentID": 150,
                                                          "bookingDetailCode": 150
                                                        },
                                                        hideKeys: [
                                                          "id",
                                                          "clientPriority",
                                                          "priority",
                                                          "locationCode",
                                                          "channelCode",
                                                          "channelid"
                                                        ],
                                                        mode: PlutoGridMode
                                                            .normal,
                                                        exportFileName:
                                                        "Amagi Spot Replacement",
                                                        mapData: controller
                                                            .amagiSpotReplacementModel
                                                            ?.lstSpots
                                                            ?.localSpots
                                                            ?.map((e) =>
                                                            e
                                                                .toJson())
                                                            .toList()
                                                        as List<dynamic>,
                                                        // mapData: (controller.dataList)!,
                                                        widthRatio:
                                                        Get.width / 9 - 1,
                                                        colorCallback: (
                                                            PlutoRowColorContext colorData) {
                                                          Color color = Colors
                                                              .white;
                                                          if (controller
                                                              .localSpotsStateManager
                                                              ?.currentRowIdx ==
                                                              colorData
                                                                  .rowIdx) {
                                                            color = Color(
                                                                0xFFD1C4E9);
                                                          }
                                                          return color;
                                                        },
                                                        onSelected: (
                                                            PlutoGridOnSelectedEvent val) {
                                                          controller
                                                              .localSpotIndex =
                                                              val.rowIdx ?? 0;
                                                        },
                                                        onload:
                                                            (
                                                            PlutoGridOnLoadedEvent
                                                            load) {
                                                          controller
                                                              .localSpotsStateManager =
                                                              load.stateManager;
                                                          controller
                                                              .localSpotsStateManager
                                                              ?.setCurrentCell(
                                                              controller
                                                                  .localSpotsStateManager
                                                                  ?.getRowByIdx(
                                                                  controller
                                                                      .localSpotsStateManager
                                                                      ?.currentRowIdx ??
                                                                      0)
                                                                  ?.cells['tapeDuration'],
                                                              controller
                                                                  .localSpotsStateManager
                                                                  ?.currentRowIdx ??
                                                                  0);
                                                          load.stateManager
                                                              .setSelectingMode(
                                                              PlutoGridSelectingMode
                                                                  .cell);
                                                          // controller.stateManager = load.stateManager;
                                                        },
                                                      )
                                                          : Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(height: 5),

                        /// bottom common buttons
                        Align(
                          alignment: Alignment.topLeft,
                          child: GetBuilder<HomeController>(
                              id: "buttons",
                              init: Get.find<HomeController>(),
                              builder: (controllerX) {
                                PermissionModel formPermissions =
                                Get
                                    .find<MainController>()
                                    .permissionList!
                                    .lastWhere((element) =>
                                element.appFormName == "frmSPReports");
                                if (controllerX.buttons != null) {
                                  return Wrap(
                                    spacing: 5,
                                    runSpacing: 15,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      for (var btn in controllerX.buttons!)
                                        FormButtonWrapper(
                                          btnText: btn["name"],
                                          callback: Utils.btnAccessHandler2(
                                              btn['name'],
                                              controllerX,
                                              formPermissions) ==
                                              null
                                              ? null
                                              : () =>
                                              controller.formHandler(
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
          },
        );
      },
    );
  }
}
