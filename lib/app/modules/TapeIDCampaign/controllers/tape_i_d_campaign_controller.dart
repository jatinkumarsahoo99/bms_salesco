import 'package:get/get.dart';

import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class TapeIDCampaignController extends GetxController {
  //TODO: Implement TapeIDCampaignController

  final count = 0.obs;
  List<PermissionModel>? formPermissions;

  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.TAPE_I_D_CAMPAIGN.replaceAll("/", ""));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  formHandler(btn) {}
}
