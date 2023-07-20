import 'package:bms_salesco/widgets/DateTime/DateWithThreeTextField.dart';
import 'package:bms_salesco/widgets/gridFromMap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/Utils.dart';
import '../controllers/same_day_collection_controller.dart';

class SameDayCollectionView extends GetView<SameDayCollectionController> {
  const SameDayCollectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Wrap(
                spacing: 10,
                // runAlignment: WrapAlignment.end,
                // alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Location",
                    .15,
                    autoFocus: true,
                  ),
                  DropDownField.formDropDown1WidthMap(
                    [],
                    (p0) => null,
                    "Channell",
                    .15,
                  ),
                  DateWithThreeTextField(
                    title: "From",
                    mainTextController: TextEditingController(),
                  ),
                  FormButton(
                    btnText: "Show",
                    callback: () {},
                  ),
                  FormButton(
                    btnText: "Check All",
                    callback: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: controller.dataTableList.isEmpty
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    child: controller.dataTableList.isEmpty
                        ? null
                        : DataGridFromMap(
                            mapData: controller.dataTableList.value,
                          ),
                  );
                },
              ),
            ),

            /// bottom common buttons
            Align(
              alignment: Alignment.topLeft,
              child: GetBuilder<HomeController>(
                  id: "buttons",
                  init: Get.find<HomeController>(),
                  builder: (btncontroller) {
                    if (btncontroller.buttons != null) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: SizedBox(
                          height: 40,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 15,
                            alignment: WrapAlignment.center,
                            children: [
                              for (var btn in btncontroller.buttons!) ...{
                                FormButtonWrapper(
                                  btnText: btn["name"],
                                  callback: ((Utils.btnAccessHandler(btn['name'], controller.formPermissions!) == null))
                                      ? null
                                      : () => controller.formHandler(btn['name']),
                                )
                              },
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
