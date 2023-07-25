import 'package:get/get.dart';

import '../controllers/CommercialCreationAutoDetailsController.dart';

class CommercialCreationAutoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialCreationAutoDetailsController>(
      () => CommercialCreationAutoDetailsController(),
    );
  }
}
