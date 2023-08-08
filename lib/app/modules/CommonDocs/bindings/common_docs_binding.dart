import 'package:get/get.dart';

import '../controllers/common_docs_controller.dart';

class CommonDocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommonDocsController>(
      () => CommonDocsController(),
    );
  }
}
