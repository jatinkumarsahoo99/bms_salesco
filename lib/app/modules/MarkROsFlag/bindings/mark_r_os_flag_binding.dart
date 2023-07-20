import 'package:get/get.dart';

import '../controllers/mark_r_os_flag_controller.dart';

class MarkROsFlagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarkROsFlagController>(
      () => MarkROsFlagController(),
    );
  }
}
