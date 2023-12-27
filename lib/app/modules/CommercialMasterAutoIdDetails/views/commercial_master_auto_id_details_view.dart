import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../controllers/commercial_master_auto_id_details_controller.dart';

class CommercialMasterAutoIdDetailsView
    extends GetView<CommercialMasterAutoIdDetailsController> {
   CommercialMasterAutoIdDetailsView({Key? key}) : super(key: key);

   CommercialMasterAutoIdDetailsController controllerX =
   Get.put<CommercialMasterAutoIdDetailsController>(
       CommercialMasterAutoIdDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details",
            style: const TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Get.back();
            }),
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent raw) {
          if (raw is RawKeyDownEvent &&
              raw.logicalKey == LogicalKeyboardKey.escape) {
            Get.back();
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
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
                            flex: 6,
                            child: Column(
                              // crossAxisAlignment: WrapCrossAlignment.start,
                              // runSpacing: 8,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Obx(
                                        () => DropDownField.formDropDownSearchAPI2(
                                        GlobalKey(), context,
                                        title: "Client",
                                        autoFocus: true,
                                        inkwellFocus: controller.clientFocus,
                                        customInData: "lstClientMaster",
                                        url: ApiFactory
                                            .COMMERCIAL_MASTER_CLIENT_LIST(),
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
                                Obx(() => Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: DropDownField.formDropDownSearchAPI2(
                                      GlobalKey(), context,
                                      title: "Brand",
                                      autoFocus: true,
                                      customInData: "lstbrandmaster",
                                      url: ApiFactory
                                          .COMMERCIAL_MASTER_BRAND_LIST(
                                        controllerX.selectClient?.value?.key ??
                                            "",
                                      ),
                                      parseKeyForKey: "Brandcode",
                                      parseKeyForValue: "Brandname",
                                      onchanged: (data) {
                                        controllerX.selectBrand?.value = data;
                                        FocusScope.of(context).nextFocus();
                                      },
                                      selectedValue:
                                      controllerX.selectBrand?.value,
                                      width: (Get.width * 0.60) + 20
                                    // padding: const EdgeInsets.only(

                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: InputFields.formField1Width(
                                    // widthRatio: 0.12,
                                    widthRatio: (Get.width * 0.60) + 20,
                                    paddingLeft: 0,
                                    hintTxt: "Agency Id",
                                    controller: controllerX.agencyId_,
                                    autoFocus: true,
                                    onChange: (v) {
                                      // controllerX.searchInDubbed();
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: InputFields.formField1Width(
                                        widthRatio: 0.15,
                                        paddingLeft: 0,
                                        hintTxt: "Tape Id",
                                        controller: controllerX.tapeId_,
                                        autoFocus: true,
                                        isEnable: false,
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
                                          Future.delayed(Duration(milliseconds: 500),(){
                                            FocusScope.of(context).nextFocus();
                                          });
                                          // FocusScope.of(context).nextFocus();
                                        }, "Language", 0.15,
                                            searchReq: true,
                                            selected:
                                            controllerX.selectLanguage?.value),
                                      ),
                                    ),

                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Get.width*0.38,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                                () => Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: DropDownField.formDropDown1WidthMap(
                                                  controllerX.loadModel?.value?.loadData
                                                      ?.lstCensorship ??
                                                      [], (data) {
                                                controllerX.selectCensorship?.value = data;
                                                Future.delayed(Duration(milliseconds: 500),(){
                                                  FocusScope.of(context).nextFocus();
                                                });
                                                // FocusScope.of(context).nextFocus();
                                              }, "Censorship", 0.15,
                                                  searchReq: true,
                                                  labelBold: true,
                                                  selected:
                                                  controllerX.selectCensorship?.value),
                                            ),
                                          ),
                                          Obx(
                                                () => Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: DropDownField.formDropDown1WidthMap(
                                                  controllerX.loadModel?.value?.loadData
                                                      ?.lstRevenuetype ??
                                                      [], (data) {
                                                controllerX.selectRevenue?.value = data;
                                                controllerX.getRevenueLeave(data.key ?? "");
                                              }, "Revenue", 0.15,
                                                  searchReq: true,
                                                  labelBold: true,
                                                  selected: controllerX.selectRevenue?.value),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Obx(
                                          () => Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: DropDownField.formDropDown1WidthMap(
                                            controllerX.secTypeList.value ?? [],
                                                (data) {
                                              controllerX.selectSectype?.value = data;
                                            }, "Sec Type", 0.15,
                                            searchReq: true,
                                            labelBold: true,
                                            selected: controllerX.selectSectype?.value),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:Get.width*0.38,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InputFields.formFieldNumberMask(
                                              hintTxt: "SOM",
                                              controller: controllerX.som_,
                                              widthRatio: 0.15,
                                              paddingLeft: 5,
                                              onEditComplete: (val) {
                                                // control.getCaption();
                                              }
                                            // paddingLeft: 0,
                                          ),
                                          InputFields.formFieldNumberMask(
                                              hintTxt: "EOM",
                                              textFieldFN: controllerX.eomFocus,
                                              controller: controllerX.eom_,
                                              widthRatio: 0.15,
                                              paddingLeft: 5,
                                              onEditComplete: (val) {
                                                controllerX.calculateSegDur();
                                              }),
                                        ],
                                      ),
                                    ),
                                    /// TC out


                                    /// Seg Dur
                                    Obx(
                                          () => InputFields.formFieldDisableWidth(
                                        hintTxt: "Duration",
                                        paddingLeft: 5,
                                        isHeaderRequiredGrey: false,
                                        value: controllerX.duration.value,
                                        widthRatio: 0.15,
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: InputFields.formField1Width(
                                    widthRatio: (Get.width * 0.60) + 20,
                                    paddingLeft: 5,
                                    // height: 50,
                                    maxLen: 100,
                                    hintTxt: "Caption",
                                    controller: controllerX.caption_,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                          () => Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: DropDownField.formDropDown1WidthMap(
                                            controllerX.loadModel?.value?.loadData
                                                ?.location ??
                                                [], (data) {
                                          controllerX.selectLocation?.value = data;
                                          Future.delayed(Duration(milliseconds: 500),(){
                                            FocusScope.of(context).nextFocus();
                                          });
                                          // FocusScope.of(context).nextFocus();
                                        }, "Location",
                                            0.38,
                                            searchReq: true,
                                            selected:
                                            controllerX.selectLocation?.value),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: DateWithThreeTextField(
                                        title: "End Date",
                                        splitType: "-",
                                        // year: DateTime.now().year+1,
                                        // intailDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),
                                        // startDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),
                                        widthRation: 0.15,
                                        formatting: "dd-MM-yyyy",
                                        onFocusChange: (data) {
                                          print("Called when focus changed");
                                        },
                                        mainTextController: controllerX.endDate_,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: buildRowText("Client", controllerX.client)),
                                    Expanded(child: buildRowText("Territory", controllerX.temitory)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: buildRowText("Brand", controllerX.brand)),
                                    Expanded(child: buildRowText("Tape Type", controllerX.tapeType)),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: buildRowText("Language", controllerX.language)),
                                    Expanded(child: Container())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: buildRowText("Duration", controllerX.duration1)),
                                    Expanded(child: Container())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: buildRowText("Provider", controllerX.providers)),
                                    Expanded(child: Container())
                                  ],
                                ),
                                /*Row(
                                  children: [
                                    Expanded(child: buildRowText("ACID", controllerX.ACID)),
                                    Expanded(child: Container())
                                  ],
                                ),*/
SizedBox(
  height: 4,
),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Data From Agency",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: buildRowText("Client", controllerX.client)),
                                            Expanded(child: buildRowText("Brand", controllerX.brand)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: buildRowText("Language", controllerX.language)),
                                            Expanded(child: buildRowText("Censorship", controllerX.censorship)),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: buildRowText("Revenue", controllerX.revenue),),
                                            Expanded(child: buildRowText("Sec Type", controllerX.secType)),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: buildRowText("Location", controllerX.location)),
                                            Expanded(child: Container())
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          VerticalDivider(),
                          Expanded(
                            flex: 4,
                            child: Obx(() => controllerX.htmlBody.value != ""
                                ? HtmlWidget(
                              controllerX.htmlBody.value,
                              renderMode: RenderMode.column,

                              // set the default styling for text
                              textStyle: TextStyle(fontSize: 14),
                            )
                                : Container()),
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
            );
          }
        ),
      ),
    );
  }

  Widget buildRowText(String title1, RxString value1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
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
        controllerX.save();
        break;
      case "Clear":
        controllerX.clear();

        // Get.find<HomeController>().clearPage1();
        // Get.delete<CommercialCreationAutoDetailsController>();
        break;
    }
  }
}
