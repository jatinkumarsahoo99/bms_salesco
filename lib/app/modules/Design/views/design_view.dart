import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/InputFields/normal_text_field.dart';
import 'package:bms_salesco/widgets/TabBar/app_tap_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/DropDowns/list_check_box_drop_down.dart';
import '../controllers/design_controller.dart';

class DesignView extends GetView<DesignController> {
  const DesignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('DesignView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 10,
              spacing: 20,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                ListDropDown(
                  focusNode: FocusNode(),
                  items: [
                    DropDownValue(key: "1", value: "Asia"),
                    DropDownValue(key: "1", value: "Africa"),
                    DropDownValue(key: "1", value: "International"),
                  ],
                  title: "Location",
                  autoFocus: true,
                  widthRatio: .15,
                  onSelect: (DropDownValue? val) {},
                ),
                ListDropDownCheckBox(
                  focusNode: FocusNode(),
                  items: [
                    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee-Bihar-HD"), false),
                    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee TV"), true),
                    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zing"), true),
                    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Marathi"), true),
                    MultiCheckBoxModel(DropDownValue(key: "1", value: "Zee Bojpuri"), true),
                  ],
                  title: "Multi Channel",
                  onSelect: (DropDownValue? val) {},
                  iconData: Icons.tv_rounded,
                  widthRatio: .15,
                ),
                NormalTextField(
                  controller: TextEditingController(),
                  widthRatio: .15,
                  label: "Tape ID",
                ),
              ],
            ),
            SizedBox(height: 10),
            AppTabBar(
              tabsTitle: ['First Tab', 'Second Tab'],
              selectedTab: "First Tab",
              onSelect: (selectedTab) {},
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
