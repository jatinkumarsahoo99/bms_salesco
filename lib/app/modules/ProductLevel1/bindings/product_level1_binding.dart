import 'package:get/get.dart';

import '../controllers/product_level1_controller.dart';

class ProductLevel1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductLevel1Controller>(
      () => ProductLevel1Controller(),
    );
  }
}
