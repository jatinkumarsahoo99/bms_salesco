import 'package:get/get.dart';

import '../controllers/workflow_definition_controller.dart';

class WorkflowDefinitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkflowDefinitionController>(
      () => WorkflowDefinitionController(),
    );
  }
}
