import 'package:get/get.dart';

import '../controllers/view_old_deal_controller.dart';

class ViewOldDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewOldDealController>(
      () => ViewOldDealController(),
    );
  }
}
