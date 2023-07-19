import 'package:get/get.dart';

import '../controllers/e_d_i_mapping_controller.dart';

class EDIMappingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EDIMappingController>(
      () => EDIMappingController(),
    );
  }
}
