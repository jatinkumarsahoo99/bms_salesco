import 'package:bms_salesco/app/providers/AuthGuard1.dart';
import 'package:get/get.dart';

import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/SameDayCollection/bindings/same_day_collection_binding.dart';
import '../modules/TapeIDCampaign/bindings/tape_i_d_campaign_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHANGE_R_O_NUMBER +
      "?personalNo=kW5Bkf17%2FS5YF7ML28FmVg%3D%3D&loginCode=1BWIoBKeDl7qDSAAhxvXsQ%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D";

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_R_O_NUMBER,
      page: () => AuthGuard(childName: _Paths.CHANGE_R_O_NUMBER),
      binding: ChangeRONumberBinding(),
    ),
    GetPage(
      name: _Paths.SAME_DAY_COLLECTION,
      page: () => AuthGuard(childName: _Paths.SAME_DAY_COLLECTION),
      binding: SameDayCollectionBinding(),
    ),
    GetPage(
      name: _Paths.TAPE_I_D_CAMPAIGN,
      page: () => AuthGuard(childName: _Paths.TAPE_I_D_CAMPAIGN),
      binding: TapeIDCampaignBinding(),
    ),
    GetPage(
      name: _Paths.RO_RECEIVED,
      page: () => AuthGuard(childName: _Paths.RO_RECEIVED),
      binding: RoReceivedBinding(),
    ),
  ];
}
