import 'package:get/get.dart';

import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class SameDayCollectionController extends GetxController {
  //TODO: Implement SameDayCollectionController

  final count = 0.obs;
  List<PermissionModel>? formPermissions;
  var dataTableList = [].obs;
  @override
  void onInit() {
    formPermissions = Utils.fetchPermissions1(Routes.SAME_DAY_COLLECTION.replaceAll("/", ""));
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
