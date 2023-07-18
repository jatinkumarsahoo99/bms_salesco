import 'package:get/get.dart';

import '../controllers/tape_i_d_campaign_controller.dart';

class TapeIDCampaignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TapeIDCampaignController>(
      () => TapeIDCampaignController(),
    );
  }
}
