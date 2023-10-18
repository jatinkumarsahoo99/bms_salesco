import 'package:bms_salesco/app/providers/SizeDefine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool val)? onChanged;
  final double width;
  const AppCheckBox({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool tempVal = value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatefulBuilder(
          builder: (context, re) {
            return Checkbox(
              value: tempVal,
              onChanged: (newVal) {
                tempVal = newVal ?? false;
                re(() {});
                if (onChanged != null) {
                  onChanged!(tempVal);
                }
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
        ),
        SizedBox(width: width),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: SizeDefine2.componentTitle,
            ),
          ),
        ),
      ],
    );
  }
}
