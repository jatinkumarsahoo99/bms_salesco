import 'package:bms_salesco/app/providers/extensions/screen_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/HomeController.dart';
import '../../../routes/app_pages.dart';
import '../controllers/p_d_c_cheques_controller.dart';

class PDCChequesView extends StatelessWidget {
  const PDCChequesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.devicewidth,
        height: context.deviceheight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder(
            init: Get.put(PDCChequesController()),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Get.find<HomeController>()
                      .getCommonButton<PDCChequesController>(
                    Routes.P_D_C_CHEQUES,
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
