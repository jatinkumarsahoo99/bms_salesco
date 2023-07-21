import 'package:get/get.dart';

import '../controllers/geo_program_update_controller.dart';

class GeoProgramUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeoProgramUpdateController>(
      () => GeoProgramUpdateController(),
    );
  }
}
