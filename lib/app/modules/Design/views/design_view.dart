import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ColorData.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:bms_salesco/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_salesco/widgets/DropDowns/list_drop_down.dart';
import 'package:bms_salesco/widgets/InputFields/normal_text_field.dart';
import 'package:bms_salesco/widgets/TabBar/app_tap_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/DataGrid/app_data_grid_widget.dart';
import '../../../../widgets/DropDowns/list_check_box_drop_down.dart';
import '../../../../widgets/Radio/multi_radio_widget.dart';
import '../controllers/design_controller.dart';

class DesignView extends GetView<DesignController> {
  const DesignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * .25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeDefine2.componentborderRadius),
            bottomRight: Radius.circular(SizeDefine2.componentborderRadius),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorData.primary,
                  borderRadius: BorderRadius.only(
                    topRight:
                        Radius.circular(SizeDefine2.componentborderRadius),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text(
                        'Scheduling',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // backgroundColor: ColorData.bgComponent,
                      // collapsedBackgroundColor: ColorData.bgComponent,
                      leading: Icon(Icons.trending_up_sharp),
                      children: [
                        Text('data1'),
                        Text('data1'),
                        Text('data1'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: InkWell(
                child: Ink(
                  width: double.infinity,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorData.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Colors.white, size: 14),
                      const SizedBox(width: 15),
                      Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: SizeDefine2.componentTitle + 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  onChanged: (index, selectValue) {
                    print("index=> $index");
                    // controller.listCheckBox[index].isSelected = selectValue;
                    // controller.saveData();
                  },
                  focusNode: FocusNode(),
                  items: [
                    // MultiCheckBoxModel(
                    //     DropDownValue(key: "1", value: "Zee-Bihar-HD"), false),
                    // MultiCheckBoxModel(
                    //     DropDownValue(key: "1", value: "Zee TV"), true),
                    // MultiCheckBoxModel(
                    //     DropDownValue(key: "1", value: "Zing"), true),
                    // MultiCheckBoxModel(
                    //     DropDownValue(key: "1", value: "Zee Marathi"), true),
                    // MultiCheckBoxModel(
                    //     DropDownValue(key: "1", value: "Zee Bojpuri"), true),
                  ],
                  title: "Multi Channel",
                  onSelect: (DropDownValue? val) {
                    print(val!.value);
                  },
                  iconData: Icons.tv_rounded,
                  widthRatio: .15,
                ),
                NormalTextField(
                  controller: TextEditingController(),
                  widthRatio: .15,
                  label: "Tape ID",
                ),
                MultiAppRadio(
                    items: ['items1', 'items2', 'items3'],
                    groupValue: 'items1'),
                // AppSwitchWidget(
                //   onn: true,
                // ),
                InkWell(
                  onTap: () {},
                  borderRadius:
                      BorderRadius.circular(SizeDefine2.componentborderRadius),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.deepPurple.withOpacity(.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeDefine2.componentborderRadius),
                      ),
                    ),
                    height: 28,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save, size: 14, color: ColorData.primary),
                          SizedBox(width: 5),
                          Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: SizeDefine2.componentTitle,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            AppTabBar(
              tabsTitle: ['First Tab', 'b'],
              selectedTab: "First Tab",
              onSelect: (selectedTab) {},
            ),
            SizedBox(height: 10),
            Expanded(
              child: AppDataGridWidget(
                // enableRowDrag: true,
                // singleCheckBoxColumnName: ['locationname'],
                // editingColumnName: ['bookingnumber'],
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
