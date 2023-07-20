import 'package:get/get.dart';

import '../controllers/change_r_o_number_controller.dart';

class ChangeRONumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeRONumberController>(
      () => ChangeRONumberController(),
    );
  }
}
