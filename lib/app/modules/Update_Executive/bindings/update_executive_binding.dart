import 'package:get/get.dart';

import '../controllers/update_executive_controller.dart';

class UpdateExecutiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateExecutiveController>(
      () => UpdateExecutiveController(),
    );
  }
}
