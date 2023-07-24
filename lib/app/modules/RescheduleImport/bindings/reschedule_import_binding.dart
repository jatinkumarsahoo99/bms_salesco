import 'package:get/get.dart';

import '../controllers/reschedule_import_controller.dart';

class RescheduleImportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RescheduleImportController>(
      () => RescheduleImportController(),
    );
  }
}
