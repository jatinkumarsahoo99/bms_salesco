import 'package:get/get.dart';

import '../controllers/deal_reco_summary_controller.dart';

class DealRecoSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealRecoSummaryController>(
      () => DealRecoSummaryController(),
    );
  }
}
