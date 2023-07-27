import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTabBar extends StatelessWidget {
  final List<String> tabsTitle;
  final void Function(String? selectedTab) onSelect;
  final String? selectedTab;
  const AppTabBar({
    super.key,
    required this.tabsTitle,
    required this.onSelect,
    this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    var tempSelectedTab = selectedTab;
    return StatefulBuilder(builder: (context, re) {
      return CupertinoSlidingSegmentedControl<String>(
        children: {
          for (var element in tabsTitle)
            element: Text(
              element,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                // color: Color
              ),
            )
        },
        groupValue: tempSelectedTab ?? tabsTitle.first,
        onValueChanged: (val) {
          onSelect(val);
          tempSelectedTab = val;
          re(() {});
        },
      );
    });
  }
}
