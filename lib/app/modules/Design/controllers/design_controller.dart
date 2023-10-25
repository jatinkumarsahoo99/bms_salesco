import 'package:get/get.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../data/DropDownValue.dart';

class DesignController extends GetxController {
  //TODO: Implement DesignController

  final count = 0.obs;
  @override
  void onInit() {
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

  // var listCheckBox = [
  //   MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee-Bihar-HD"), false),
  //   MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee TV"), true),
  //   MultiCheckBoxModel(DropDownValue(key: "1", value: "Zing"), true),
  //   MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Marathi"), true),
  //   MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Bojpuri"), true),
  // ];

  // saveData() {
  //   List<DropDownValue> selectValue = [];
  //   for (var element in listCheckBox) {
  //     if (element.isSelected ?? false) {
  //       selectValue.add(element.val!);
  //     }
  //   }
  //   for (var element in selectValue) {
  //     print("Value ${element.value} Key ${element.key}");
  //   }
  // }
}
