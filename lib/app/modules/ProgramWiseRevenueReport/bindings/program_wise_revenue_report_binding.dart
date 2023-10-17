import 'package:get/get.dart';

import '../controllers/program_wise_revenue_report_controller.dart';

class ProgramWiseRevenueReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramWiseRevenueReportController>(
      () => ProgramWiseRevenueReportController(),
    );
  }
}
