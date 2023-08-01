import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_salesco/widgets/DataGrid/app_data_grid_widget.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/InputFields/normal_text_field.dart';
import 'package:bms_salesco/widgets/TabBar/app_tap_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/DropDowns/list_check_box_drop_down.dart';
import '../../../../widgets/Radio/multi_radio_widget.dart';
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
                MultiAppRadio(items: ['items1', 'items2', 'items3'], groupValue: 'items1'),
                // ClipPath(
                //   child: Container(
                //     width: 200,
                //     height: 200,
                //     color: Colors.red,
                //   ),
                //   clipper: CustomClipPath(),
                // ),
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
              child: AppDataGridWidget(
                singleCheckBoxColumnName: ['locationname'],
                editingColumnName: ['bookingnumber'],
                list: const [
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                  },
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                  },
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                  },
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                    "clientname": "NESTLE INDIA LTD (DEL)",
                    "brandname": "NESTLE KITKAT",
                    "scheduledate": "2023-06-28T00:00:00",
                  },
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                  },
                  {
                    "locationname": "ASIA",
                    "channelname": "ZEE TV",
                    "bookingnumber": "23061444N",
                    "bookingReferenceNumber": "Bs Sch on Mail 27th June Chtali",
                    "bookingdetailcode": 1,
                    "bookingDate": "2023-06-28T00:00:00",
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    // path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
