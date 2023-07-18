import 'package:get/get.dart';

import '../controllers/ro_received_controller.dart';

class RoReceivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoReceivedController>(
      () => RoReceivedController(),
    );
  }
}
