import 'package:get/get.dart';

import '../controllers/edi_ro_booking_controller.dart';

class EdiRoBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EdiRoBookingController>(
      () => EdiRoBookingController(),
    );
  }
}
