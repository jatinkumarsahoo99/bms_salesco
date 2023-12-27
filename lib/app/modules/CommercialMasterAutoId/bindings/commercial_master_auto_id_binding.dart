import 'package:get/get.dart';

import '../controllers/commercial_master_auto_id_controller.dart';

class CommercialMasterAutoIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialMasterAutoIdController>(
      () => CommercialMasterAutoIdController(),
    );
  }
}
