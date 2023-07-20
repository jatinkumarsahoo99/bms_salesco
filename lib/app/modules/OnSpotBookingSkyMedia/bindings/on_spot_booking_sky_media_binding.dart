import 'package:get/get.dart';

import '../controllers/on_spot_booking_sky_media_controller.dart';

class OnSpotBookingSkyMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnSpotBookingSkyMediaController>(
      () => OnSpotBookingSkyMediaController(),
    );
  }
}
