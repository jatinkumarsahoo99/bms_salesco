import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CustomSearchDropDown/src/popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../app/providers/SizeDefine.dart';

class ListDropDown2 extends StatelessWidget {
  final List<DropDownValue> items;
  final String title;
  final double? widthRatio, dialogWidth, dialogHeight;
  final bool? autoFocus;
  const ListDropDown2({
    super.key,
    required this.items,
    required this.title,
    this.widthRatio,
    this.autoFocus,
    this.dialogWidth,
    this.dialogHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      autofocus: autoFocus ?? false,
      child: Ink(
        width: context.width * (widthRatio ?? .15),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
      onTap: () {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        final left = offset.dx;
        final top = offset.dy + renderBox.size.height;
        final right = left + renderBox.size.width;
        final width = renderBox.size.width;
        showMenu(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          useRootNavigator: true,
          position: RelativeRect.fromLTRB(left, top, right, 0.0),
          constraints: BoxConstraints.expand(
            width: dialogWidth ?? width,
            height: dialogHeight ?? 200,
          ),
          items: [
            CustomPopupMenuItem(
              textStyle: TextStyle(color: Colors.black, fontSize: SizeDefine.fontSizeInputField),
              child: Container(
                padding: const EdgeInsets.all(8),
                height: (dialogHeight ?? 200) - 20,
                child: Column(
                  children: [
                    /// search
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        isDense: true,
                        isCollapsed: true,
                        hintText: "Search",
                      ),
                      autofocus: true,
                      style: TextStyle(
                        fontSize: SizeDefine.fontSizeInputField,
                      ),
                      onChanged: ((value) {
                        // if (value.isNotEmpty) {
                        //   tempList.clear();
                        //   for (var i = 0; i < items.length; i++) {
                        //     if (items[i].value!.toLowerCase().contains(value.toLowerCase())) {
                        //       tempList.add(items[i]);
                        //     }
                        //   }
                        // }
                      }),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny("  "),
                      ],
                    ),

                    /// progreesbar
                    // Obx(() {
                    //   return Visibility(
                    //     visible: isLoading.value,
                    //     child: const LinearProgressIndicator(
                    //       minHeight: 3,
                    //     ),
                    //   );
                    // }),

                    const SizedBox(height: 5),

                    /// list
                    Expanded(
                      child: Obx(
                        () {
                          return ListView(
                            shrinkWrap: true,
                            children: tempList
                                .map(
                                  (element) => InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      selected = element;
                                      re(() {});
                                      callback(element);
                                      FocusScope.of(context).requestFocus(inkWellFocusNode);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        element.value ?? "null",
                                        style: TextStyle(
                                          fontSize: SizeDefine.dropDownFontSize - 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
