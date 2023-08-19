import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/radio_row.dart';
import '../../../controller/HomeController.dart';
import '../controllers/international_sales_report_controller.dart';

class InternationalSalesReportView
    extends GetView<InternationalSalesReportController> {
   InternationalSalesReportView({Key? key}) : super(key: key);

  InternationalSalesReportController controllerX =
  Get.put<InternationalSalesReportController>(InternationalSalesReportController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  DateWithThreeTextField(
                    title: "From Date",
                    mainTextController: controllerX.fromDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DateWithThreeTextField(
                    title: "To Date",
                    mainTextController: controllerX.toDateController,
                    widthRation: .1,
                    isEnable: controllerX.isEnable.value,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(()=> Padding(
                    padding: const EdgeInsets.only(top: 12.0,left: 0),
                    child: RadioRow(
                      items: [
                        "Detail",
                        "Summary"
                      ],
                      groupValue:
                      controllerX.selectValue.value ?? "",
                      onchange: (String v) {
                        print(">>>>"+v);
                        controllerX.selectValue.value=v;
                        controllerX.getRadioStatus(v);
                        controllerX.selectValue.refresh();
                      },
                    ),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Generate",
                          callback: () {
                            controllerX.callBtnGenerate();
                          },
                          showIcon: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "clear",
                          callback: () {
                            Get.delete<InternationalSalesReportController>();
                            Get.find<HomeController>().clearPage1();
                          },
                          showIcon: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 10, right: 10),
                        child: FormButtonWrapper(
                          btnText: "Exit",
                          callback: () {
                            Get.delete<InternationalSalesReportController>();
                          },
                          showIcon: true,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                // flex: 9,
                child: Container(
                  child:  GetBuilder<InternationalSalesReportController>(
                      id: "grid",
                      builder: (controllerX) {
                        return (controllerX.isSummary)?
                        (controllerX.internationalSalesReportModel?.report?.internationalSalesSummary != null &&
                            (controllerX.internationalSalesReportModel?.report?.internationalSalesSummary?.length??0) >0
                        )? DataGridFromMap(
                          showSrNo: false,
                          hideCode: false,
                          formatDate: false,
                          mapData: (controllerX.internationalSalesReportModel!.report?.internationalSalesSummary
                              ?.map((e) => e.toJson())
                              .toList())!,
                          // mapData: (controllerX.dataList)!,
                          widthRatio: Get.width / 9 - 1,
                        ): Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),

                        ):(controllerX.internationalSalesReportModel?.report?.internationalDetails != null &&
                            (controllerX.internationalSalesReportModel?.report?.internationalDetails?.length??0) >0)?
                        DataGridFromMap(
                          showSrNo: false,
                          hideCode: false,
                          formatDate: false,
                          mapData: (controllerX.internationalSalesReportModel!.report?.internationalDetails
                              ?.map((e) => e.toJson())
                              .toList())!,
                          // mapData: (controllerX.dataList)!,
                          widthRatio: Get.width / 9 - 1,
                        ):Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                        );
                      }
                  ),

                ),
              ),
              /// bottom common buttons
            ],
          ),
        ),
      ),
    );
  }
}
