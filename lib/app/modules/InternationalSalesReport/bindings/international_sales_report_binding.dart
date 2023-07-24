import 'package:get/get.dart';

import '../controllers/international_sales_report_controller.dart';

class InternationalSalesReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternationalSalesReportController>(
      () => InternationalSalesReportController(),
    );
  }
}
