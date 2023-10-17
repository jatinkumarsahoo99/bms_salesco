// ignore_for_file: prefer_const_constructors

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CustomSearchDropDown/src/popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/providers/ColorData.dart';
import '../../app/providers/SizeDefine.dart';

class ListDropDown extends StatelessWidget {
  final List<DropDownValue> items;
  final String title;
  final void Function(DropDownValue? val) onSelect;
  final double? widthRatio, dialogWidth, dialogHeight;
  final bool? autoFocus;
  final void Function(bool)? onFocusChange;
  final IconData? iconData;
  final DropDownValue? selectedValue;
  final FocusNode? focusNode;
  const ListDropDown({
    super.key,
    required this.items,
    required this.title,
    required this.onSelect,
    this.widthRatio,
    this.selectedValue,
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
    DropDownValue? selectedVal = selectedValue;
    return SizedBox(
      width: context.width * (widthRatio ?? .3),
      height: SizeDefine2.componentHeight,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Stack(
            children: [
              /// icon widget
              Positioned(
                left: 5,
                top: (SizeDefine2.componentHeight-9)/2,
                child: Icon(
                  iconData ?? Icons.pin_drop,
                  color: ColorData.primary,
                  size: SizeDefine2.componentIcon,
                ),
              ),

              /// selected text
              if (selectedVal != null) ...{
                Positioned(
                  right: 20,
                  top: 14,
                  left: 35,
                  child: Text(
                    selectedVal?.value ?? title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentTitle, color: Colors.black),
                  ),
                ),
              },

              /// floating text and hint text
              AnimatedPositioned(
                right: (hasFocus || selectedVal != null) ? null : 20,
                top: (hasFocus || selectedVal != null) ? 0 : 14,
                left: (hasFocus || selectedVal != null) ? 30 : 35,
                duration: Duration(milliseconds: 200),
                child: (hasFocus || selectedVal != null)
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [.0, 1],
                            colors: [Colors.white, const Color(0xFFF5F5F5)],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeDefine2.componentHint,
                              color: ColorData.primary,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeDefine2.componentHint,
                          color: ColorData.hintText,
                        ),
                      ),
              ),

              /// dropdown icon
              Positioned(
                right: 0,
                top:  (SizeDefine2.componentHeight-9)/2,
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColorData.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AnimatedRotation(
                      turns: menuOpen ? 1 : 2,
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        menuOpen ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                        color: Colors.white,
                        size: SizeDefine2.componentIcon,
                      ),
                    ),
                  ),
                ),
              ),

              /// main inkwell
              Positioned(
                bottom: 0,
                right: 6,
                left: 0,
                child: InkWell(
                  focusNode: focusNode,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(SizeDefine2.componentborderRadius),
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
                    var tempList = <DropDownValue>[];
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
                                        fontSize: SizeDefine2.componentTitle,
                                        color: Colors.black,
                                      ),
                                      onChanged: ((value) {
                                        tempList.clear();
                                        if (value.isNotEmpty) {
                                          for (var i = 0; i < items.length; i++) {
                                            if (items[i].value!.toLowerCase().contains(value.toLowerCase())) {
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
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: tempList.map(
                                        (element) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: InkWell(
                                              focusColor: Color(0xFFf5f5f5),
                                              borderRadius: BorderRadius.circular(12),
                                              onTap: () {
                                                Navigator.pop(context);
                                                selectedVal = element;
                                                setState(() {});
                                                onSelect(element);
                                                if (focusNode != null) {
                                                  focusNode?.requestFocus();
                                                }
                                                // FocusScope.of(context).requestFocus(focusNode);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                                                child: Text(
                                                  element.value ?? "null",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: SizeDefine2.componentTitle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
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
                    height: SizeDefine2.componentHeight-8 ,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hasFocus ? ColorData.primary : Colors.transparent,
                        width: hasFocus ? 1 : 0,
                      ),
                      borderRadius: BorderRadius.circular(SizeDefine2.componentborderRadius),
                      color: ColorData.bgComponent,
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
}
