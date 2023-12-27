import 'package:get/get.dart';

import '../controllers/commercial_master_auto_id_details_controller.dart';

class CommercialMasterAutoIdDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialMasterAutoIdDetailsController>(
      () => CommercialMasterAutoIdDetailsController(),
    );
  }
}
