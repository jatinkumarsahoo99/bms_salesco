import 'package:get/get.dart';

import '../modules/Asrun_Details_Report/bindings/asrun_details_report_binding.dart';
import '../modules/Asrun_Details_Report/views/asrun_details_report_view.dart';
import '../modules/Audit_Status_Report/bindings/audit_status_report_binding.dart';
import '../modules/Audit_Status_Report/views/audit_status_report_view.dart';
import '../modules/Deal_Reco_Summary/bindings/deal_reco_summary_binding.dart';
import '../modules/Deal_Reco_Summary/views/deal_reco_summary_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ASRUN_DETAILS_REPORT +
      "?personalNo=kW5Bkf17%2FS5YF7ML28FmVg%3D%3D&loginCode=1BWIoBKeDl7qDSAAhxvXsQ%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D";
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ASRUN_DETAILS_REPORT,
      page: () =>
          // AsrunDetailsReportView(),
          AuthGuard(childName: _Paths.ASRUN_DETAILS_REPORT),
      binding: AsrunDetailsReportBinding(),
    ),
    GetPage(
      name: _Paths.AUDIT_STATUS_REPORT,
      page: () => AuthGuard(childName: _Paths.AUDIT_STATUS_REPORT),
      // AuditStatusReportView(),
      binding: AuditStatusReportBinding(),
    ),
    GetPage(
      name: _Paths.DEAL_RECO_SUMMARY,
      page: () => AuthGuard(childName: _Paths.DEAL_RECO_SUMMARY),
          // DealRecoSummaryView(),
      binding: DealRecoSummaryBinding(),
    ),
  ];
}
