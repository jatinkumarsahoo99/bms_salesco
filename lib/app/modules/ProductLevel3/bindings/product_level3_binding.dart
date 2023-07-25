import 'package:get/get.dart';

import '../controllers/product_level3_controller.dart';

class ProductLevel3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductLevel3Controller>(
      () => ProductLevel3Controller(),
    );
  }
}
