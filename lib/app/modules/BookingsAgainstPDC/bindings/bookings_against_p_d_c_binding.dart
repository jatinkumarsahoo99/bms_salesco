import 'package:get/get.dart';

import '../controllers/bookings_against_p_d_c_controller.dart';

class BookingsAgainstPDCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingsAgainstPDCController>(
      () => BookingsAgainstPDCController(),
    );
  }
}
