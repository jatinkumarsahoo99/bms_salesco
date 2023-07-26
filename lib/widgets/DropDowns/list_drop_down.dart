// ignore_for_file: prefer_const_constructors

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CustomSearchDropDown/src/popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

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
    DropDownValue? selectedVal = selectedValue;
    return SizedBox(
      width: context.width * (widthRatio ?? .3),
      height: 45,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Stack(
            children: [
              Positioned(
                left: 10,
                top: 17,
                child: Icon(
                  iconData ?? Icons.pin_drop,
                  color: Colors.deepPurpleAccent,
                  size: 16,
                ),
              ),
              AnimatedPositioned(
                right: hasFocus ? null : 20,
                top: hasFocus ? 0 : 18,
                left: hasFocus ? 30 : 35,
                duration: Duration(milliseconds: 200),
                child: hasFocus
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
                              fontSize: 11,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        selectedValue?.value ?? title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 10, color: const Color(0xFFABABAB)),
                      ),
              ),
              Positioned(
                right: 0,
                top: 14,
                child: Icon(
                  hasFocus ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                  color: Color(0xFFABABAB),
                ),
              ),
              Positioned(
                bottom: 0,
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
                    setState(() {
                      hasFocus = value;
                    });
                  },
                  onTap: () {
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
                                      cursorHeight: 10,
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
                                        if (value.isNotEmpty) {
                                          tempList.clear();
                                          for (var i = 0; i < items.length; i++) {
                                            if (items[i].value!.toLowerCase().contains(value.toLowerCase())) {
                                              tempList.add(items[i]);
                                            }
                                          }
                                        }
                                      }),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny("  "),
                                      ],
                                    ),
                                  ),

                                  Divider(),

                                  /// list
                                  Expanded(
                                    child: StatefulBuilder(builder: (context, er) {
                                      return ListView(
                                        shrinkWrap: true,
                                        children: tempList.map(
                                          (element) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                              child: InkWell(
                                                focusColor: Color(0xFFf5f5f5),
                                                onFocusChange: (value) {
                                                  er(() {});
                                                },
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  selectedVal = element;
                                                  setState(() {});
                                                  onSelect(element);
                                                  FocusScope.of(context).requestFocus(focusNode);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                                                  child: Text(
                                                    element.value ?? "null",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 10,
                                                      color: FocusScope.of(context).hasFocus ? Colors.black : Color(0xff959595),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      );
                                    }),
                                  ),
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    );
                  },
                  child: Ink(
                    width: context.width * (widthRatio ?? .3),
                    height: 37,
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
}
