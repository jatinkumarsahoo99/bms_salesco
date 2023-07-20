import 'package:get/get.dart';

import '../modules/EdiRoBooking/bindings/edi_ro_booking_binding.dart';
import '../modules/EdiRoBooking/views/edi_ro_booking_view.dart';
import '../modules/Asrun_Details_Report/bindings/asrun_details_report_binding.dart';
import '../modules/Asrun_Details_Report/views/asrun_details_report_view.dart';
import '../modules/Audit_Status_Report/bindings/audit_status_report_binding.dart';
import '../modules/Audit_Status_Report/views/audit_status_report_view.dart';
import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';
import '../modules/Deal_Reco_Summary/bindings/deal_reco_summary_binding.dart';
import '../modules/Deal_Reco_Summary/views/deal_reco_summary_view.dart';
import '../modules/EDI_Mapping/bindings/e_d_i_mapping_binding.dart';
import '../modules/EDI_Mapping/views/e_d_i_mapping_view.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/SameDayCollection/bindings/same_day_collection_binding.dart';
import '../modules/TapeIDCampaign/bindings/tape_i_d_campaign_binding.dart';
import '../modules/Workflow_Definition/bindings/workflow_definition_binding.dart';
import '../modules/Workflow_Definition/views/workflow_definition_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.EDI_RO_BOOKING +
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
      name: _Paths.EDI_RO_BOOKING,
      page: () => const EdiRoBookingView(),
      binding: EdiRoBookingBinding(),
    ),
    GetPage(
      name: _Paths.WORKFLOW_DEFINITION,
      page: () => AuthGuard(childName: _Paths.WORKFLOW_DEFINITION),
      // WorkflowDefinitionView(),
      binding: WorkflowDefinitionBinding(),
    ),
    GetPage(
      name: _Paths.E_D_I_MAPPING,
      page: () => AuthGuard(childName: _Paths.E_D_I_MAPPING),
      // EDIMappingView(),
      binding: EDIMappingBinding(),
    ),
  ];
}
