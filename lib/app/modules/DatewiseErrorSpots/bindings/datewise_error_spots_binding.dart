import 'package:get/get.dart';

import '../controllers/datewise_error_spots_controller.dart';

class DatewiseErrorSpotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatewiseErrorSpotsController>(
      () => DatewiseErrorSpotsController(),
    );
  }
}
