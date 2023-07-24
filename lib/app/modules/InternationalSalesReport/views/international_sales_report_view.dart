import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/radio_row.dart';
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
        child: SizedBox(
          width: size.width * 0.95,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('International Sale Report'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      DateWithThreeTextField(
                        title: "From Date",
                        mainTextController: TextEditingController(),
                        widthRation: .1,
                        isEnable: controllerX.isEnable.value,
                      ),
                      DateWithThreeTextField(
                        title: "To Date",
                        mainTextController: TextEditingController(),
                        widthRation: .1,
                        isEnable: controllerX.isEnable.value,
                      ),
                      RadioRow(
                        items: [
                          "Detail",
                          "Summary"
                        ],
                        groupValue:
                        controllerX.selectValue.value ?? "",
                        onchange: (String v) {
                          print(">>>>"+v);
                          controllerX.selectValue.value=v;
                          controllerX.selectValue.refresh();
                        },
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
                                // controllerX.callGetRetrieve();
                              },
                              showIcon: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 14.0, left: 10, right: 10),
                            child: FormButtonWrapper(
                              btnText: "clear",
                              callback: () {
                                // controllerX.callGetRetrieve();
                              },
                              showIcon: false,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),

                  Expanded(
                    // flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child:  GetBuilder<InternationalSalesReportController>(
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
                  /// bottom common buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
