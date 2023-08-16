import 'package:bms_salesco/app/providers/ColorData.dart';
import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final double? widthRatio;
  final String? label;
  const NormalTextField({
    super.key,
    required this.controller,
    this.autoFocus,
    this.focusNode,
    this.widthRatio,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     width: context.width * (widthRatio ?? .3),
      height: SizeDefine2.componentHeight,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: TextFormField(
          focusNode: focusNode,
          autofocus: autoFocus ?? false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusColor: ColorData.bgComponent,
            hoverColor: ColorData.bgComponent,
            fillColor: ColorData.bgComponent,
            filled: true,
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(right: 10),
            prefixIcon: Icon(Icons.crisis_alert_sharp, size: SizeDefine2.componentIcon),
            prefixIconColor: ColorData.primary,
            labelText: label ?? "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeDefine2.componentborderRadius),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ColorData.primary,
              ),
            ),
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentHint, color: ColorData.hintText),
            floatingLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: SizeDefine2.componentHint+2,
              color: ColorData.primary,
            ),
          ),
          style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentTitle, color: Colors.black),
        ),
      ),
    );
  }
}
