import 'package:get/get.dart';

import '../controllers/asrun_details_report_controller.dart';

class AsrunDetailsReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AsrunDetailsReportController>(
      () => AsrunDetailsReportController(),
    );
  }
}
