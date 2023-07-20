import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class ListDropDown extends StatefulWidget {
  final double widthRatio;
  final String title;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final bool autoFocus;
  final DropDownValue? selected;
  final bool isEnable;
  const ListDropDown({
    super.key,
    this.title = "",
    this.widthRatio = .15,
    this.focusNode,
    this.onFocusChange,
    this.autoFocus = false,
    this.selected,
    this.isEnable = true,
  });

  @override
  State<ListDropDown> createState() => _ListDropDownState();
}

class _ListDropDownState extends State<ListDropDown> {
  late bool hasCurrentFocus;
  bool isDropDownOpen = false;
  @override
  void initState() {
    hasCurrentFocus = widget.autoFocus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: hasCurrentFocus ? FontWeight.w600 : FontWeight.w400,
            color: widget.isEnable ? Colors.black : Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 3),
        InkWell(
          onFocusChange: (hasFocus) {
            setState(() {
              hasCurrentFocus = hasFocus;
            });
            if (widget.onFocusChange != null) {
              widget.onFocusChange!(hasFocus);
            }
          },
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus,
          focusColor: Colors.white,
          radius: 6,
          onTap: () {
            print(widget.title);
          },
          borderRadius: BorderRadius.circular(6),
          child: Material(
            child: Ink(
              width: context.width * widget.widthRatio,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: hasCurrentFocus ? 2.5 : 1,
                  color: widget.isEnable ? Colors.deepPurple : Colors.grey,
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.selected?.value ?? "",
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Icon(
                    isDropDownOpen ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down,
                    color: widget.isEnable ? Colors.deepPurpleAccent : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
