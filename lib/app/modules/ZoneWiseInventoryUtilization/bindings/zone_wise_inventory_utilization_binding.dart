import 'package:get/get.dart';

import '../controllers/zone_wise_inventory_utilization_controller.dart';

class ZoneWiseInventoryUtilizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoneWiseInventoryUtilizationController>(
      () => ZoneWiseInventoryUtilizationController(),
    );
  }
}
