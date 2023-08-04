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
      width: (context.width * (widthRatio ?? .2)),
      height: 48,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: TextFormField(
          focusNode: focusNode,
          autofocus: autoFocus ?? false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusColor: const Color(0xFFF5F5F5),
            hoverColor: const Color(0xFFF5F5F5),
            fillColor: const Color(0xFFF5F5F5),
            filled: true,
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(right: 10),
            prefixIcon: const Icon(Icons.crisis_alert_sharp, size: 16),
            prefixIconColor: Colors.deepPurpleAccent,
            labelText: label ?? "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.deepPurpleAccent,
              ),
            ),
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentHint, color: const Color(0xFFABABAB)),
            floatingLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: SizeDefine2.componentHint,
              color: Colors.deepPurpleAccent,
            ),
          ),
          style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: SizeDefine2.componentTitle, color: Colors.black),
        ),
      ),
    );
  }
}
