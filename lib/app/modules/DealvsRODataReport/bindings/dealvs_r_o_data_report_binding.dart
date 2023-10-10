import 'package:get/get.dart';

import '../controllers/dealvs_r_o_data_report_controller.dart';

class DealvsRODataReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealvsRODataReportController>(
      () => DealvsRODataReportController(),
    );
  }
}
