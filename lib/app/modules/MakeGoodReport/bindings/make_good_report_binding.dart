import 'package:get/get.dart';

import '../controllers/make_good_report_controller.dart';

class MakeGoodReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeGoodReportController>(
      () => MakeGoodReportController(),
    );
  }
}
