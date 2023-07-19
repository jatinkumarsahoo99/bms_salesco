import 'package:get/get.dart';

import '../modules/EdiRoBooking/bindings/edi_ro_booking_binding.dart';
import '../modules/EdiRoBooking/views/edi_ro_booking_view.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/RoReceived/views/ro_received_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RO_RECEIVED +
      "?personalNo=hWlrtkk6LCUUIRgmutvmzg%3D%3D&loginCode=gsS2oEkuYKzI9aXanDqobQ%3D%3D&formName=06R0x6Pi27B5o9UTAjZRsrivnAPUt3NNVHUa2XIWU%2Fs%3D";

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RO_RECEIVED,
      page: () => AuthGuard(childName: _Paths.RO_RECEIVED),
      binding: RoReceivedBinding(),
    ),
    GetPage(
      name: _Paths.EDI_RO_BOOKING,
      page: () => const EdiRoBookingView(),
      binding: EdiRoBookingBinding(),
    ),
  ];
}
