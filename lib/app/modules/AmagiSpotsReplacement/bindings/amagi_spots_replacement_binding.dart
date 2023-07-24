import 'package:get/get.dart';

import '../controllers/amagi_spots_replacement_controller.dart';

class AmagiSpotsReplacementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmagiSpotsReplacementController>(
      () => AmagiSpotsReplacementController(),
    );
  }
}
