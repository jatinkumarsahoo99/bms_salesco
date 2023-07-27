import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../modules/AmagiSpotPlanning/bindings/amagi_spot_planning_binding.dart';
import '../modules/AmagiSpotPlanning/views/amagi_spot_planning_view.dart';
import '../modules/AmagiSpotsReplacement/bindings/amagi_spots_replacement_binding.dart';
import '../modules/AmagiSpotsReplacement/views/amagi_spots_replacement_view.dart';
import '../modules/AmagiStatusReport/bindings/amagi_status_report_binding.dart';
import '../modules/AmagiStatusReport/views/amagi_status_report_view.dart';
import '../modules/AsrunDetailsReport/bindings/asrun_details_report_binding.dart';
import '../modules/AsrunDetailsReport/bindings/asrun_details_report_binding.dart';
import '../modules/AuditStatusReport/bindings/audit_status_report_binding.dart';
import '../modules/AuditStatusReport/bindings/audit_status_report_binding.dart';
import '../modules/AutoTimeLock/bindings/auto_time_lock_binding.dart';
import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';
import '../modules/ChangeRONumber/bindings/change_r_o_number_binding.dart';
import '../modules/CommercialCreationAutoDetails/bindings/commercial_creation_auto_details_binding.dart';
import '../modules/CommercialCreationAutoDetails/views/CommercialCreationAutoDetailsView.dart';
import '../modules/DealRecoSummary/bindings/deal_reco_summary_binding.dart';
import '../modules/DealRecoSummary/bindings/deal_reco_summary_binding.dart';
import '../modules/EDI_Mapping/bindings/e_d_i_mapping_binding.dart';
import '../modules/EDI_Mapping/bindings/e_d_i_mapping_binding.dart';
import '../modules/EDI_Mapping/views/e_d_i_mapping_view.dart';
import '../modules/EdiRoBooking/bindings/edi_ro_booking_binding.dart';
import '../modules/EdiRoBooking/bindings/edi_ro_booking_binding.dart';
import '../modules/EdiRoBooking/views/edi_ro_booking_view.dart';
import '../modules/EdiRoBooking/views/edi_ro_booking_view.dart';
import '../modules/GeoProgramUpdate/bindings/geo_program_update_binding.dart';
import '../modules/GeoProgramUpdate/views/geo_program_update_view.dart';
import '../modules/InternationalSalesReport/bindings/international_sales_report_binding.dart';
import '../modules/InternationalSalesReport/views/international_sales_report_view.dart';
import '../modules/MakeGoodReport/bindings/make_good_report_binding.dart';
import '../modules/MarkROsFlag/bindings/mark_r_os_flag_binding.dart';
import '../modules/MonthlyReport/bindings/monthly_report_binding.dart';
import '../modules/MonthlyReport/views/monthly_report_view.dart';
import '../modules/NewShortContentForm/bindings/new_short_content_form_binding.dart';
import '../modules/NewShortContentForm/views/new_short_content_form_view.dart';
import '../modules/OnSpotBookingSkyMedia/bindings/on_spot_booking_sky_media_binding.dart';
import '../modules/PeriodicDealUtilisationFormat2/bindings/periodic_deal_utilisation_format2_binding.dart';
import '../modules/ProductLevel1/bindings/product_level1_binding.dart';
import '../modules/ProductLevel1/views/product_level1_view.dart';
import '../modules/ProductLevel2/bindings/product_level2_binding.dart';
import '../modules/ProductLevel2/views/product_level2_view.dart';
import '../modules/ProductLevel3/bindings/product_level3_binding.dart';
import '../modules/ProductLevel3/views/product_level3_view.dart';
import '../modules/ProductMaster/bindings/product_master_binding.dart';
import '../modules/ProductMaster/views/product_master_view.dart';
import '../modules/RateCardfromDealWorkflow/bindings/rate_cardfrom_deal_workflow_binding.dart';
import '../modules/RateCardfromDealWorkflow/views/rate_cardfrom_deal_workflow_view.dart';
import '../modules/RescheduleImport/bindings/reschedule_import_binding.dart';
import '../modules/RescheduleImport/views/reschedule_import_view.dart';
import '../modules/RoReceived/bindings/ro_received_binding.dart';
import '../modules/SameDayCollection/bindings/same_day_collection_binding.dart';
import '../modules/TapeIDCampaign/bindings/tape_i_d_campaign_binding.dart';
import '../modules/Update_Executive/bindings/update_executive_binding.dart';
import '../modules/UserGroupsForDealWorkflow/bindings/user_groups_for_deal_workflow_binding.dart';
import '../modules/ViewOldDeal/bindings/view_old_deal_binding.dart';
import '../modules/ViewOldDeal/views/view_old_deal_view.dart';
import '../modules/WorkflowDefinition/bindings/workflow_definition_binding.dart';
import '../modules/ZoneWiseInventoryUtilization/bindings/zone_wise_inventory_utilization_binding.dart';
import '../modules/ZoneWiseInventoryUtilization/views/zone_wise_inventory_utilization_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : Routes.COMMERCIAL_CREATION_AUTO +
          "?personalNo=kW5Bkf17%2FS5YF7ML28FmVg%3D%3D&loginCode=1BWIoBKeDl7qDSAAhxvXsQ%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D";
  static final routes = [
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
      page: () => AuthGuard(childName: _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION),
    ),
    GetPage(
      name: _Paths.ON_SPOT_BOOKING_SKY_MEDIA,
      page: () => AuthGuard(childName: _Paths.ON_SPOT_BOOKING_SKY_MEDIA),
      // OnSpotBookingSkyMediaView(),
      binding: OnSpotBookingSkyMediaBinding(),
    ),
    GetPage(
      name: _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2,
      page: () => AuthGuard(childName: _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2),
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
    GetPage(
      name: _Paths.NEW_SHORT_CONTENT_FORM,
      page: () => const NewShortContentFormView(),
      binding: NewShortContentFormBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_OLD_DEAL,
      page: () => const ViewOldDealView(),
      binding: ViewOldDealBinding(),
    ),
    GetPage(
      name: _Paths.RATE_CARDFROM_DEAL_WORKFLOW,
      page: () => AuthGuard(childName: _Paths.RATE_CARDFROM_DEAL_WORKFLOW),
      // page: () => const RateCardfromDealWorkflowView(),
      binding: RateCardfromDealWorkflowBinding(),
    ),
    GetPage(
      name: _Paths.ZONE_WISE_INVENTORY_UTILIZATION,
      // page: () => const ZoneWiseInventoryUtilizationView(),
      page: () => AuthGuard(childName: _Paths.ZONE_WISE_INVENTORY_UTILIZATION),
      binding: ZoneWiseInventoryUtilizationBinding(),
    ),
    GetPage(
      name: _Paths.RESCHEDULE_IMPORT,
      page: () => AuthGuard(childName: _Paths.RESCHEDULE_IMPORT),
      // page: () => const RescheduleImportView(),
      binding: RescheduleImportBinding(),
    ),
    GetPage(
      name: _Paths.AMAGI_SPOT_PLANNING,
      page: () => AuthGuard(childName: _Paths.AMAGI_SPOT_PLANNING),
      // AmagiSpotPlanningView(),
      binding: AmagiSpotPlanningBinding(),
    ),
    GetPage(
      name: _Paths.AMAGI_SPOTS_REPLACEMENT,
      page: () => AuthGuard(childName: _Paths.AMAGI_SPOTS_REPLACEMENT),
      // AmagiSpotsReplacementView(),
      binding: AmagiSpotsReplacementBinding(),
    ),
    GetPage(
      name: _Paths.AMAGI_STATUS_REPORT,
      page: () => AuthGuard(childName: _Paths.AMAGI_STATUS_REPORT),
      // AmagiStatusReportView(),
      binding: AmagiStatusReportBinding(),
    ),
    GetPage(
      name: _Paths.INTERNATIONAL_SALES_REPORT,
      page: () => AuthGuard(childName: _Paths.INTERNATIONAL_SALES_REPORT),
      // InternationalSalesReportView(),
      binding: InternationalSalesReportBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LEVEL1,
      page: () => AuthGuard(childName: _Paths.PRODUCT_LEVEL1),
      // ProductLevel1View(),
      binding: ProductLevel1Binding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LEVEL2,
      page: () => AuthGuard(childName: _Paths.PRODUCT_LEVEL2),
      // ProductLevel2View(),
      binding: ProductLevel2Binding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LEVEL3,
      page: () => AuthGuard(childName: _Paths.PRODUCT_LEVEL3),
      // ProductLevel3View(),
      binding: ProductLevel3Binding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_MASTER,
      page: () => AuthGuard(childName: _Paths.PRODUCT_MASTER),
      // ProductMasterView(),
      binding: ProductMasterBinding(),
    ),
    GetPage(
      name: _Paths.COMMERCIAL_CREATION_AUTO_DETAILS,
      page: () => AuthGuard(childName: _Paths.COMMERCIAL_CREATION_AUTO_DETAILS),
    ),
  ];
}
