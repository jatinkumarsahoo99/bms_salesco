import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/modules/MakeGoodReport/views/make_good_report_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/AutoTimeLock/views/auto_time_lock_view.dart';
import '../modules/ChangeRONumber/views/change_r_o_number_view.dart';
import '../modules/MarkROsFlag/views/mark_r_os_flag_view.dart';
import '../modules/RoReceived/views/ro_received_view.dart';
import '../modules/SameDayCollection/views/same_day_collection_view.dart';
import '../modules/TapeIDCampaign/views/tape_i_d_campaign_view.dart';
import '../modules/home/views/home_view.dart';
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
            case Routes.HOME:
              currentWidget = HomeView();
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
