import 'package:get/get.dart';

import '../controllers/rate_cardfrom_deal_workflow_controller.dart';

class RateCardfromDealWorkflowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateCardfromDealWorkflowController>(
      () => RateCardfromDealWorkflowController(),
    );
  }
}
