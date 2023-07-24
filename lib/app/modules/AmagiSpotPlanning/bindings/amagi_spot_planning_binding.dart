import 'package:get/get.dart';

import '../controllers/amagi_spot_planning_controller.dart';

class AmagiSpotPlanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmagiSpotPlanningController>(
      () => AmagiSpotPlanningController(),
    );
  }
}
