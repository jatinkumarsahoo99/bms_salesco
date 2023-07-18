import 'package:get/get.dart';

import '../controllers/same_day_collection_controller.dart';

class SameDayCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SameDayCollectionController>(
      () => SameDayCollectionController(),
    );
  }
}
