import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTabBar extends StatelessWidget {
  final List<String> tabsTitle;
  final void Function(String? selectedTab) onSelect;
  final String? selectedTab;
  final EdgeInsets? outerPadding, innerPadding;
  const AppTabBar({
    super.key,
    required this.tabsTitle,
    required this.onSelect,
    this.outerPadding,
    this.innerPadding,
    this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    var tempSelectedTab = selectedTab;
    return StatefulBuilder(builder: (context, re) {
      return CupertinoSlidingSegmentedControl<String>(
        padding: outerPadding ?? EdgeInsets.all(4),
        children: {
          for (var element in tabsTitle)
            element: Padding(
              padding: outerPadding ?? EdgeInsets.all(4),
              child: Text(
                element,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
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
