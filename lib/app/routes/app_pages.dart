import 'package:get/get.dart';

import '../modules/AutoTimeLock/bindings/auto_time_lock_binding.dart';
import '../modules/AutoTimeLock/views/auto_time_lock_view.dart';
import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';
import '../modules/GeoProgramUpdate/bindings/geo_program_update_binding.dart';
import '../modules/GeoProgramUpdate/views/geo_program_update_view.dart';
import '../modules/MakeGoodReport/bindings/make_good_report_binding.dart';
import '../modules/MakeGoodReport/views/make_good_report_view.dart';
import '../modules/MarkROsFlag/bindings/mark_r_os_flag_binding.dart';
import '../modules/MarkROsFlag/views/mark_r_os_flag_view.dart';
import '../modules/MonthlyReport/bindings/monthly_report_binding.dart';
import '../modules/MonthlyReport/views/monthly_report_view.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/SameDayCollection/bindings/same_day_collection_binding.dart';
import '../modules/TapeIDCampaign/bindings/tape_i_d_campaign_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.GEO_PROGRAM_UPDATE +
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
    GetPage(
      name: _Paths.MAKE_GOOD_REPORT,
      page: () => AuthGuard(childName: _Paths.MAKE_GOOD_REPORT),
      binding: MakeGoodReportBinding(),
    ),
    GetPage(
      name: _Paths.MARK_R_OS_FLAG,
      page: () => AuthGuard(childName: _Paths.MARK_R_OS_FLAG),
      binding: MarkROsFlagBinding(),
    ),
    GetPage(
      name: _Paths.AUTO_TIME_LOCK,
      page: () => AuthGuard(childName: _Paths.AUTO_TIME_LOCK),
      binding: AutoTimeLockBinding(),
    ),
    GetPage(
      name: _Paths.MONTHLY_REPORT,
      page: () => AuthGuard(childName: _Paths.MONTHLY_REPORT),
      binding: MonthlyReportBinding(),
    ),
    GetPage(
      name: _Paths.GEO_PROGRAM_UPDATE,
      page: () => AuthGuard(childName: _Paths.GEO_PROGRAM_UPDATE),
      binding: GeoProgramUpdateBinding(),
    ),
  ];
}
