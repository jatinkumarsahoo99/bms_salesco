import 'package:get/get.dart';

import '../controllers/product_master_controller.dart';

class ProductMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductMasterController>(
      () => ProductMasterController(),
    );
  }
}
