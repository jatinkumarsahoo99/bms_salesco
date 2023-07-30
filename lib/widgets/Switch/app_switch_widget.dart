import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSwitchWidget extends StatelessWidget {
  final bool onn;
  final void Function(bool val)? onChanged;
  const AppSwitchWidget({
    super.key,
    required this.onn,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool onnTemp = onn;
    return SizedBox(
      width: 45,
      height: 22,
      child: StatefulBuilder(builder: (context, re) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: onnTemp ? Colors.deepPurpleAccent : Color(0xFFf4f4f4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                AnimatedPositioned(
                  left: onnTemp ? 3 : null,
                  right: onnTemp ? null : 3,
                  top: 0,
                  bottom: 0,
                  duration: Duration(seconds: 3),
                  child: Text(
                    onnTemp ? "on" : "off",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  right: onnTemp ? 0 : null,
                  left: onnTemp ? null : 0,
                  top: 0,
                  bottom: 0,
                  duration: Duration(seconds: 3),
                  child: GestureDetector(
                    onTap: () {
                      re(() {
                        onnTemp = !onnTemp;
                      });
                    },
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
