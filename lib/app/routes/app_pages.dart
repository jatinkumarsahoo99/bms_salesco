import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';

import '../modules/EdiRoBooking/bindings/edi_ro_booking_binding.dart';
import '../modules/EdiRoBooking/views/edi_ro_booking_view.dart';
import 'package:get/get.dart';

import '../modules/AsrunDetailsReport/bindings/asrun_details_report_binding.dart';
import '../modules/AuditStatusReport/bindings/audit_status_report_binding.dart';
import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';

import '../modules/DealRecoSummary/bindings/deal_reco_summary_binding.dart';

import '../modules/EDI_Mapping/bindings/e_d_i_mapping_binding.dart';
import '../modules/EDI_Mapping/views/e_d_i_mapping_view.dart';
import '../modules/OnSpotBookingSkyMedia/bindings/on_spot_booking_sky_media_binding.dart';
import '../modules/PeriodicDealUtilisationFormat2/bindings/periodic_deal_utilisation_format2_binding.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/SameDayCollection/bindings/same_day_collection_binding.dart';
import '../modules/TapeIDCampaign/bindings/tape_i_d_campaign_binding.dart';

import '../modules/Update_Executive/bindings/update_executive_binding.dart';
import '../modules/Update_Executive/views/update_executive_view.dart';
import '../modules/UserGroupsForDealWorkflow/bindings/user_groups_for_deal_workflow_binding.dart';
import '../modules/WorkflowDefinition/bindings/workflow_definition_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : Routes.EDI_RO_BOOKING +
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
    GetPage(
      name: _Paths.COMMERCIAL_CREATION_AUTO,
      page: () => AuthGuard(childName: _Paths.COMMERCIAL_CREATION_AUTO),
    ),
    GetPage(
      name: _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION,
      page: () =>
          AuthGuard(childName: _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION),
    ),
    GetPage(
      name: _Paths.ON_SPOT_BOOKING_SKY_MEDIA,
      page: () => AuthGuard(childName: _Paths.ON_SPOT_BOOKING_SKY_MEDIA),
      // OnSpotBookingSkyMediaView(),
      binding: OnSpotBookingSkyMediaBinding(),
    ),
    GetPage(
      name: _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2,
      page: () =>
          AuthGuard(childName: _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2),
      // PeriodicDealUtilisationFormat2View(),
      binding: PeriodicDealUtilisationFormat2Binding(),
    ),
    GetPage(
      name: _Paths.UPDATE_EXECUTIVE,
      page: () => AuthGuard(childName: _Paths.UPDATE_EXECUTIVE),
      // UpdateExecutiveView(),
      binding: UpdateExecutiveBinding(),
    ),
    GetPage(
      name: _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW,
      page: () => AuthGuard(childName: _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW),
      // UserGroupsForDealWorkflowView(),
      binding: UserGroupsForDealWorkflowBinding(),
    ),
  ];
}
