import 'package:get/get.dart';

import '../controllers/p_d_c_cheques_controller.dart';

class PDCChequesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PDCChequesController>(
      () => PDCChequesController(),
    );
  }
}
