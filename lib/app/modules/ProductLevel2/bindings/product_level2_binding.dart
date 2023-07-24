import 'package:get/get.dart';

import '../controllers/product_level2_controller.dart';

class ProductLevel2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductLevel2Controller>(
      () => ProductLevel2Controller(),
    );
  }
}
