import 'package:get/get.dart';

import '../controllers/user_groups_for_deal_workflow_controller.dart';

class UserGroupsForDealWorkflowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGroupsForDealWorkflowController>(
      () => UserGroupsForDealWorkflowController(),
    );
  }
}
