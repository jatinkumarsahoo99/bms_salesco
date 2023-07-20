import 'package:get/get.dart';

import '../controllers/CommercialCreationAutoController.dart';

class CommercialCreationAutoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialCreationAutoController>(
      () => CommercialCreationAutoController(),
    );
  }
}
