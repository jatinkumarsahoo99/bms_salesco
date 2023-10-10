import 'package:get/get.dart';

import '../controllers/commercial_tape_listing_controller.dart';

class CommercialTapeListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialTapeListingController>(
      () => CommercialTapeListingController(),
    );
  }
}
