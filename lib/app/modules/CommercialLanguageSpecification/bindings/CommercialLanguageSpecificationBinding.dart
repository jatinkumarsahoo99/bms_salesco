import 'package:get/get.dart';

import '../controllers/CommercialLanguageSpecificationController.dart';

class CommercialLanguageSpecificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommercialLanguageSpecificationController>(
      () => CommercialLanguageSpecificationController(),
    );
  }
}
