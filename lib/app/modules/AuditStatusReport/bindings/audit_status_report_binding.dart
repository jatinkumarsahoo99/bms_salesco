import 'package:get/get.dart';

import '../controllers/audit_status_report_controller.dart';

class AuditStatusReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuditStatusReportController>(
      () => AuditStatusReportController(),
    );
  }
}
