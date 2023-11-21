import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
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
    final controller = Get.put(BookingsAgainstPDCController());
    return Scaffold(
      body: SizedBox(
        width: context.devicewidth,
        height: context.deviceheight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<BookingsAgainstPDCController>(
            init: controller,
            id: 'rootUI',
            builder: (_) {
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
                        url: ApiFactory.BOOKING_AGAINST_PDC_GET_CLIENT,
                        onchanged: controller.handleOnChangeClient,
                        width: context.devicewidth * .2,
                        parseKeyForKey: "ClientCode",
                        parseKeyForValue: "ClientName",
                        autoFocus: true,
                        selectedValue: controller.selctedClient,
                      ),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.agencyList.value,
                          (val) => controller.selctedAgency = val,
                          "Agency",
                          .2,
                          selected: controller.selctedAgency,
                        );
                      }),
                      InputFields.numbers2(
                        focusNode: controller.activityMonthFN,
                        hintTxt: "Activity Month",
                        controller: controller.activityMonthCTR,
                        isNegativeReq: false,
                        showbtn: false,
                        inputformatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,4}'))
                        ],
                      ),
                      Obx(() {
                        return DropDownField.formDropDown1WidthMap(
                          controller.chequeList.value,
                          (val) => controller.selectedCheque = val,
                          "Cheque No",
                          .2,
                          selected: controller.selectedCheque,
                          inkWellFocusNode: controller.chequeFN,
                        );
                      }),
                      FormButton(
                        btnText: "Get Bookings",
                        callback: controller.getBookingList,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Booking Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Obx(() {
                      return DataGridFromMap3(
                        mapData: controller.dataTableList.value,
                        colorCallback: (cell) =>
                            controller.sm?.currentRow == (cell.row)
                                ? Colors.deepPurple.shade100
                                : Colors.white,
                        onload: (sm) {
                          controller.sm = sm.stateManager;
                        },
                      );
                    }),
                  ),
                  Get.find<HomeController>()
                      .getCommonButton<BookingsAgainstPDCController>(
                    Routes.BOOKINGS_AGAINST_P_D_C,
                    (btnName) {},
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
