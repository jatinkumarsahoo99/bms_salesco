import 'package:get/get.dart';

import '../controllers/booking_status_report_controller.dart';

class BookingStatusReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingStatusReportController>(
      () => BookingStatusReportController(),
    );
  }
}
