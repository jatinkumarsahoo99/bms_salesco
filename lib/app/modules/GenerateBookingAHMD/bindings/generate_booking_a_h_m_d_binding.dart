import 'package:get/get.dart';

import '../controllers/GenerateBookingAHMDController.dart';

class GenerateBookingAHMDBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateBookingAHMDController>(
      () => GenerateBookingAHMDController(),
    );
  }
}
