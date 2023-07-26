import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/InputFields/normal_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/design_controller.dart';

class DesignView extends GetView<DesignController> {
  const DesignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DesignView'),
        centerTitle: true,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: context.width),
          ListDropDown(
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
          SizedBox(height: 40),
          NormalTextField(
            controller: TextEditingController(),
            widthRatio: .3,
            label: "Tape ID",
          ),
          SizedBox(height: 40),
          NormalTextField(
            controller: TextEditingController(),
            widthRatio: .3,
            label: "Tape ID",
          ),
          SizedBox(height: 40),
          ListDropDown(
            items: [
              DropDownValue(key: "1", value: "one"),
              DropDownValue(key: "1", value: "one"),
              DropDownValue(key: "1", value: "one"),
              DropDownValue(key: "1", value: "one"),
            ],
            title: "Location",
            onSelect: (DropDownValue? val) {},
          ),
        ],
      ),
    );
  }
}
