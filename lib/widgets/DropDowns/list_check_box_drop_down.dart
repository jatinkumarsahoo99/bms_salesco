// ignore_for_file: prefer_const_constructors

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CheckBox/multi_check_box.dart';
import 'package:bms_salesco/widgets/CustomSearchDropDown/src/popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/providers/SizeDefine.dart';

class ListDropDownCheckBox extends StatelessWidget {
  final List<MultiCheckBoxModel> items;
  final void Function(int, bool)? onChanged;
  final String title;
  final void Function(DropDownValue? val) onSelect;
  final double? widthRatio, dialogWidth, dialogHeight;
  final bool? autoFocus;
  final void Function(bool)? onFocusChange;
  final IconData? iconData;
  final FocusNode? focusNode;
  const ListDropDownCheckBox({
    super.key,
    required this.items,
    required this.title,
    required this.onSelect,
    this.onChanged,
    this.widthRatio,
    this.autoFocus,
    this.dialogWidth,
    this.dialogHeight,
    this.onFocusChange,
    this.focusNode,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    bool hasFocus = (autoFocus ?? false);
    bool menuOpen = false;
    String? selectedVal = getSelectedName();
    return SizedBox(
      width: context.width * (widthRatio ?? .3),
      height: 48,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Stack(
            children: [
              /// icon widget
              Positioned(
                left: 5,
                top: 18,
                child: Icon(
                  iconData ?? Icons.pin_drop,
                  color: Colors.deepPurpleAccent,
                  size: SizeDefine2.componentIcon,
                ),
              ),

              /// selected text
              if (selectedVal != null) ...{
                Positioned(
                  right: 20,
                  top: 18,
                  left: 35,
                  child: Text(
                    selectedVal!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentTitle, color: Colors.black),
                  ),
                ),
              },

              /// floating text and hint text
              AnimatedPositioned(
                right: (hasFocus || selectedVal != null) ? null : 20,
                top: (hasFocus || selectedVal != null) ? 0 : 19,
                left: (hasFocus || selectedVal != null) ? 30 : 35,
                duration: Duration(milliseconds: 200),
                child: (hasFocus || selectedVal != null)
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [.0, 1],
                            colors: const [Colors.white, Color(0xFFF5F5F5)],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeDefine2.componentHint,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentHint, color: const Color(0xFFABABAB)),
                      ),
              ),

              /// dropdown icon
              Positioned(
                right: 0,
                top: 16,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: AnimatedRotation(
                      turns: menuOpen ? 1 : 2,
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        menuOpen ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              /// main inkwell
              Positioned(
                bottom: 0,
                right: 6,
                child: InkWell(
                  focusNode: focusNode,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  autofocus: autoFocus ?? false,
                  onFocusChange: (value) {
                    if (onFocusChange != null) {
                      onFocusChange!(value);
                    }
                    if (!menuOpen) {
                      setState(() {
                        hasFocus = value;
                      });
                    }
                  },
                  onTap: () {
                    setState(() {
                      hasFocus = true;
                      menuOpen = true;
                    });

                    final RenderBox renderBox = context.findRenderObject() as RenderBox;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    final left = offset.dx;
                    final top = offset.dy + renderBox.size.height + 5;
                    final right = left + renderBox.size.width;
                    final width = renderBox.size.width;
                    var tempList = <MultiCheckBoxModel>[];
                    tempList.addAll(items);
                    showMenu(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                          child: SizedBox(
                            height: (dialogHeight ?? 200) - 20,
                            child: StatefulBuilder(builder: (context, re) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// search
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      cursorHeight: 15,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 17, right: 10),
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText: "Search $title",
                                        hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                          color: const Color(0xFFABABAB),
                                        ),
                                        fillColor: Color(0xFFF5F5F5),
                                        filled: true,
                                        prefixIcon: Icon(Icons.search_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                      ),
                                      autofocus: true,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      onChanged: ((value) {
                                        tempList.clear();
                                        if (value.isNotEmpty) {
                                          for (var i = 0; i < items.length; i++) {
                                            if (items[i].val!.value!.toLowerCase().contains(value.toLowerCase())) {
                                              tempList.add(items[i]);
                                            }
                                          }
                                        } else {
                                          tempList.addAll(items);
                                        }
                                        re(() {});
                                      }),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny("  "),
                                      ],
                                    ),
                                  ),

                                  Divider(),

                                  /// list
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: MultiCheckBox(
                                        list: tempList,
                                        canScroll: true,
                                        isHorizontal: false,
                                        width: 12,
                                        onChanged: (index, val) async {
                                          items[index].isSelected = val;
                                          tempList[index].isSelected = val;
                                          if (onChanged != null) {
                                            onChanged!(index, val);
                                          }
                                          selectedVal = getSelectedName();
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    ).then((value) {
                      setState(() {
                        menuOpen = false;
                      });
                      if (focusNode != null) {
                        focusNode?.requestFocus();
                      }
                    });
                  },
                  child: Ink(
                    width: context.width * (widthRatio ?? .3),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hasFocus ? Colors.deepPurpleAccent : Colors.transparent,
                        width: hasFocus ? 1 : 0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF5F5F5),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String? getSelectedName() {
    String? selectedItem;

    var tempLis = items.where((element) => (element.isSelected ?? false)).toList().map((e) => (e.val?.value ?? "")).toList();
    if (tempLis.isNotEmpty) {
      if (tempLis.length <= 2) {
        selectedItem = tempLis.join(', ');
      } else {
        int cout = tempLis.length;
        tempLis.removeRange(2, tempLis.length);
        selectedItem = selectedItem = "${tempLis.join(', ')} +${cout - 2}";
      }
    }
    return selectedItem;
  }
}
