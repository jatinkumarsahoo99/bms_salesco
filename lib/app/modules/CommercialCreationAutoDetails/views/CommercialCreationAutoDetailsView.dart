import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../controllers/CommercialCreationAutoDetailsController.dart';

class CommercialCreationAutoDetailsView
    extends GetView<CommercialCreationAutoDetailsController> {
  CommercialCreationAutoDetailsController controllerX =
      Get.put<CommercialCreationAutoDetailsController>(
          CommercialCreationAutoDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 8,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Obx(
                              () => DropDownField.formDropDownSearchAPI2(
                                  GlobalKey(), context,
                                  title: "Client",
                                  autoFocus: true,
                                  customInData: "lstClientMaster",
                                  url: ApiFactory
                                      .COMMERCIAL_CREATION_CLIENT_LIST(),
                                  parseKeyForKey: "clientcode",
                                  parseKeyForValue: "Clientname",
                                  onchanged: (data) {
                                controllerX.selectClient?.value = data;
                              },
                                  selectedValue:
                                      controllerX.selectClient?.value,
                                  width: (Get.width * 0.60) + 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: DropDownField.formDropDownSearchAPI2(
                                GlobalKey(), context,
                                title: "Brand",
                                autoFocus: true,
                                url: ApiFactory
                                    .COMMERCIAL_CREATION_CLIENT_LIST(),
                                parseKeyForKey: "programName",
                                parseKeyForValue: "programName",
                                onchanged: (data) {},
                                // selectedValue: controllerX.selectProgram,
                                width: (Get.width * 0.60) + 20
                                // padding: const EdgeInsets.only(

                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: InputFields.formField1Width(
                              widthRatio: 0.12,
                              paddingLeft: 0,
                              hintTxt: "Agency Id",
                              controller: controllerX.agencyId_,
                              autoFocus: true,
                              onChange: (v) {
                                // controllerX.searchInDubbed();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: InputFields.formField1Width(
                              widthRatio: 0.12,
                              paddingLeft: 0,
                              hintTxt: "Tape Id",
                              controller: controllerX.tapeId_,
                              autoFocus: true,
                              onChange: (v) {
                                // controllerX.searchInDubbed();
                              },
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropDownField.formDropDown1WidthMap(
                                  controllerX.loadModel?.value?.loadData
                                          ?.lstLanguage ??
                                      [], (data) {
                                controllerX.selectLanguage?.value = data;
                              }, "Language", 0.12,
                                  searchReq: true,
                                  selected: controllerX.selectLanguage?.value),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropDownField.formDropDown1WidthMap(
                                  controllerX.loadModel?.value?.loadData
                                          ?.lstCensorship ??
                                      [], (data) {
                                controllerX.selectCensorship = data;
                              }, "Censorship", 0.12,
                                  searchReq: true,
                                  selected: controllerX.selectCensorship),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropDownField.formDropDown1WidthMap(
                                  controllerX.loadModel?.value?.loadData
                                          ?.lstRevenuetype ??
                                      [], (data) {
                                controllerX.selectRevenue = data;
                                controllerX.getRevenueLeave(data.key ?? "");
                              }, "Revenue", 0.12,
                                  searchReq: true,
                                  selected: controllerX.selectRevenue),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropDownField.formDropDown1WidthMap(
                                  controllerX.loadModel?.value?.loadData
                                          ?.lstRevenuetype ??
                                      [], (data) {
                                controllerX.selectSectype = data;
                              }, "Sec Type", 0.12,
                                  searchReq: true,
                                  selected: controllerX.selectSectype),
                            ),
                          ),
                          InputFields.formFieldNumberMask(
                              hintTxt: "SOM",
                              controller: controllerX.som_,
                              widthRatio: 0.12,
                              paddingLeft: 5,
                              onEditComplete: (val) {
                                // control.getCaption();
                              }
                              // paddingLeft: 0,
                              ),

                          /// TC out
                          InputFields.formFieldNumberMask(
                              hintTxt: "EOM",
                              textFieldFN: controllerX.eomFocus,
                              controller: controllerX.eom_,
                              widthRatio: 0.12,
                              paddingLeft: 5,
                              onEditComplete: (val) {
                                controllerX.calculateSegDur();
                              }),

                          /// Seg Dur
                          Obx(
                            () => InputFields.formFieldDisableWidth(
                              hintTxt: "Seg Dur",
                              paddingLeft: 5,
                              value: controllerX.duration.value,
                              widthRatio: 0.12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: DateWithThreeTextField(
                              title: "End Date",
                              splitType: "-",
                              widthRation: 0.12,
                              onFocusChange: (data) {
                                print("Called when focus changed");
                              },
                              mainTextController: controllerX.endDate_,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: InputFields.formField1Width(
                              widthRatio: 0.24,
                              paddingLeft: 5,
                              // height: 50,
                              maxLen: 100,
                              hintTxt: "Caption",
                              controller: controllerX.caption_,
                            ),
                          ),
                          buildRowText("Client", controllerX.client),
                          buildRowText("Brand", controllerX.brand),
                          buildRowText("Language", controllerX.language),
                          buildRowText("Duration", controllerX.duration1),
                          buildRowText("Provider", controllerX.providers),
                          buildRowText("ACID", controllerX.ACID),
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Obx(() => HtmlWidget(
                            controllerX.htmlBody.value,
                        renderMode: RenderMode.column,

                        // set the default styling for text
                        textStyle: TextStyle(fontSize: 14),

                      )),
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<HomeController>(
                id: "buttons",
                init: Get.find<HomeController>(),
                builder: (controller) {
                  print("Data is???" +
                      Routes.COMMERCIAL_CREATION_AUTO.replaceAll("/", ""));
                  int? index = Get.find<MainController>()
                      .permissionList!
                      .indexWhere((element) {
                    return element.appFormName ==
                        Routes.COMMERCIAL_CREATION_AUTO.replaceAll("/", "");
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

  buildRowText(String title1, RxString value1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title1,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(() => Text(
                        value1.value,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        textAlign: TextAlign.start,
                      )),
                ),
              ),
            ],
          ),
        ],
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
        Get.delete<CommercialCreationAutoDetailsController>();
        break;
    }
  }
}