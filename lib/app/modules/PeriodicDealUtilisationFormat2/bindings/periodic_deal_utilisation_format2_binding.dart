import 'package:get/get.dart';

import '../controllers/periodic_deal_utilisation_format2_controller.dart';

class PeriodicDealUtilisationFormat2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeriodicDealUtilisationFormat2Controller>(
      () => PeriodicDealUtilisationFormat2Controller(),
    );
  }
}
