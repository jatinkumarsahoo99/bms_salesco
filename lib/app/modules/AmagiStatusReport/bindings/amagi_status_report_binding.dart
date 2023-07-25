import 'package:get/get.dart';

import '../controllers/amagi_status_report_controller.dart';

class AmagiStatusReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmagiStatusReportController>(
      () => AmagiStatusReportController(),
    );
  }
}
