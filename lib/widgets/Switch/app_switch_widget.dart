import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSwitchWidget extends StatelessWidget {
  final bool onn;
  final void Function(bool val)? onChanged;
  final void Function(bool)? onFocusChange;
  final String? msg;
  final double width;
  const AppSwitchWidget({
    super.key,
    required this.onn,
    this.onChanged,
    this.onFocusChange,
    this.width = 50,
    this.msg,
  });

  @override
  Widget build(BuildContext context) {
    bool onnTemp = onn;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatefulBuilder(
          builder: (context, re) {
            return InkWell(
              onTap: () {
                re(() {
                  onnTemp = !onnTemp;
                });
              },
              hoverColor: Colors.black.withOpacity(0.04),
              onFocusChange: onFocusChange,
              focusColor: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20),
              child: Ink(
                width: width,
                height: 23,
                decoration: BoxDecoration(
                  color: onnTemp ? Colors.deepPurpleAccent : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: onnTemp ? 8 : null,
                      right: onnTemp ? null : 8,
                      top: 4,
                      bottom: 4,
                      // duration: const Duration(milliseconds: 300),
                      child: Text(
                        msg ?? (onnTemp ? "on" : "off"),
                        style: GoogleFonts.poppins(
                          color: onnTemp ? Colors.white : const Color(0xFFABABAB),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Positioned(
                      right: onnTemp ? 4 : null,
                      left: onnTemp ? null : 4,
                      top: 4,
                      bottom: 4,
                      // duration: const Duration(seconds: 3),
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
