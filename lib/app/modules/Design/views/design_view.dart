import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/InputFields/normal_text_field.dart';
import 'package:bms_salesco/widgets/TabBar/app_tap_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          children: [
            AppTabBar(
              tabsTitle: ['one', 'two'],
              selectedTab: "two",
              onSelect: (selectedTab) {},
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                ListDropDown(
                  focusNode: FocusNode(),
                  items: [
                    DropDownValue(key: "1", value: "one1"),
                    DropDownValue(key: "1", value: "one2"),
                    DropDownValue(key: "1", value: "one3"),
                    DropDownValue(key: "1", value: "one4"),
                  ],
                  title: "Location",
                  autoFocus: true,
                  onSelect: (DropDownValue? val) {},
                ),
                ListDropDown(
                  focusNode: FocusNode(),
                  items: [
                    DropDownValue(key: "1", value: "one1"),
                    DropDownValue(key: "1", value: "one2"),
                    DropDownValue(key: "1", value: "one3"),
                    DropDownValue(key: "1", value: "one4"),
                  ],
                  title: "Channel",
                  onSelect: (DropDownValue? val) {},
                  iconData: Icons.tv_rounded,
                ),
                NormalTextField(
                  controller: TextEditingController(),
                  widthRatio: .3,
                  label: "Tape ID",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
