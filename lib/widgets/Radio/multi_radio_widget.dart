import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiAppRadio extends StatelessWidget {
  final List items;
  final String groupValue;
  final bool? isVertical;
  final Function? onchange;
  final List<String>? disabledRadios;
  final double width;
  const MultiAppRadio({
    Key? key,
    required this.items,
    required this.groupValue,
    this.onchange,
    this.width = 0,
    this.isVertical,
    this.disabledRadios,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (isVertical ?? false)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: buildRadio(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: buildRadio(),
          );
  }

  buildRadio() {
    return items
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: e,
                  splashRadius: 15,
                  groupValue: groupValue,
                  onChanged: disabledRadios?.contains(e) ?? false
                      ? null
                      : (value) {
                          onchange!(value);
                        },
                ),
                SizedBox(width: width),
                Text(
                  e,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: disabledRadios?.contains(e) ?? false ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
