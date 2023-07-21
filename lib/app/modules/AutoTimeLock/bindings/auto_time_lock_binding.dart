import 'package:get/get.dart';

import '../controllers/auto_time_lock_controller.dart';

class AutoTimeLockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AutoTimeLockController>(
      () => AutoTimeLockController(),
    );
  }
}
