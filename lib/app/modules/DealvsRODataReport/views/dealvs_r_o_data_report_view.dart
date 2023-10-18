import 'package:bms_salesco/widgets/DataGridShowOnly.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../providers/SizeDefine.dart';
import '../controllers/dealvs_r_o_data_report_controller.dart';

class DealvsRODataReportView extends GetView<DealvsRODataReportController> {
  DealvsRODataReportController controller =
      Get.put<DealvsRODataReportController>(DealvsRODataReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DealvsRODataReportController>(
            init: controller,
            id: "rootUI",
            builder: (_) => Column(
                  children: [
                    Card(
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(4),
                        child: FocusTraversalGroup(
                          policy: OrderedTraversalPolicy(),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            runSpacing: 5,
                            spacing: 5,
                            children: [
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(1),
                                child: Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.locations.value, (data) {
                                    controller.selectLocation.value = data;
                                    controller.getChannels(data.key);
                                  }, "Location", 0.17,
                                      autoFocus: true,
                                      inkWellFocusNode: controller.locationFN,
                                      selected:
                                          controller.selectLocation.value),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(2),
                                child: Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.channels.value, (data) {
                                    controller.selectChannel.value = data;
                                    controller.getClients(
                                        controller.selectLocation.value?.key,
                                        controller.selectChannel.value?.key);
                                  }, "Channel", 0.17,
                                      inkWellFocusNode: controller.channelFN,
                                      selected: controller.selectChannel.value),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(3),
                                child: DateWithThreeTextField(
                                  title: "From",
                                  mainTextController: controller.fromDate,
                                  widthRation: 0.12,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(4),
                                child: DateWithThreeTextField(
                                  title: "To",
                                  mainTextController: controller.toDate,
                                  widthRation: 0.12,
                                  onFocusChange: (data) async {
                                    // LoadingDialog.call();
                                    // Get.back();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(5),
                                child: Obx(
                                  () => DropDownField.formDropDown1WidthMap(
                                      controller.clients.value, (data) {
                                    controller.selectClient.value = data;
                                    controller.getDeals(
                                        controller.selectLocation.value?.key,
                                        controller.selectChannel.value?.key,
                                        controller.selectClient.value?.key);
                                  }, "Client", 0.17,
                                      inkWellFocusNode: controller.clintFN,
                                      selected: controller.selectClient.value),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(
                                () => FocusTraversalOrder(
                                  order: const NumericFocusOrder(6),
                                  child: DropDownField.formDropDown1WidthMap(
                                    controller.dealsNo.value,
                                    (data) {
                                      controller.selectDealsNo.value = data;
                                    },
                                    "Deal No",
                                    0.17,
                                    selected: controller.selectDealsNo.value,
                                    inkWellFocusNode: controller.dealFN,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(() => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: controller.dataTypes
                                        .map((e) => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Radio(
                                                    value: e,
                                                    groupValue: controller
                                                        .currentType.value,
                                                    onChanged: (value) {
                                                      controller.currentType
                                                          .value = e;
                                                      controller
                                                          .getRadioStatus(e)
                                                          .then((value) {
                                                        // controller
                                                        //     .retrieveData();
                                                      });
                                                    }),
                                                Text(e),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              FormButtonWrapper(
                                btnText: "Clear",
                                callback: () {
                                  controller.clear();
                                },
                                showIcon: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FocusTraversalOrder(
                                order: const NumericFocusOrder(7),
                                child: FormButtonWrapper(
                                  btnText: "Retrieve",
                                  callback: () {
                                    controller.retrieveData();
                                  },
                                  showIcon: false,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.isDealMSG.value,
                                  child: Text(
                                    "Deal wise data showing.",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize:
                                            SizeDefine.fontSizeInputField),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        return Container(
                          child: controller.dataTableList.value.isEmpty
                              ? null
                              : DataGridShowOnlyKeys(
                                  mapData: controller.dataTableList.value,
                                  formatDate: false,
                                  exportFileName: "DealvsRO Data Report",
                                ),
                        );
                      }),
                    )
                  ],
                )));
  }
}
