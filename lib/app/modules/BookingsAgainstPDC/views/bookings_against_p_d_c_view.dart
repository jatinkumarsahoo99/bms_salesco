import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:bms_salesco/app/routes/app_pages.dart';
import 'package:bms_salesco/widgets/FormButton.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:bms_salesco/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../widgets/dropdown.dart';
import '../controllers/bookings_against_p_d_c_controller.dart';

class BookingsAgainstPDCView extends StatelessWidget {
  const BookingsAgainstPDCView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.devicewidth,
        height: context.deviceheight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder(
            init: Get.put(BookingsAgainstPDCController()),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      DropDownField.formDropDownSearchAPI2(
                        GlobalKey(),
                        context,
                        title: "Client",
                        url: 'url',
                        onchanged: (p0) {},
                        width: context.devicewidth * .2,
                      ),
                      DropDownField.formDropDown1Width(
                        context,
                        [],
                        (val) {},
                        "Agency",
                        .2,
                        paddingLeft: 0,
                      ),
                      InputFields.numbers(
                        hintTxt: "Activity Month",
                        controller: TextEditingController(text: '0'),
                        isNegativeReq: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      DropDownField.formDropDown1Width(
                        context,
                        [],
                        (val) {},
                        "Cheque No",
                        .2,
                        paddingLeft: 0,
                      ),
                      FormButton(
                        btnText: "Get Bookings",
                        callback: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: controller.dataTableList.value.isEmpty
                            ? BoxDecoration(
                                border: Border.all(color: Colors.grey))
                            : null,
                        child: controller.dataTableList.value.isEmpty
                            ? null
                            : DataGridFromMap(
                                mapData: controller.dataTableList.value),
                      );
                    }),
                  ),
                  Get.find<HomeController>()
                      .getCommonButton<BookingsAgainstPDCController>(
                    Routes.BOOKINGS_AGAINST_P_D_C,
                    (formName) {},
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
