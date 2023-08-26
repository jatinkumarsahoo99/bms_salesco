import 'package:get/get.dart';

import '../controllers/one_spot_booking_sky_media_controller.dart';

class OneSpotBookingSkyMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OneSpotBookingSkyMediaController>(
      () => OneSpotBookingSkyMediaController(),
    );
  }
}
