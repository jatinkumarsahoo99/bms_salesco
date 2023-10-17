import 'package:get/get.dart';

import '../controllers/relese_order_reschedule_tape_i_d_controller.dart';

class ReleseOrderRescheduleTapeIDBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReleseOrderRescheduleTapeIDController>(
      () => ReleseOrderRescheduleTapeIDController(),
    );
  }
}
