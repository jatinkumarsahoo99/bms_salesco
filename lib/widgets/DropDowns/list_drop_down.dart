import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CustomSearchDropDown/src/popupMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../app/providers/SizeDefine.dart';

class ListDropDown extends StatefulWidget {
  final List<DropDownValue> items;
  final String title;
  final double widthRatio;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final bool autoFocus;
  final DropDownValue? selected;
  final bool isEnable;
  final GlobalKey? widgetKey;
  final double? dialogWidth;
  final double dialogHeight;
  const ListDropDown({
    super.key,
    required this.items,
    required this.title,
    this.widthRatio = .15,
    this.focusNode,
    this.onFocusChange,
    this.autoFocus = false,
    this.selected,
    this.isEnable = true,
    this.widgetKey,
    this.dialogWidth,
    this.dialogHeight = 200,
  });

  @override
  State<ListDropDown> createState() => _ListDropDownState();
}

class _ListDropDownState extends State<ListDropDown> {
  late bool hasCurrentFocus;
  bool isDropDownOpen = false;
  late GlobalKey widgetKey;
  @override
  void initState() {
    hasCurrentFocus = widget.autoFocus;
    widgetKey = widget.widgetKey ?? GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      width: context.width * widget.widthRatio,
      height: 50,
      child: InkWell(
        onTap: () {
          var isLoading = false.obs;
          final RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
          final offset = renderBox.localToGlobal(Offset.zero);
          final left = offset.dx;
          final top = offset.dy + renderBox.size.height;
          final right = left + renderBox.size.width;
          final width = renderBox.size.width;
          var tempList = RxList<DropDownValue>([]);
          tempList.addAll(widget.items);
          showMenu(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            useRootNavigator: true,
            position: RelativeRect.fromLTRB(left, top, right, 0.0),
            constraints: BoxConstraints.expand(
              width: widget.dialogWidth ?? width,
              height: widget.dialogHeight,
            ),
            items: [
              PopupMenuItem(child: TextFormField()),
            ],
          );
        },
      ),
    );
  }
}
