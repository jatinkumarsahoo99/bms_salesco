import 'package:flutter/material.dart';

import '../app/providers/SizeDefine.dart';

class RadioRow extends StatefulWidget {
  final List items;
  final String groupValue;
  final bool? isVertical;
  final Function? onchange;
  final List<String>? disabledRadios;
  const RadioRow({
    Key? key,
    required this.items,
    required this.groupValue,
    this.onchange,
    this.isVertical,
    this.disabledRadios,
  }) : super(key: key);

  @override
  State<RadioRow> createState() => _RadioRowState();
}

class _RadioRowState extends State<RadioRow> {
  @override
  Widget build(BuildContext context) {
    return (widget.isVertical ?? false)
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
    return widget.items
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                    value: e,
                    groupValue: widget.groupValue,
                    visualDensity:
                    const VisualDensity(horizontal: -4),
                    onChanged: widget.disabledRadios?.contains(e) ?? false
                        ? null
                        : (value) {
                            widget.onchange!(value);
                          }),
                Text(
                  e,
                  style: TextStyle(
                    color: widget.disabledRadios?.contains(e) ?? false ? Colors.grey : Colors.black,fontSize: SizeDefine.labelSize1, fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
