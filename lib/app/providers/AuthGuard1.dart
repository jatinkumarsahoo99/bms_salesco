import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/modules/MakeGoodReport/views/make_good_report_view.dart';
import 'package:bms_salesco/app/modules/CommercialLanguageSpecification/controllers/CommercialLanguageSpecificationController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/AutoTimeLock/views/auto_time_lock_view.dart';
import '../modules/ChangeRONumber/views/change_r_o_number_view.dart';
import '../modules/GeoProgramUpdate/views/geo_program_update_view.dart';
import '../modules/MarkROsFlag/views/mark_r_os_flag_view.dart';
import '../modules/MonthlyReport/views/monthly_report_view.dart';

import '../modules/CommercialCreationAuto/views/CommercialCreationAutoView.dart';
import '../modules/CommercialLanguageSpecification/views/CommercialLanguageSpecificationView.dart';

import '../modules/AsrunDetailsReport/views/asrun_details_report_view.dart';
import '../modules/AuditStatusReport/views/audit_status_report_view.dart';
import '../modules/ChangeRONumber/views/change_r_o_number_view.dart';
import '../modules/DealRecoSummary/views/deal_reco_summary_view.dart';
import '../modules/EDI_Mapping/views/e_d_i_mapping_view.dart';

import '../modules/OnSpotBookingSkyMedia/views/on_spot_booking_sky_media_view.dart';
import '../modules/PeriodicDealUtilisationFormat2/views/periodic_deal_utilisation_format2_view.dart';
import '../modules/RoReceived/views/ro_received_view.dart';
import '../modules/SameDayCollection/views/same_day_collection_view.dart';
import '../modules/TapeIDCampaign/views/tape_i_d_campaign_view.dart';
import '../modules/Update_Executive/views/update_executive_view.dart';
import '../modules/UserGroupsForDealWorkflow/views/user_groups_for_deal_workflow_view.dart';
import '../modules/WorkflowDefinition/views/workflow_definition_view.dart';
import '../routes/app_pages.dart';

class AuthGuard extends StatelessWidget {
  final String childName;

  AuthGuard({required this.childName}) {
    assert(this.childName != null);
  }

  Widget? currentWidget;

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      init: Get.find<MainController>(),
      // init: MainController(),
      initState: (c) {
        // Get.find<MainController>().checkSession2();
        Get.find<MainController>().checkSessionFromParams();
      },
      builder: (controller) {
        if (kDebugMode) {
          print("Login value>>${controller.loginVal.value}");
        }
        if (controller.loginVal.value == 1) {
          switch (childName) {
            case Routes.ASRUN_DETAILS_REPORT:
              currentWidget = AsrunDetailsReportView();
              break;
            case Routes.AUDIT_STATUS_REPORT:
              currentWidget = AuditStatusReportView();
              break;
            case Routes.DEAL_RECO_SUMMARY:
              currentWidget = DealRecoSummaryView();
              break;
            case Routes.CHANGE_R_O_NUMBER:
              currentWidget = const ChangeRONumberView();
              break;
            case Routes.SAME_DAY_COLLECTION:
              currentWidget = const SameDayCollectionView();
              break;
            case Routes.TAPE_I_D_CAMPAIGN:
              currentWidget = const TapeIDCampaignView();
              break;
            case Routes.RO_RECEIVED:
              currentWidget = RoReceivedView();
              break;
            case Routes.MAKE_GOOD_REPORT:
              currentWidget = MakeGoodReportView();
              break;
            case Routes.MARK_R_OS_FLAG:
              currentWidget = MarkROsFlagView();
              break;
            case Routes.AUTO_TIME_LOCK:
              currentWidget = AutoTimeLockView();
              break;
            case Routes.MONTHLY_REPORT:
              currentWidget = MonthlyReportView();
              break;
            case Routes.GEO_PROGRAM_UPDATE:
              currentWidget = GeoProgramUpdateView();
              break;
            case Routes.WORKFLOW_DEFINITION:
              currentWidget = WorkflowDefinitionView();
              break;
            case Routes.ON_SPOT_BOOKING_SKY_MEDIA:
              currentWidget = OnSpotBookingSkyMediaView();
              break;
            case Routes.PERIODIC_DEAL_UTILISATION_FORMAT2:
              currentWidget = PeriodicDealUtilisationFormat2View();
              break;
            case Routes.UPDATE_EXECUTIVE:
              currentWidget = UpdateExecutiveView();
              break;
            case Routes.USER_GROUPS_FOR_DEAL_WORKFLOW:
              currentWidget = UserGroupsForDealWorkflowView();
              break;
            case Routes.E_D_I_MAPPING:
              currentWidget = EDIMappingView();
              break;
            case Routes.COMMERCIAL_CREATION_AUTO:
              currentWidget = CommercialCreationAutoView();
              break;
            case Routes.COMMERCIAL_LANGUAGE_SPECIFICATION:
              currentWidget = CommercialLanguageSpecificationView();
              break;
            default:
              currentWidget = const NoDataFoundPage();
          }
        } else if (controller.loginVal.value == 2) {
          currentWidget = const NoDataFoundPage();
        } else {
          currentWidget = const LoadingScreen();
        }
        return currentWidget!;
      },
    );
  }
}
